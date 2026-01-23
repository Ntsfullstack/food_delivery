import 'package:flutter/material.dart';
import 'package:food_delivery_app/base/base_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:share_plus/share_plus.dart';

class AdminReportsController extends BaseController {
  final fromDate = DateTime.now().subtract(const Duration(days: 7)).obs;
  final toDate = DateTime.now().obs;
  final month = DateTime.now().month.obs;
  final year = DateTime.now().year.obs;

  final reportType = 'monthly'.obs;
  final csvText = ''.obs;
  final headers = <String>[].obs;
  final rows = <List<String>>[].obs;
  final summary = <String, String>{}.obs;

  Future<void> fetchOrdersCsv() async {
    try {
      final csv = await orderManagementRepositories.getOrdersReportCsv(
          fromDate.value, toDate.value);
      csvText.value = csv;
      _parseAndStore(csv);
    } catch (e) {
      showError(message: 'Không thể tải báo cáo đơn hàng');
    } finally {
    }
  }

  Future<void> fetchMonthlyCsv() async {
    try {
      final csv = await orderManagementRepositories.getMonthlySalesCsv(
          month: month.value, year: year.value);
      csvText.value = csv;
      _parseAndStore(csv);
    } catch (e) {
      showError(message: 'Không thể tải báo cáo tháng');
    } finally {
    }
  }

  List<List<String>> parseCsv(String csv) {
    final lines =
        csv.split(RegExp(r'\r?\n')).where((l) => l.trim().isNotEmpty).toList();
    return lines
        .map((l) => l.split(',').map((c) => c.trim()).toList())
        .toList();
  }

  void _parseAndStore(String csv) {
    final table = parseCsv(csv);
    if (table.isEmpty) {
      headers.value = [];
      rows.value = [];
      summary.clear();
      return;
    }
    headers.value = List<String>.from(table.first);
    final dataRows = table.length > 1 ? table.sublist(1) : <List<String>>[];
    rows.value = dataRows.map((r) => List<String>.from(r)).toList();
    final sectionIdx = headers.indexOf('section');
    final metricIdx = headers.indexOf('metric');
    final valueIdx = headers.indexOf('value');
    summary.clear();
    for (final r in rows) {
      if (sectionIdx >= 0 &&
          r.length > sectionIdx &&
          r[sectionIdx] == 'summary') {
        final m = metricIdx >= 0 && r.length > metricIdx ? r[metricIdx] : '';
        final v = valueIdx >= 0 && r.length > valueIdx ? r[valueIdx] : '';
        if (m.isNotEmpty) summary[m] = v;
      }
    }
  }

  Future<void> pickFromDate() async {
    final ctx = Get.context!;
    final picked = await showDatePicker(
        context: ctx,
        initialDate: fromDate.value,
        firstDate: DateTime(2020),
        lastDate: DateTime.now());
    if (picked != null) fromDate.value = picked;
  }

  Future<void> pickToDate() async {
    final ctx = Get.context!;
    final picked = await showDatePicker(
        context: ctx,
        initialDate: toDate.value,
        firstDate: DateTime(2020),
        lastDate: DateTime.now());
    if (picked != null) toDate.value = picked;
  }

  String get periodLabel {
    if (reportType.value == 'monthly') {
      return 'Tháng ${month.value}/${year.value}';
    }
    final df = DateFormat('dd/MM/yyyy');
    return '${df.format(fromDate.value)} - ${df.format(toDate.value)}';
  }

  Future<void> saveAndShareCsv() async {
    try {
      final dir = await getTemporaryDirectory();
      final file = File(
          '${dir.path}/report_${DateTime.now().millisecondsSinceEpoch}.csv');
      await file.writeAsString(csvText.value);
      await Share.shareXFiles([XFile(file.path)],
          text: 'Báo cáo ${periodLabel}');
    } catch (e) {
      showError(message: 'Không thể lưu/chia sẻ CSV');
    }
  }
}
