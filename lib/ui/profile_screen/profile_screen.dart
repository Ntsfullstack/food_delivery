// profile_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'profile_controller.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Account',
          style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
        ),
        actions: [
          Obx(() => IconButton(
                icon: Icon(
                  controller.isEditing.value ? Icons.close : Icons.edit,
                ),
                onPressed: () {
                  if (controller.isEditing.value) {
                    controller.cancelEditing();
                  } else {
                    controller.startEditing();
                  }
                },
              )),
        ],
      ),
      body: Obx(
        () => SingleChildScrollView(
          child: Column(
            children: [
               SizedBox(height: 20.h),
              _buildProfileImage(),
               SizedBox(height: 20.h),
              _buildInfoSection(),
               SizedBox(height: 20.h),
              if (controller.isEditing.value) _buildSaveButton(),
               SizedBox(height: 50.h),
              _buildLogoutButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return Stack(
      children: [
        CircleAvatar(
          radius: 60,
          backgroundImage: controller.profileImage.value != null
              ? FileImage(controller.profileImage.value!)
              : const AssetImage('assets/images/default_avatar.png')
                  as ImageProvider,
        ),
        if (controller.isEditing.value)
          Positioned(
            bottom: 0,
            right: 0,
            child: CircleAvatar(
              backgroundColor: Colors.blue,
              radius: 20,
              child: IconButton(
                icon: const Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: 20,
                ),
                onPressed: controller.pickImage,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildInfoSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          _buildInfoField(
            'Name',
            controller.userName.value,
            Icons.person,
            onChanged: (value) => controller.tempName = value,
          ),
          _buildInfoField(
            'Email',
            controller.email.value,
            Icons.email,
            onChanged: (value) => controller.tempEmail = value,
          ),
          _buildInfoField(
            'Phone',
            controller.phoneNumber.value,
            Icons.phone,
            onChanged: (value) => controller.tempPhone = value,
          ),
          _buildInfoField(
            'Address',
            controller.address.value,
            Icons.location_on,
            onChanged: (value) => controller.tempAddress = value,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoField(
    String label,
    String value,
    IconData icon, {
    Function(String)? onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(10),
            ),
            child: controller.isEditing.value
                ? TextField(
                    controller: TextEditingController(text: value),
                    onChanged: onChanged,
                    decoration: InputDecoration(
                      prefixIcon: Icon(icon),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  )
                : ListTile(
                    leading: Icon(icon),
                    title: Text(
                      value,
                      style: TextStyle(fontSize: 16.sp),
                    ),
                    dense: true,
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton() {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 30.w),
      child: ElevatedButton(
        onPressed: controller.saveChanges,
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Text('Save Changes'),
      ),
    );
  }

  Widget _buildLogoutButton() {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r), // Bo tròn 10px tất cả góc
          color: Colors.red,
        ),
        child: TextButton(
          onPressed: () {
            Get.dialog(
              AlertDialog(
                title: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.red),
                ),
                content: const Text('Are you sure you want to logout?'),
                actions: [
                  TextButton(
                    onPressed: () => Get.back(),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: controller.logout,
                    child: const Text('Logout'),
                  ),
                ],
              ),
            );
          },
          style: TextButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
              foregroundColor: Colors.white),
          child: const Text('Logout'),
        ),
      ),
    );
  }
}
