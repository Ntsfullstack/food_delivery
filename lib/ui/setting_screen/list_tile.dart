import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? iconColor;
  final Color? iconBackgroundColor;
  final EdgeInsetsGeometry? contentPadding;

  const CustomListTile({
    Key? key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.iconColor,
    this.iconBackgroundColor,
    this.contentPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(8.r),
        decoration: BoxDecoration(
          color:
              iconBackgroundColor ?? const Color(0xFFFF7043).withOpacity(0.1),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Icon(
          icon,
          color: iconColor ?? const Color(0xFFFF7043),
          size: 22.sp,
        ),
      ),
      title: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 15.sp,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF303030),
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: GoogleFonts.poppins(
                fontSize: 13.sp,
                color: Colors.grey[600],
              ),
            )
          : null,
      trailing: trailing ??
          Icon(
            Icons.arrow_forward_ios_rounded,
            color: Colors.grey[400],
            size: 18.sp,
          ),
      contentPadding: contentPadding ??
          EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      onTap: onTap,
    );
  }
}

// Extension method for backwards compatibility
extension ListTileBuilder on Widget {
  static CustomListTile buildListTile({
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
    Color? iconColor,
    Color? iconBackgroundColor,
    EdgeInsetsGeometry? contentPadding,
  }) {
    return CustomListTile(
      icon: icon,
      title: title,
      subtitle: subtitle,
      trailing: trailing,
      onTap: onTap,
      iconColor: iconColor,
      iconBackgroundColor: iconBackgroundColor,
      contentPadding: contentPadding,
    );
  }
}
