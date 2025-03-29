import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/ui/list_customer/customer_controller.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/users/users.dart';


class ListCustomer extends GetView<CustomerController> {
  const ListCustomer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF7043),
        elevation: 0,
        title: Text(
          'Quản lý người dùng',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 18.sp,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () => _showSearchDialog(context),
          ),
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.white),
            onPressed: () => _showFilterOptions(context),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFFF7043),
        onPressed: () => controller.showAddUserDialog(),
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            Expanded(
              child: _buildUsersList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Danh sách người dùng',
            style: GoogleFonts.poppins(
              color: Colors.black87,
              fontWeight: FontWeight.w600,
              fontSize: 16.sp,
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Obx(() => Text(
                'Tổng số: ${controller.users.length} người dùng',
                style: GoogleFonts.poppins(
                  color: Colors.grey[600],
                  fontSize: 14.sp,
                ),
              )),
              const Spacer(),
              DropdownButton<String>(
                value: controller.sortOption.value,
                underline: const SizedBox(),
                icon: const Icon(Icons.arrow_drop_down, color: Color(0xFFFF7043)),
                items: [
                  'Mới nhất',
                  'Cũ nhất',
                  'A-Z',
                  'Z-A',
                ].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: GoogleFonts.poppins(fontSize: 14.sp),
                    ),
                  );
                }).toList(),
                onChanged: (newValue) {
                  controller.sortOption.value = newValue!;
                  controller.sortUsers();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUsersList() {
    return Obx(() {
      if (controller.isLoading) {
        return const Center(child: CircularProgressIndicator(color: Color(0xFFFF7043)));
      }

      if (controller.users.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.person_off_outlined, size: 64.sp, color: Colors.grey),
              SizedBox(height: 16.h),
              Text(
                'Không tìm thấy người dùng nào',
                style: GoogleFonts.poppins(
                  color: Colors.grey[600],
                  fontSize: 16.sp,
                ),
              ),
              SizedBox(height: 8.h),
              ElevatedButton(
                onPressed: () => controller.loadUsers(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF7043),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                child: Text(
                  'Làm mới',
                  style: GoogleFonts.poppins(color: Colors.white),
                ),
              ),
            ],
          ),
        );
      }

      return RefreshIndicator(
        onRefresh: () => controller.loadUsers(),
        color: const Color(0xFFFF7043),
        child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          itemCount: controller.users.length,
          itemBuilder: (context, index) {
            final user = controller.users[index];
            return _buildUserCard(user);
          },
        ),
      );
    });
  }

  Widget _buildUserCard(Users user) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        leading: CircleAvatar(
          radius: 24.r,
          backgroundColor: const Color(0xFFFF7043).withOpacity(0.1),
          child: Text(
            user.fullName.isNotEmpty ? user.fullName[0].toUpperCase() : '?',
            style: GoogleFonts.poppins(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFFFF7043),
            ),
          ),
        ),
        title: Text(
          user.fullName,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 15.sp,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4.h),
            Text(
              user.email,
              style: GoogleFonts.poppins(
                fontSize: 13.sp,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 2.h),
            Row(
              children: [
                Icon(Icons.phone_outlined, size: 14.sp, color: Colors.grey),
                SizedBox(width: 4.w),
                Text(
                  user.phoneNumber,
                  style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(width: 12.w),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: _getRoleColor(user.role).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    user.role,
                    style: GoogleFonts.poppins(
                      color: _getRoleColor(user.role),
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit_outlined, color: Colors.blue[400], size: 20.sp),
              onPressed: () => controller.showEditUserDialog(user),
            ),
            IconButton(
              icon: Icon(Icons.delete_outline, color: Colors.red[400], size: 20.sp),
              onPressed: () => controller.showDeleteConfirmation(user),
            ),
          ],
        ),
        onTap: () => controller.viewUserDetails(user),
      ),
    );
  }

  Color _getRoleColor(String role) {
    switch (role.toLowerCase()) {
      case 'admin':
        return Colors.red;
      case 'customer':
        return Colors.green;
      case 'restaurant':
        return Colors.blue;
      case 'driver':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  void _showSearchDialog(BuildContext context) {
    final searchController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Tìm kiếm người dùng',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 18.sp,
          ),
        ),
        content: TextField(
          controller: searchController,
          decoration: InputDecoration(
            hintText: 'Nhập tên, email hoặc SĐT',
            hintStyle: GoogleFonts.poppins(fontSize: 14.sp),
            prefixIcon: const Icon(Icons.search, color: Color(0xFFFF7043)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: Color(0xFFFF7043)),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Hủy',
              style: GoogleFonts.poppins(color: Colors.grey[700]),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              controller.searchQuery.value = searchController.text;
              controller.filterUsers();
              Get.back();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF7043),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text(
              'Tìm kiếm',
              style: GoogleFonts.poppins(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(16.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Lọc theo vai trò',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
              ),
            ),
            SizedBox(height: 16.h),
            Wrap(
              spacing: 10.w,
              runSpacing: 10.h,
              children: [
                _buildFilterChip('Tất cả', null),
                _buildFilterChip('Admin', 'admin'),
                _buildFilterChip('Khách hàng', 'customer'),
                _buildFilterChip('Nhà hàng', 'restaurant'),
                _buildFilterChip('Tài xế', 'driver'),
              ],
            ),
            SizedBox(height: 24.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    controller.selectedRole.value = null;
                    controller.filterUsers();
                    Get.back();
                  },
                  child: Text(
                    'Đặt lại',
                    style: GoogleFonts.poppins(color: Colors.grey[700]),
                  ),
                ),
                SizedBox(width: 8.w),
                ElevatedButton(
                  onPressed: () {
                    controller.filterUsers();
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF7043),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: Text(
                    'Áp dụng',
                    style: GoogleFonts.poppins(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, String? role) {
    return Obx(() => ChoiceChip(
      label: Text(label),
      selected: controller.selectedRole.value == role,
      onSelected: (selected) {
        controller.selectedRole.value = selected ? role : null;
      },
      selectedColor: const Color(0xFFFF7043).withOpacity(0.2),
      labelStyle: GoogleFonts.poppins(
        color: controller.selectedRole.value == role
            ? const Color(0xFFFF7043)
            : Colors.black87,
        fontWeight: controller.selectedRole.value == role
            ? FontWeight.w600
            : FontWeight.normal,
      ),
    ));
  }
}