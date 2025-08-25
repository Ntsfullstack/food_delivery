import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'dish_detail_controller.dart';
import '../../models/food/dish_categories.dart';

class DishDetailScreen extends GetView<DishDetailController> {
  const DishDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF7043),
        title: Obx(() => Text(
          controller.isEdit.value ? 'Chỉnh sửa món ăn' : 'Thêm món ăn',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 18.sp,
          ),
        )),
        actions: [
          Obx(() {
            if (controller.isEdit.value && controller.dishId?.value != null) {
              return IconButton(
                icon: const Icon(Icons.delete),
                onPressed: controller.deleteDish,
              );
            }
            return const SizedBox.shrink();
          }),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildImagePicker(),
                SizedBox(height: 16.h),
                _buildFormFields(),
                SizedBox(height: 24.h),
                _buildSaveButton(),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildImagePicker() {
    return Obx(() {
      return GestureDetector(
        onTap: controller.pickImage,
        child: Container(
          height: 200.h,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: _buildImageContent(),
        ),
      );
    });
  }

  Widget _buildImageContent() {
    if (controller.imagePath.value.isNotEmpty) {
      // Show selected local image
      return ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: Image.file(
          File(controller.imagePath.value),
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return _buildPlaceholderImage();
          },
        ),
      );
    } else if (controller.dish.value?.image != null && controller.dish.value!.image!.isNotEmpty) {
      // Show network image from existing dish
      return ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: Image.network(
          controller.dish.value!.image!,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return _buildPlaceholderImage();
          },
        ),
      );
    }
    // Show placeholder for new dish or when no image is selected
    return _buildPlaceholderImage();
  }

  Widget _buildPlaceholderImage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.camera_alt, size: 40.sp, color: Colors.grey[400]),
        SizedBox(height: 8.h),
        Text(
          'Chọn ảnh',
          style: GoogleFonts.poppins(
            color: Colors.grey[600],
            fontSize: 14.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildFormFields() {
    return Column(
      children: [
        _buildTextField(
          controller: controller.nameController,
          label: 'Tên món ăn',
          validator: (v) => v?.isEmpty == true ? 'Vui lòng nhập tên món ăn' : null,
        ),
        SizedBox(height: 16.h),
        _buildTextField(
          controller: controller.descController,
          label: 'Mô tả',
          maxLines: 3,
        ),
        SizedBox(height: 16.h),
        _buildTextField(
          controller: controller.priceController,
          label: 'Giá (VNĐ)',
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          validator: (v) {
            if (v?.isEmpty == true) return 'Vui lòng nhập giá';
            try {
              final price = double.parse(v!.replaceAll(',', ''));
              if (price < 0) return 'Giá không được âm';
              return null;
            } catch (e) {
              return 'Giá không hợp lệ';
            }
          },
        ),
        SizedBox(height: 16.h),
        _buildTextField(
          controller: controller.prepTimeController,
          label: 'Thời gian chuẩn bị (phút)',
          keyboardType: TextInputType.number,
          validator: (v) {
            if (v?.isNotEmpty == true) {
              final time = int.tryParse(v!);
              if (time == null || time < 0) return 'Thời gian không hợp lệ';
            }
            return null;
          },
        ),
        SizedBox(height: 16.h),
        _buildCategoryDropdown(),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    int? maxLines,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      ),
      keyboardType: keyboardType,
      validator: validator,
      maxLines: maxLines ?? 1,
    );
  }

  Widget _buildCategoryDropdown() {
    return Obx(() {
      if (controller.categories.isEmpty) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 16.w,
                height: 16.w,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
              SizedBox(width: 12.w),
              Text(
                'Đang tải danh mục...',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ],
          ),
        );
      }
      
      return DropdownButtonFormField<DishesCategory>(
        decoration: InputDecoration(
          labelText: 'Danh mục',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        ),
        value: controller.selectedCategory.value,
        items: controller.categories.map((category) {
          return DropdownMenuItem<DishesCategory>(
            value: category,
            child: Text(category.name ?? ''),
          );
        }).toList(),
        onChanged: (category) {
          controller.onCategoryChanged(category);
        },
        validator: (category) {
          if (category == null) return 'Vui lòng chọn danh mục';
          return null;
        },
      );
    });
  }

  Widget _buildSaveButton() {
    return Obx(() {
      return ElevatedButton(
        onPressed: controller.isLoading ? null : controller.saveDish,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFF7043),
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        child: Text(
          controller.isEdit.value ? 'Lưu thay đổi' : 'Thêm món',
          style: GoogleFonts.poppins(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    });
  }
}
