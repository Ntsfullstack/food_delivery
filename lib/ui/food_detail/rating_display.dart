import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:food_delivery_app/models/food/dishes.dart';

class RatingDisplay extends StatelessWidget {
  final Dishes dish;
  final VoidCallback? onTapToRate;
  final bool showRatingCount;

  const RatingDisplay({
    Key? key,
    required this.dish,
    this.onTapToRate,
    this.showRatingCount = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final averageRating = dish.averageRating ?? 0.0;
    final ratings = dish.ratings ?? [];
    final ratingCount = ratings.length;

    return GestureDetector(
      onTap: onTapToRate,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Row(
          children: [
            // Star icon
            Icon(
              Icons.star_rounded,
              color: const Color(0xFFFFD700),
              size: 20.sp,
            ),
            SizedBox(width: 8.w),
            
            // Average rating
            Text(
              averageRating > 0 ? averageRating.toStringAsFixed(1) : '0.0',
              style: GoogleFonts.poppins(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF303030),
              ),
            ),
            SizedBox(width: 4.w),
            
            // Star rating display
            if (averageRating > 0) ...[
              Row(
                children: List.generate(5, (index) {
                  return Icon(
                    index < averageRating.floor()
                        ? Icons.star_rounded
                        : index < averageRating
                            ? Icons.star_half_rounded
                            : Icons.star_border_rounded,
                    size: 16.sp,
                    color: const Color(0xFFFFD700),
                  );
                }),
              ),
              SizedBox(width: 8.w),
            ],
            
            // Rating count
            if (showRatingCount && ratingCount > 0) ...[
              Text(
                '($ratingCount đánh giá)',
                style: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(width: 8.w),
            ],
            
            // Rate button
            if (onTapToRate != null) ...[
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF7043),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.rate_review_rounded,
                      size: 14.sp,
                      color: Colors.white,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      'Đánh giá',
                      style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
} 