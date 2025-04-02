import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          'Giỏ hàng',
          style: GoogleFonts.poppins(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF303030),
          ),
        ),
        leading: IconButton(
          icon: Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 16.sp,
              color: const Color(0xFF303030),
            ),
          ),
          onPressed: () => Get.back(),
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
        if (controller.isLoading) {  // Fixed from .value to .isTrue
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xFFFF7043),
            ),
          );
        }

        if (controller.hasError.isTrue) {  // Fixed from .value to .isTrue
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 48, color: Colors.red[400]),
                SizedBox(height: 16.h),
                Text(
                  'Không thể tải giỏ hàng',
                  style: GoogleFonts.poppins(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF303030),
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  controller.errorMessage.value,
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24.h),
                ElevatedButton(
                  onPressed: () => controller.fetchCartItems(),
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
                    'Thử lại',
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

        return controller.cartItems.isEmpty
            ? _buildEmptyCart()
            : _buildCartContent();
      }),
      bottomNavigationBar: Obx(
            () => controller.cartItems.isEmpty ? const SizedBox() : _buildBottomBar(),
      ),
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

  Widget _buildCartContent() {
    return Column(
      children: [
        // Delivery section
        _buildDeliverySection(),

        // Cart items
        Expanded(
          child: ListView.builder(
            itemCount: controller.cartItems.length,
            padding: EdgeInsets.all(16.r),
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final item = controller.cartItems[index];
              return _buildCartItem(item);
            },
          ),
        ),

        // Promotion code section
        _buildPromoCodeSection(),
      ],
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
                'Địa điểm giao hàng',
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
                  // Lấy địa chỉ từ profile trong HomeController
                  final address = controller.homeController.profile.value?.address;
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
                      '${item.price}đ',
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFFFF7043),
                      ),
                    ),

                    // Quantity controls
                    Row(
                      children: [
                        _buildQuantityButton(
                          icon: Icons.remove,
                          onPressed: () => controller.changeQuantity(item, (item.quantity ?? 1) - 1),
                          enabled: item.quantity! > 1,
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
                    ),                  ],
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
            //
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text(
            //       'Phí giao hàng:',
            //       style: GoogleFonts.poppins(
            //         fontSize: 14.sp,
            //         color: Colors.grey[700],
            //       ),
            //     ),
            //     Text(
            //       '15.000đ',
            //       style: GoogleFonts.poppins(
            //         fontSize: 14.sp,
            //         fontWeight: FontWeight.w500,
            //         color: const Color(0xFF303030),
            //       ),
            //     ),
            //   ],
            // ),
            //
            // SizedBox(height: 8.h),
            //
            // // Discount if any
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text(
            //       'Giảm giá:',
            //       style: GoogleFonts.poppins(
            //         fontSize: 14.sp,
            //         color: Colors.grey[700],
            //       ),
            //     ),
            //     Text(
            //       '-0đ',
            //       style: GoogleFonts.poppins(
            //         fontSize: 14.sp,
            //         fontWeight: FontWeight.w500,
            //         color: Colors.green[700],
            //       ),
            //     ),
            //   ],
            // ),
            //
            //
            //
            // // Total amount
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
                  // Calculate final amount with delivery fee
                  final finalAmount = controller.totalAmount;
                  return Text(
                    '${finalAmount.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}đ',
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

            // Checkout button
            SizedBox(
              width: double.infinity,
              height: 56.h,
              child: ElevatedButton(
                onPressed: () => controller.proceedToCheckout(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF7043),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'Thanh toán',
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