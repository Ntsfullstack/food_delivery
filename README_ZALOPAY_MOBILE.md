# Hướng dẫn test ZaloPay trên Mobile App

## Tổng quan

Ứng dụng mobile đã được tích hợp thanh toán ZaloPay với giao diện thân thiện và flow thanh toán hoàn chỉnh.

## Tính năng đã triển khai

### 1. **Chọn phương thức thanh toán**
- Thanh toán trực tiếp (không đặt cọc)
- ZaloPay (có thể đặt cọc)

### 2. **Giao diện thanh toán**
- Chọn phương thức thanh toán
- Nhập số tiền đặt cọc (cho ZaloPay)
- Hiển thị tóm tắt thanh toán
- Dialog xác nhận đặt hàng

### 3. **Xử lý thanh toán ZaloPay**
- Tạo thanh toán qua backend
- Hiển thị tùy chọn thanh toán:
  - Quét mã QR
  - Mở ứng dụng ZaloPay
  - Thanh toán qua web

## Cách test

### 1. **Chuẩn bị**
- Backend đã chạy trên port 3000
- Mobile app đã build và cài đặt
- Có món ăn trong giỏ hàng

### 2. **Test flow thanh toán**

#### **Bước 1: Chọn phương thức thanh toán**
1. Mở màn hình giỏ hàng
2. Chọn **"ZaloPay"** làm phương thức thanh toán
3. Nhập số tiền đặt cọc (ví dụ: 50% tổng tiền)

#### **Bước 2: Xem tóm tắt thanh toán**
- Kiểm tra thông tin hiển thị:
  - Phương thức thanh toán
  - Số tiền đặt cọc
  - Tổng thanh toán

#### **Bước 3: Đặt hàng và thanh toán**
1. Nhấn **"Đặt hàng & Thanh toán"**
2. Xác nhận thông tin trong dialog
3. Nhấn **"Đặt hàng"**

#### **Bước 4: Xử lý thanh toán ZaloPay**
1. Backend tạo thanh toán ZaloPay
2. Hiển thị dialog chọn cách thanh toán:
   - **Quét mã QR**: Hiển thị QR code
   - **Mở ZaloPay**: Chuyển đến app ZaloPay
   - **Thanh toán web**: Mở trang web

#### **Bước 5: Hoàn tất thanh toán**
1. Thực hiện thanh toán theo cách đã chọn
2. Sau khi thành công, quay lại app
3. Hiển thị thông báo thành công
4. Chuyển về màn hình chính

## Cấu hình backend

### **File config**: `food_api/config/zalopay.js`

```javascript
sandbox: {
  app_id: "2554",
  key1: "PcY4iZIKFCIdgZvA6ueMcMHHUbRLYjPL",
  key2: "kLtgPl8HHhfvMuDHPwKfgfsY4Ydm9eIz",
  endpoint: "https://sb-openapi.zalopay.vn/v2/create",
  query_endpoint: "https://sb-openapi.zalopay.vn/v2/query",
  callback_url: "http://localhost:3000/api/payments/callback",
  default_return_url: "fooddelivery://payment-success"
}
```

### **URLs quan trọng**
- **Callback URL**: Backend endpoint để nhận kết quả từ ZaloPay
- **Return URL**: Deep link để quay lại app sau thanh toán

## Test cases

### **Test Case 1: Thanh toán trực tiếp**
- Chọn "Thanh toán trực tiếp"
- Không cần đặt cọc
- Đặt hàng thành công → quay về màn hình chính

### **Test Case 2: Thanh toán ZaloPay không đặt cọc**
- Chọn "ZaloPay"
- Đặt cọc = 0
- Test các tùy chọn thanh toán

### **Test Case 3: Thanh toán ZaloPay có đặt cọc**
- Chọn "ZaloPay"
- Đặt cọc > 0 (ví dụ: 50% tổng tiền)
- Test flow thanh toán hoàn chỉnh

### **Test Case 4: Xử lý lỗi**
- Test khi backend không response
- Test khi ZaloPay API lỗi
- Test khi user cancel thanh toán

## Troubleshooting

### **Lỗi "Failed to create payment"**
- Kiểm tra backend có chạy không
- Kiểm tra config ZaloPay có đúng không
- Kiểm tra logs backend

### **QR code không hiển thị**
- Kiểm tra response từ ZaloPay API
- Kiểm tra backend logs
- Kiểm tra mobile app logs

### **Không thể mở ZaloPay app**
- Kiểm tra ZaloPay app đã cài chưa
- Kiểm tra deep link có đúng không
- Test fallback đến Play Store

### **Thanh toán thành công nhưng không quay về app**
- Kiểm tra deep link configuration
- Kiểm tra app navigation
- Kiểm tra payment success handling

## Lưu ý quan trọng

1. **Sandbox Environment**: Dùng để test, không cần tiền thật
2. **Test Keys**: Chỉ dùng để test, không dùng production
3. **Local Testing**: Backend chạy localhost:3000
4. **Mobile App**: Cần build và cài đặt để test deep link

## Tương lai

Có thể mở rộng thêm:
- Tích hợp các phương thức thanh toán khác
- Lưu lịch sử thanh toán
- Push notification khi thanh toán thành công
- Analytics và reporting 