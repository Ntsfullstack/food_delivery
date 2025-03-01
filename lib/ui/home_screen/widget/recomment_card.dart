import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class RecommendedCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final double price;
  final double rating;
  final String time;
  final VoidCallback onOrderNow;
  final VoidCallback onTap;

  const RecommendedCard({
    Key? key,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.rating,
    this.time = '20-30 phút',
    required this.onOrderNow,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 130.h,
        margin: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 8.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 15,
              offset: const Offset(0, 5),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          children: [
            // Food image with caching and loading indicator
            Hero(
              tag: 'food_${name.toLowerCase().replaceAll(' ', '_')}',
              child: ClipRRect(
                borderRadius:
                    BorderRadius.horizontal(left: Radius.circular(18.r)),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  width: 110.h,
                  height: 130.h,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    width: 110.h,
                    height: 130.h,
                    color: Colors.grey[200],
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFFFF7043),
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    width: 110.h,
                    height: 130.h,
                    color: Colors.grey[200],
                    child: Icon(Icons.error, color: Colors.grey[400]),
                  ),
                ),
              ),
            ),

            Expanded(
              child: Padding(
                padding: EdgeInsets.all(14.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      name,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 15.sp,
                        color: const Color(0xFF303030),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 6.h),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: const Color(0xFF4CAF50),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.white,
                                size: 12.sp,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                rating.toString(),
                                style: GoogleFonts.poppins(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Icon(
                          Icons.access_time_rounded,
                          size: 12.sp,
                          color: Colors.grey[500],
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          time,
                          style: GoogleFonts.poppins(
                            fontSize: 10.sp,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "\$${price.toStringAsFixed(2)}",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            fontSize: 16.sp,
                            color: const Color(0xFFFF7043),
                          ),
                        ),
                        InkWell(
                          onTap: onOrderNow,
                          borderRadius: BorderRadius.circular(12.r),
                          child: Ink(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFFFF7043), Color(0xFFFF5722)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(12.r),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color(0xFFFF7043).withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12.w, vertical: 6.h),
                              child: Text(
                                'Đặt ngay',
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
