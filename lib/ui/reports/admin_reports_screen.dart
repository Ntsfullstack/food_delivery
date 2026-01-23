import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'admin_reports_controller.dart';

class AdminReportsScreen extends GetView<AdminReportsController> {
  const AdminReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Báo cáo doanh thu'),
        actions: [
          IconButton(
            icon: const Icon(Icons.ios_share),
            onPressed: () => controller.saveAndShareCsv(),
            tooltip: 'Xuất CSV',
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Obx(() {
              return Column(
                children: [
                  Row(
                    children: [
                      ChoiceChip(
                        label: const Text('Theo tháng'),
                        selected: controller.reportType.value == 'monthly',
                        onSelected: (v) =>
                            controller.reportType.value = 'monthly',
                      ),
                      const SizedBox(width: 8),
                      ChoiceChip(
                        label: const Text('Khoảng ngày'),
                        selected: controller.reportType.value == 'range',
                        onSelected: (v) =>
                            controller.reportType.value = 'range',
                      ),
                      const Spacer(),
                      Text(controller.periodLabel),
                    ],
                  ),
                  const SizedBox(height: 12),
                  if (controller.reportType.value == 'monthly')
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<int>(
                            value: controller.month.value,
                            items: List.generate(12, (i) => i + 1)
                                .map((m) => DropdownMenuItem(
                                    value: m, child: Text('Tháng $m')))
                                .toList(),
                            onChanged: (v) => controller.month.value =
                                v ?? controller.month.value,
                            decoration: const InputDecoration(
                                labelText: 'Tháng',
                                border: OutlineInputBorder()),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: DropdownButtonFormField<int>(
                            value: controller.year.value,
                            items:
                                List.generate(6, (i) => DateTime.now().year - i)
                                    .map((y) => DropdownMenuItem(
                                        value: y, child: Text('Năm $y')))
                                    .toList(),
                            onChanged: (v) => controller.year.value =
                                v ?? controller.year.value,
                            decoration: const InputDecoration(
                                labelText: 'Năm', border: OutlineInputBorder()),
                          ),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () => controller.fetchMonthlyCsv(),
                          child: const Text('Xem'),
                        ),
                      ],
                    )
                  else
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () => controller.pickFromDate(),
                            child: InputDecorator(
                              decoration: const InputDecoration(
                                  labelText: 'Từ ngày',
                                  border: OutlineInputBorder()),
                              child: Text(
                                  '${controller.fromDate.value.toLocal()}'
                                      .split(' ')[0]),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: InkWell(
                            onTap: () => controller.pickToDate(),
                            child: InputDecorator(
                              decoration: const InputDecoration(
                                  labelText: 'Đến ngày',
                                  border: OutlineInputBorder()),
                              child: Text('${controller.toDate.value.toLocal()}'
                                  .split(' ')[0]),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () => controller.fetchOrdersCsv(),
                          child: const Text('Xem'),
                        ),
                      ],
                    ),
                ],
              );
            }),
          ),
          Obx(() {
            final sm = controller.summary;
            if (sm.isEmpty) return const SizedBox.shrink();
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Expanded(
                      child:
                          _statCard('Doanh thu', sm['total_revenue'] ?? '0')),
                  const SizedBox(width: 8),
                  Expanded(
                      child: _statCard('Trung bình/ngày',
                          sm['average_daily_revenue'] ?? '0')),
                ],
              ),
            );
          }),
          Expanded(
            child: Obx(() {
              if (controller.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (controller.csvText.isEmpty) {
                return const Center(child: Text('Chưa có dữ liệu'));
              }
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: controller.headers
                      .map((h) => DataColumn(label: Text(h)))
                      .toList(),
                  rows: controller.rows
                      .map((r) => DataRow(
                          cells: r
                              .map<DataCell>((c) => DataCell(Text(c)))
                              .toList()))
                      .toList(),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _statCard(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2))
          ]),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: const TextStyle(color: Colors.grey)),
        const SizedBox(height: 6),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w600))
      ]),
    );
  }
}
