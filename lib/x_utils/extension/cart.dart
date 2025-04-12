// Extension methods for CartItem
import '../../models/cart/cart.dart';

extension CartItemExtension on CartItem {
  // Phương thức hiện tại - giữ nguyên
  String get formattedPrice {
    return price != null ? price!.toStringAsFixed(0).replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
            (Match m) => '${m[1]}.'
    ) : "0";
  }

  // Phương thức hiện tại - giữ nguyên
  String? get variant {
    return size?.sizeName;
  }

  // Các phương thức bổ sung để đảm bảo null safety

  // Đảm bảo rằng trả về string không bao giờ null
  String get displayName => name ?? 'Món ăn không tên';

  // Định dạng subtotal tương tự như price
  String get formattedSubtotal {
    return subtotal != null ? subtotal!.toStringAsFixed(0).replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
            (Match m) => '${m[1]}.'
    ) : "0";
  }

  // Đảm bảo rằng quantity không bao giờ null
  int get safeQuantity => quantity ?? 1;

  // Kiểm tra sự tồn tại của cartId
  bool get hasValidCartId => cartId != null;

  // Kiểm tra sự tồn tại của dishId
  bool get hasValidDishId => dishId != null;

  // Lấy URL hình ảnh mặc định nếu null
  String get safeImageUrl => imageUrl ?? "https://via.placeholder.com/150";

  // Đảm bảo rằng variant không null cho hiển thị UI
  String get safeVariant => variant ?? '';

  // Kiểm tra nếu món ăn có sẵn để đặt hàng
  bool get isOrderable => hasValidDishId && (isAvailable ?? false);
}