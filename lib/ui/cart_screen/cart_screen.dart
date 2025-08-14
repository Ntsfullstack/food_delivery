import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/x_utils/currency_formatter.dart';
import 'package:food_delivery_app/x_utils/extension/cart.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:food_delivery_app/models/cart/cart.dart';

import 'cart_controller.dart';

class CartScreen extends GetView<CartController> {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'cart'.tr,
          style: GoogleFonts.poppins(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF303030),
          ),
        ),
        actions: [
          Obx(() => controller.cartItems.isNotEmpty
              ? IconButton(
            icon: Container(
              padding: EdgeInsets.all(8.r),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.delete_outline_rounded,
                size: 20.sp,
                color: Colors.red[400],
              ),
            ),
            onPressed: () => _showClearCartDialog(context),
          )
              : const SizedBox()),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.cartItems.isEmpty) {
          return _buildEmptyCart();
        }

        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16.w),
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    // Delivery section
                    _buildDeliverySection(),

                    // Cart items
                    ListView.builder(
                      itemCount: controller.cartItems.length,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final item = controller.cartItems[index];
                        return _buildCartItem(item);
                      },
                    ),

                    // Promotion code section
                    _buildPromoCodeSection(),

                    SizedBox(height: 16.h),
                    _buildCoinSection(),
                    SizedBox(height: 16.h),
                    _buildTotalSection(),
                  ],
                ),
              ),
            ),
            _buildBottomBar(),
          ],
        );
      }),
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            'https://cdni.iconscout.com/illustration/premium/thumb/empty-cart-7359557-6024626.png',
            width: 200.w,
            height: 200.h,
          ),
          SizedBox(height: 16.h),
          Text(
            'Giỏ hàng của bạn đang trống',
            style: GoogleFonts.poppins(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF303030),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Hãy thêm một vài món ăn ngon vào giỏ hàng!',
            style: GoogleFonts.poppins(
              fontSize: 14.sp,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),
          ElevatedButton(
            onPressed: () => Get.back(),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF7043),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 14.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              elevation: 0,
            ),
            child: Text(
              'Khám phá món ăn',
              style: GoogleFonts.poppins(
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliverySection() {
    return Container(
      padding: EdgeInsets.all(16.r),
      margin: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.location_on_rounded,
                color: const Color(0xFFFF7043),
                size: 22.sp,
              ),
              SizedBox(width: 12.w),
              Text(
                'location'.tr,
                style: GoogleFonts.poppins(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF303030),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: Obx(() {
                  final address = controller.profileController.profile.value?.address;
                  return Text(
                    address ?? 'Chưa cập nhật địa chỉ',
                    style: GoogleFonts.poppins(
                      fontSize: 13.sp,
                      color: Colors.grey[600],
                    ),
                  );
                }),
              ),
              SizedBox(width: 8.w),
              Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  Icons.edit_outlined,
                  color: const Color(0xFFFF7043),
                  size: 16.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCartItem(CartItem item) {
    return Container(
      padding: EdgeInsets.all(12.r),
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Product Image with stacked quantity
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: CachedNetworkImage(
                  imageUrl: item.imageUrl ?? "https://via.placeholder.com/150",
                  width: 80.w,
                  height: 80.w,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: Colors.grey[200],
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFFFF7043),
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey[200],
                    child: Icon(Icons.error, color: Colors.grey[400]),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(4.r),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF7043),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10.r),
                      topRight: Radius.circular(10.r),
                    ),
                  ),
                  child: Text(
                    'x${item.quantity ?? 1}',
                    style: GoogleFonts.poppins(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(width: 12.w),

          // Product Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        item.name ?? "No Name",
                        style: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF303030),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    // Chỉ hiển thị nút xóa nếu cartId hợp lệ
                    if (item.cartId != null)
                      IconButton(
                        icon: Icon(
                          Icons.delete_outline_rounded,
                          color: Colors.grey[400],
                          size: 20.sp,
                        ),
                        onPressed: () => controller.removeItem(item),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                  ],
                ),

                SizedBox(height: 4.h),

                // Show size or variant if available
                if (item.variant != null && item.variant!.isNotEmpty)
                  Container(
                    padding:
                    EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                    margin: EdgeInsets.only(bottom: 8.h),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Text(
                      item.variant!,
                      style: GoogleFonts.poppins(
                        fontSize: 10.sp,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Price
                    Text(
                      CurrencyFormatter.format(item.price ?? 0),
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFFFF7043),
                      ),
                    ),

                    // Quantity controls - chỉ hiển thị nếu cartId hợp lệ
                    if (item.cartId != null)
                      Row(
                        children: [
                          _buildQuantityButton(
                            icon: Icons.remove,
                            onPressed: () => controller.changeQuantity(item, (item.quantity ?? 1) - 1),
                            enabled: (item.quantity ?? 0) > 1,
                          ),
                          Container(
                            width: 32.w,
                            alignment: Alignment.center,
                            child: Text(
                              '${item.quantity ?? 1}',
                              style: GoogleFonts.poppins(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          _buildQuantityButton(
                            icon: Icons.add,
                            onPressed: () => controller.changeQuantity(item, (item.quantity ?? 1) + 1),
                            enabled: true,
                          ),
                        ],
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityButton({
    required IconData icon,
    required VoidCallback onPressed,
    required bool enabled,
  }) {
    return InkWell(
      onTap: enabled ? onPressed : null,
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        width: 28.w,
        height: 28.w,
        decoration: BoxDecoration(
          color: enabled ? Colors.grey[200] : Colors.grey[100],
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Icon(
          icon,
          size: 16.sp,
          color: enabled ? const Color(0xFF303030) : Colors.grey[400],
        ),
      ),
    );
  }

  Widget _buildPromoCodeSection() {
    return Container(
      padding: EdgeInsets.all(16.r),
      margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            Icons.discount_rounded,
            color: const Color(0xFFFF7043),
            size: 22.sp,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              'Sử dụng mã giảm giá',
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF303030),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16.sp,
              color: const Color(0xFFFF7043),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCoinSection() {
    return Obx(() {
      final availableCoins = controller.availableCoins.value;
      final isUsingCoins = controller.useCoin.value;
      final coinsToUse = controller.coinsToUse.value;

      return Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Sử dụng xu',
                  style: GoogleFonts.poppins(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Switch(
                  value: isUsingCoins,
                  onChanged: availableCoins > 0
                      ? controller.toggleUseCoin
                      : null,
                  activeColor: const Color(0xFFFF7043),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Text(
              'Số xu hiện có: $availableCoins xu',
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                color: Colors.grey[600],
              ),
            ),
            if (isUsingCoins && coinsToUse > 0) ...[
              SizedBox(height: 8.h),
              Text(
                'Số xu sẽ sử dụng: $coinsToUse xu',
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  color: const Color(0xFFFF7043),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ],
        ),
      );
    });
  }

  Widget _buildTotalSection() {
    return Obx(() {
      final subtotal = controller.totalAmount.value;
      final discount = controller.useCoin.value ? controller.coinsToUse.value : 0;
      final total = subtotal - discount;

      return Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            _buildPriceRow('Tạm tính', subtotal),
            if (discount > 0) ...[
              SizedBox(height: 8.h),
              _buildPriceRow('Giảm giá (xu)', discount.toDouble(), isDiscount: true),
            ],
            SizedBox(height: 8.h),
            _buildPriceRow('Tổng cộng', total, isTotal: true),
          ],
        ),
      );
    });
  }

  Widget _buildPriceRow(String label, double amount, {bool isTotal = false, bool isDiscount = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: isTotal ? 16.sp : 14.sp,
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.w500,
            color: isTotal ? Colors.black : Colors.grey[600],
          ),
        ),
        Text(
          isDiscount ? '- ${CurrencyFormatter.format(amount)}' : CurrencyFormatter.format(amount),
          style: GoogleFonts.poppins(
            fontSize: isTotal ? 16.sp : 14.sp,
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.w500,
            color: isDiscount
                ? const Color(0xFFFF7043)
                : (isTotal ? Colors.black : Colors.grey[600]),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Total amount
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tổng thanh toán:',
                  style: GoogleFonts.poppins(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF303030),
                  ),
                ),
                Obx(() {
                  // Calculate final amount with coin discount
                  final subtotal = controller.totalAmount.value;
                  final discount = controller.useCoin.value ? controller.coinsToUse.value : 0;
                  final finalAmount = subtotal - discount;
                  return Text(
                    CurrencyFormatter.format(finalAmount.toDouble()),
                    style: GoogleFonts.poppins(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFFFF7043),
                    ),
                  );
                }),
              ],
            ),

            SizedBox(height: 16.h),

            // Payment method selection
            _buildPaymentMethodSelection(),

            SizedBox(height: 16.h),

            // Deposit amount input (for non-direct payments)
            Obx(() {
              if (controller.selectedPaymentMethod.value != 'direct') {
                return _buildDepositAmountInput();
              }
              return const SizedBox.shrink();
            }),

            SizedBox(height: 16.h),

            // Payment Summary
            _buildPaymentSummary(),

            SizedBox(height: 16.h),

            // Checkout button
            SizedBox(
              width: double.infinity,
              height: 56.h,
              child: ElevatedButton(
                onPressed: () => _showCheckoutDialog(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF7043),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'Đặt hàng & Thanh toán',
                  style: GoogleFonts.poppins(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethodSelection() {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Phương thức thanh toán',
            style: GoogleFonts.poppins(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF303030),
            ),
          ),
          SizedBox(height: 12.h),
          Obx(() => Row(
            children: [
              // Fixed: Remove nested Expanded widgets
              _buildPaymentMethodButton(
                icon: Icons.credit_card_rounded,
                label: 'Thanh toán trực tiếp',
                onPressed: () => controller.selectPaymentMethod('direct'),
                isSelected: controller.selectedPaymentMethod.value == 'direct',
                flex: 1,
              ),
              SizedBox(width: 12.w),
              _buildPaymentMethodButton(
                icon: Icons.qr_code,
                label: 'ZaloPay',
                onPressed: () => controller.selectPaymentMethod('zalopay'),
                isSelected: controller.selectedPaymentMethod.value == 'zalopay',
                flex: 1,
              ),
            ],
          )),
        ],
      ),
    );
  }

  Widget _buildDepositAmountInput() {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Số tiền đặt cọc',
            style: GoogleFonts.poppins(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF303030),
            ),
          ),
          SizedBox(height: 8.h),
          Obx(() => TextField(
            keyboardType: TextInputType.number,
            controller: TextEditingController(
              text: controller.depositAmount.value > 0
                  ? controller.depositAmount.value.toStringAsFixed(0)
                  : '',
            ),
            decoration: InputDecoration(
              hintText: 'Nhập số tiền đặt cọc (VND)',
              hintStyle: GoogleFonts.poppins(
                fontSize: 14.sp,
                color: Colors.grey[400],
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
              suffixText: 'VND',
            ),
            onChanged: (value) {
              final amount = double.tryParse(value) ?? 0;
              controller.updateDepositAmount(amount);
            },
          )),
          SizedBox(height: 8.h),
          Obx(() {
            final subtotal = controller.totalAmount.value;
            final discount = controller.useCoin.value ? controller.coinsToUse.value : 0;
            final total = subtotal - discount;
            final remaining = total - controller.depositAmount.value;

            return Text(
              'Số tiền còn lại: ${CurrencyFormatter.format(remaining.toDouble())}',
              style: GoogleFonts.poppins(
                fontSize: 12.sp,
                color: Colors.grey[600],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    bool isSelected = false,
    int flex = 1,
  }) {
    return Flexible(
      flex: flex,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFFF7043) : Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: isSelected ? Colors.transparent : Colors.grey[200]!,
              width: 1.w,
            ),
            boxShadow: [
              if (isSelected)
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 20.sp,
                color: isSelected ? Colors.white : const Color(0xFF303030),
              ),
              SizedBox(height: 8.h),
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: isSelected ? Colors.white : const Color(0xFF303030),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentSummary() {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tóm tắt thanh toán',
            style: GoogleFonts.poppins(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF303030),
            ),
          ),
          Obx(() {
            final paymentMethod = controller.selectedPaymentMethod.value;
            final depositAmount = controller.depositAmount.value;
            final subtotal = controller.totalAmount.value;
            final discount = controller.useCoin.value ? controller.coinsToUse.value : 0;
            final total = subtotal - discount;

            return Column(
              children: [
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Text(
                //       'Phương thức thanh toán:',
                //       style: GoogleFonts.poppins(
                //         fontSize: 14.sp,
                //         color: Colors.grey[600],
                //       ),
                //     ),
                //     Text(
                //       paymentMethod == 'direct' ? 'Thanh toán trực tiếp' : 'ZaloPay',
                //       style: GoogleFonts.poppins(
                //         fontSize: 14.sp,
                //         fontWeight: FontWeight.w500,
                //         color: const Color(0xFF303030),
                //       ),
                //     ),
                //   ],
                // ),
                // SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Số tiền đặt cọc:',
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                    Text(
                      CurrencyFormatter.format(depositAmount.toDouble()),
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF303030),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tổng thanh toán:',
                      style: GoogleFonts.poppins(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF303030),
                      ),
                    ),
                    Text(
                      CurrencyFormatter.format(total.toDouble()),
                      style: GoogleFonts.poppins(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFFFF7043),
                      ),
                    ),
                  ],
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  void _showCheckoutDialog() {
    showDialog(
      context: Get.context!,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'Xác nhận đặt hàng',
          style: GoogleFonts.poppins(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF303030),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(() {
              final paymentMethod = controller.selectedPaymentMethod.value;
              final depositAmount = controller.depositAmount.value;
              final subtotal = controller.totalAmount.value;
              final discount = controller.useCoin.value ? controller.coinsToUse.value : 0;
              final total = subtotal - discount;

              return Column(
                children: [
                  // Payment method
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Phương thức:',
                        style: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        paymentMethod == 'direct' ? 'Thanh toán trực tiếp' : 'ZaloPay',
                        style: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF303030),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  
                  // Deposit amount (if applicable)
                  if (paymentMethod != 'direct' && depositAmount > 0) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Đặt cọc:',
                          style: GoogleFonts.poppins(
                            fontSize: 14.sp,
                            color: Colors.grey[600],
                          ),
                        ),
                        Text(
                          CurrencyFormatter.format(depositAmount.toDouble()),
                          style: GoogleFonts.poppins(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF303030),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                  ],
                  
                  // Total amount
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tổng thanh toán:',
                        style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF303030),
                        ),
                      ),
                      Text(
                        CurrencyFormatter.format(total.toDouble()),
                        style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFFFF7043),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }),
            Text(
              'Bạn có chắc chắn muốn đặt hàng và thanh toán?',
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                color: Colors.grey[700],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Hủy',
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              controller.placeOrder();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF7043),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text(
              'order_now'.tr,
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showClearCartDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'Xóa giỏ hàng',
          style: GoogleFonts.poppins(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF303030),
          ),
        ),
        content: Text(
          'Bạn có chắc muốn xóa tất cả món ăn khỏi giỏ hàng?',
          style: GoogleFonts.poppins(
            fontSize: 14.sp,
            color: Colors.grey[700],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Hủy',
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              controller.clearCart();
              Get.back();
            },
            child: Text(
              'Xóa',
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.red[700],
              ),
            ),
          ),
        ],
      ),
    );
  }
}