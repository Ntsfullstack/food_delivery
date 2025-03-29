import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

// Import your new unified model
import '../../../models/food/dishes.dart';

class RecommendedCard extends StatelessWidget {
  final Dishes dish;
  final VoidCallback onTap;

  const RecommendedCard({
    Key? key,
    required this.dish,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? priceDisplay = dish.price;
    double ratingValue = dish.rating ?? 4.5;
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
              tag: 'food_${dish.id ?? DateTime.now().millisecondsSinceEpoch}',
              child: ClipRRect(
                borderRadius:
                BorderRadius.horizontal(left: Radius.circular(18.r)),
                child: CachedNetworkImage(
                  imageUrl: dish.image ?? 'https://cmavn.org/wp-content/uploads/2019/09/1015628-jironahoko.jpg',
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
                  errorWidget: (context, url, error) {
                    print('Image error for ${dish.name}: $error');
                    return Container(
                      width: 110.h,
                      height: 130.h,
                      color: Colors.grey[200],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.error, color: Colors.grey[400]),
                          Text(
                            'Image Error',
                            style: TextStyle(color: Colors.grey[600], fontSize: 10.sp),
                          ),
                        ],
                      ),
                    );
                  },
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
                      dish.name ?? 'Unknown Dish',
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
                                ratingValue.toStringAsFixed(1),
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
                        Expanded(
                          child: Text(
                            dish.category ?? 'Food',
                            style: GoogleFonts.poppins(
                              fontSize: 10.sp,
                              color: Colors.grey[600],
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          priceDisplay!,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            fontSize: 16.sp,
                            color: const Color(0xFFFF7043),
                          ),
                        ),
                        // Show a brief prep time if available
                        if (dish.preparationTime != null)
                          Text(
                            "${dish.preparationTime} min",
                            style: GoogleFonts.poppins(
                              fontSize: 12.sp,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
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