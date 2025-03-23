import 'package:food_delivery_app/base/base_controller.dart';
import 'package:food_delivery_app/models/dashboard/dashboard.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Invoice {
  final String id;
  final String orderId;
  final String customerName;
  final DateTime date;
  final double amount;
  final String status;
  final String paymentMethod;

  Invoice({
    required this.id,
    required this.orderId,
    required this.customerName,
    required this.date,
    required this.amount,
    required this.status,
    required this.paymentMethod,
  });
}

class InvoiceManagementController extends BaseController {
  final RxList<Invoice> invoices = <Invoice>[].obs;

  final RxString searchQuery = ''.obs;
  final RxString selectedStatus = 'Tất cả'.obs;
  final RxList<String> statusList = <String>['Tất cả', 'Đã thanh toán', 'Chưa thanh toán', 'Đã hủy'].obs;
  
  // Date range filter
  final Rx<DateTime?> startDate = Rx<DateTime?>(null);
  final Rx<DateTime?> endDate = Rx<DateTime?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchInvoices();
  }

  Future<void> fetchInvoices() async {
    try {
      showLoading(message: 'Đang tải dữ liệu...');
      final response = await dashboardRepositories.getDashboard();
      
      if (response.data != null && response.data!.recentActivity != null) {
        final allOrders = response.data!.recentActivity!.recentOrders ?? [];
        
        // Chuyển đổi đơn hàng thành hóa đơn
        final List<Invoice> invoiceList = [];
        for (var i = 0; i < allOrders.length; i++) {
          final order = allOrders[i];
          final invoiceStatus = order.status == 'Hoàn thành' ? 'Đã thanh toán' : 
                               (order.status == 'Đã hủy' ? 'Đã hủy' : 'Chưa thanh toán');
          
          invoiceList.add(Invoice(
            id: 'INV${100 + i}',
            orderId: order.orderId.toString() ?? '',
            customerName: order.customerName ?? 'Khách hàng',
            date: order.orderDate ?? DateTime.now(),
            amount: double.tryParse(order.totalPrice ?? '0') ?? 0.0,
            status: invoiceStatus,
            paymentMethod: ['Tiền mặt', 'Chuyển khoản', 'Thẻ tín dụng'][i % 3],
          ));
        }
        
        invoices.value = invoiceList;
      }
    } catch (e) {
      showError(message: 'Không thể tải danh sách hóa đơn: $e');
    } finally {
      hideLoading();
    }
  }

  List<Invoice> get filteredInvoices {
    return invoices.where((invoice) {
      // Lọc theo trạng thái
      if (selectedStatus.value != 'Tất cả' && 
          invoice.status != selectedStatus.value) {
        return false;
      }
      
      // Lọc theo khoảng thời gian
      if (startDate.value != null && invoice.date.isBefore(startDate.value!)) {
        return false;
      }
      
      if (endDate.value != null) {
        // Thêm 1 ngày vào endDate để bao gồm cả ngày kết thúc
        final adjustedEndDate = DateTime(endDate.value!.year, endDate.value!.month, endDate.value!.day + 1);
        if (invoice.date.isAfter(adjustedEndDate)) {
          return false;
        }
      }
      
      // Lọc theo từ khóa tìm kiếm
      if (searchQuery.value.isNotEmpty) {
        final query = searchQuery.value.toLowerCase();
        final id = invoice.id.toLowerCase();
        final orderId = invoice.orderId.toLowerCase();
        final customerName = invoice.customerName.toLowerCase();
        return id.contains(query) || 
               orderId.contains(query) || 
               customerName.contains(query);
      }
      
      return true;
    }).toList();
  }

  void setStatus(String status) {
    selectedStatus.value = status;
  }

  void setSearchQuery(String query) {
    searchQuery.value = query;
  }

  void setDateRange(DateTime? start, DateTime? end) {
    startDate.value = start;
    endDate.value = end;
  }

  Future<void> refreshInvoices() async {
    await fetchInvoices();
  }

  String formatCurrency(double amount) {
    final formatter = NumberFormat.currency(locale: 'vi_VN', symbol: 'VNĐ');
    return formatter.format(amount);
  }

  Future<void> markAsPaid(String invoiceId) async {
    try {
      showLoading(message: 'Đang cập nhật hóa đơn...');
      
      // Giả lập API call
      await Future.delayed(const Duration(seconds: 1));
      
      // Cập nhật trạng thái hóa đơn
      final index = invoices.indexWhere((invoice) => invoice.id == invoiceId);
      if (index != -1) {
        final updatedInvoice = Invoice(
          id: invoices[index].id,
          orderId: invoices[index].orderId,
          customerName: invoices[index].customerName,
          date: invoices[index].date,
          amount: invoices[index].amount,
          status: 'Đã thanh toán',
          paymentMethod: invoices[index].paymentMethod,
        );
        
        invoices[index] = updatedInvoice;
      }
      
      showSuccess(message: 'Cập nhật hóa đơn thành công');
    } catch (e) {
      showError(message: 'Không thể cập nhật hóa đơn: $e');
    } finally {
      hideLoading();
    }
  }
}