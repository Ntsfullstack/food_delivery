# Hướng dẫn tích hợp ZaloPay cho Mobile App

## Tổng quan
Ứng dụng đã được tích hợp phương thức thanh toán ZaloPay cho mobile, cho phép người dùng thanh toán đặt cọc hoặc toàn bộ đơn hàng thông qua ZaloPay.

## Tính năng đã triển khai

### 1. Phương thức thanh toán
- **Thanh toán trực tiếp**: Không cần đặt cọc, thanh toán khi nhận hàng
- **ZaloPay**: Thanh toán qua ZaloPay với các tùy chọn:
  - Quét mã QR
  - Mở ứng dụng ZaloPay
  - Thanh toán qua web

### 2. Giao diện người dùng
- Chọn phương thức thanh toán
- Nhập số tiền đặt cọc (cho ZaloPay)
- Hiển thị số tiền còn lại cần thanh toán
- Dialog xác nhận đặt hàng và thanh toán

### 3. Xử lý thanh toán
- Tạo đơn hàng trước
- Tạo thanh toán ZaloPay thông qua API
- Hiển thị các tùy chọn thanh toán
- Xử lý callback và kiểm tra trạng thái

## Cách sử dụng

### 1. Đặt hàng và thanh toán
1. Thêm món ăn vào giỏ hàng
2. Chọn phương thức thanh toán (Trực tiếp hoặc ZaloPay)
3. Nếu chọn ZaloPay, nhập số tiền đặt cọc
4. Nhấn "Đặt hàng & Thanh toán"
5. Xác nhận thông tin đơn hàng
6. Chọn cách thanh toán ZaloPay

### 2. Tùy chọn thanh toán ZaloPay
- **Quét mã QR**: Hiển thị mã QR để quét bằng ZaloPay
- **Mở ZaloPay**: Chuyển đến ứng dụng ZaloPay
- **Thanh toán web**: Mở trang thanh toán trong trình duyệt

## Cấu trúc code

### CartController
- `selectPaymentMethod()`: Chọn phương thức thanh toán
- `updateDepositAmount()`: Cập nhật số tiền đặt cọc
- `processPayment()`: Xử lý thanh toán
- `_processZaloPayPayment()`: Xử lý thanh toán ZaloPay
- `_createZaloPayPayment()`: Tạo thanh toán ZaloPay qua API

### CartScreen
- `_buildPaymentMethodSelection()`: UI chọn phương thức thanh toán
- `_buildDepositAmountInput()`: UI nhập số tiền đặt cọc
- `_showCheckoutDialog()`: Dialog xác nhận đặt hàng

## API Endpoints

### Tạo thanh toán ZaloPay
```
POST /api/payments/create-payment
```

**Request Body:**
```json
{
  "order_id": "string",
  "amount": "number",
  "description": "string",
  "redirect_url": "string",
  "payment_method": "zalopay"
}
```

**Response:**
```json
{
  "status": "success",
  "payment_id": "string",
  "app_trans_id": "string",
  "order_url": "string",
  "qr_code": "string",
  "amount": "number"
}
```

### Kiểm tra trạng thái thanh toán
```
GET /api/payments/check-status/{app_trans_id}
```

## Dependencies cần thiết

Thêm vào `pubspec.yaml`:
```yaml
dependencies:
  url_launcher: ^6.1.14
  webview_flutter: ^4.2.4
  dio: ^5.3.2
```

## Lưu ý quan trọng

1. **Backend**: Đảm bảo backend đã cấu hình ZaloPay với các thông số:
   - App ID
   - Key1, Key2
   - Callback URL
   - Endpoint

2. **Testing**: Sử dụng sandbox environment của ZaloPay để test

3. **Production**: Cập nhật các thông số production khi deploy

4. **Error Handling**: Xử lý các trường hợp lỗi mạng, timeout, và lỗi từ ZaloPay

## Troubleshooting

### Lỗi thường gặp
1. **Không thể tạo thanh toán**: Kiểm tra API endpoint và authentication
2. **QR code không hiển thị**: Kiểm tra response từ backend
3. **Không thể mở ZaloPay**: Kiểm tra deep link và fallback

### Debug
- Sử dụng `print()` statements trong controller
- Kiểm tra network requests trong DevTools
- Xem logs từ backend

## Tương lai

Có thể mở rộng thêm:
- Tích hợp các phương thức thanh toán khác (Momo, VNPay)
- Lưu lịch sử thanh toán
- Push notification khi thanh toán thành công
- Analytics và reporting 