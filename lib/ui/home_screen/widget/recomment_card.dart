import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../models/food/dishes.dart';

class RecommendedCard extends StatelessWidget {
  final ListDishes dish;

  final VoidCallback onTap;

  const RecommendedCard({
    Key? key,
    required this.dish,

    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Debug dish data
    print('Building RecommendedCard for dish:');
    print('  ID: ${dish.dishId}');
    print('  Name: ${dish.name}');
    print('  ImageURL: ${dish.imageUrl}');
    print('  Sizes: ${dish.sizes?.length ?? 0} items');

    // Extract the default price or first price from sizes
    int price = 0;
    String sizeName = '';
    if (dish.sizes != null && dish.sizes!.isNotEmpty) {
      try {
        // Try to find the default size first
        var defaultSize = dish.sizes!.firstWhere(
              (size) => size.isDefault == true,
          orElse: () => dish.sizes!.first,
        );
        price = defaultSize.price ?? 0;
        sizeName = defaultSize.sizeName ?? '';
        print('  Selected size: $sizeName, Price: $price');
      } catch (e) {
        print('  Error getting price: $e');
      }
    } else {
      print('  No sizes available');
    }

    // Parse rating to double for display
    double ratingValue = 0.0;
    if (dish.rating != null) {
      try {
        ratingValue = double.tryParse(dish.rating!) ?? 4.5;
      } catch (e) {
        print('  Error parsing rating: $e');
        ratingValue = 4.5;
      }
    }

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
              tag: 'food_${dish.dishId ?? DateTime.now().millisecondsSinceEpoch}',
              child: ClipRRect(
                borderRadius:
                BorderRadius.horizontal(left: Radius.circular(18.r)),
                child: CachedNetworkImage(
                  imageUrl: dish.imageUrl ?? 'https://cmavn.org/wp-content/uploads/2019/09/1015628-jironahoko.jpg',
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
                                ratingValue.toString(),
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
                            dish.category ?? sizeName,
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
                          price > 0 ?
                          "${(price / 1000).toStringAsFixed(0)}K" :  // Format as xxK VND
                          "Price N/A",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            fontSize: 16.sp,
                            color: const Color(0xFFFF7043),
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