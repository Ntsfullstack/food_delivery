// import '../../base/base_controller.dart';
//
// class PaymentMethodController extends BaseController {
//   final paymentMethods = <PaymentMethod>[].obs;
//   @override
//   late var isLoading = false;
//
//   @override
//   void onInit() {
//     super.onInit();
//     loadPaymentMethods();
//   }
//
//   Future<void> loadPaymentMethods() async {
//     try {
//       isLoading = true;
//       // Simulate network call
//       await Future.delayed(Duration(seconds: 2));
//       // Load payment methods from API or local storage
//       paymentMethods.value = await fetchPaymentMethods();
//     } catch (e) {
//       print('Error loading payment methods: $e');
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   Future<List<PaymentMethod>> fetchPaymentMethods() async {
//     // Replace with actual API call or data fetching logic
//     return [
//       PaymentMethod(name: 'Credit Card', details: 'Visa, MasterCard'),
//       PaymentMethod(name: 'PayPal', details: 'Pay with your PayPal account'),
//     ];
//   }
//
//   void selectPaymentMethod(PaymentMethod method) {
//     // Handle payment method selection
//     print('Selected payment method: ${method.name}');
//   }
// }