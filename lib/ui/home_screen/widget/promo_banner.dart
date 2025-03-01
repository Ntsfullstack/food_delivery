import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PromoBanner extends StatelessWidget {
  final List<Map<String, dynamic>> banners;
  final Function(int) onPageChanged;
  final RxInt currentBannerIndex;
  final VoidCallback onOrderNow;

  const PromoBanner({
    Key? key,
    required this.banners,
    required this.onPageChanged,
    required this.currentBannerIndex,
    required this.onOrderNow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.h,
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      child: PageView.builder(
        itemCount: banners.length,
        onPageChanged: onPageChanged,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final banner = banners[index];
          final bannerColor = Color(banner['color'] as int);

          return Container(
            margin: EdgeInsets.only(right: 8.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(
                  color: bannerColor.withOpacity(0.4),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Stack(
              children: [
                // Banner image with proper caching
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: CachedNetworkImage(
                    imageUrl: banner['image']!.toString(),
                    height: 200.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: bannerColor.withOpacity(0.3),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: bannerColor,
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: bannerColor.withOpacity(0.3),
                      child: Icon(Icons.error, color: Colors.white),
                    ),
                    colorBlendMode: BlendMode.darken,
                    color: Colors.black.withOpacity(0.4),
                  ),
                ),

                // Banner content
                Padding(
                  padding: EdgeInsets.all(12.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 6.h),
                        decoration: BoxDecoration(
                          color: bannerColor,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text(
                          banner['subtitle']!.toString(),
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        banner['title']!.toString(),
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        banner['discount']!.toString(),
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      // Order Now button
                      GestureDetector(
                        onTap: onOrderNow,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 8.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Text(
                            'Đặt Ngay',
                            style: GoogleFonts.poppins(
                              color: bannerColor,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Page indicator
                Positioned(
                  bottom: 12.h,
                  right: 0,
                  left: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      banners.length,
                      (i) => Obx(() => AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: i == currentBannerIndex.value ? 24.w : 8.w,
                            height: 8.h,
                            margin: EdgeInsets.symmetric(horizontal: 2.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.r),
                              color: i == currentBannerIndex.value
                                  ? Colors.white
                                  : Colors.white.withOpacity(0.4),
                            ),
                          )),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
