import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:food_delivery_app/models/food/dishes.dart';

class ReviewsList extends StatelessWidget {
  final List<Rating> ratings;

  const ReviewsList({
    Key? key,
    required this.ratings,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (ratings.isEmpty) {
      return Container(
        padding: EdgeInsets.all(24.w),
        child: Column(
          children: [
            Icon(
              Icons.rate_review_outlined,
              size: 48.sp,
              color: Colors.grey[400],
            ),
            SizedBox(height: 16.h),
            Text(
              'Chưa có đánh giá nào',
              style: GoogleFonts.poppins(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            Text(
              'Hãy là người đầu tiên đánh giá món ăn này!',
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                color: Colors.grey[500],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 16.h),
          child: Text(
            'Đánh giá từ khách hàng (${ratings.length})',
            style: GoogleFonts.poppins(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF303030),
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
          child: ListView.builder(
            itemCount: ratings.length,
            itemBuilder: (context, index) {
              final rating = ratings[index];
              return _ReviewItem(rating: rating);
            },
          ),
        ),
      ],
    );
  }
}

class _ReviewItem extends StatelessWidget {
  final Rating rating;

  const _ReviewItem({
    Key? key,
    required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(24.w, 0, 24.w, 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User info and rating
          Row(
            children: [
              // User avatar
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: const Color(0xFFFF7043),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Center(
                  child: Text(
                    _getUserInitials(rating.fullName ?? rating.username ?? 'User'),
                    style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              
              // User name and rating
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      rating.fullName ?? rating.username ?? 'Khách hàng',
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF303030),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        // Stars
                        Row(
                          children: List.generate(5, (index) {
                            return Icon(
                              index < (rating.rating ?? 0)
                                  ? Icons.star_rounded
                                  : Icons.star_border_rounded,
                              size: 16.sp,
                              color: const Color(0xFFFFD700),
                            );
                          }),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          '${rating.rating ?? 0}.0',
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
              
              // Date
              Text(
                _formatDate(rating.createdAt),
                style: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
          
          // Comment (if any)
          if (rating.comment != null && rating.comment!.isNotEmpty) ...[
            SizedBox(height: 12.h),
            Text(
              rating.comment!,
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                color: const Color(0xFF303030),
                height: 1.4,
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _getUserInitials(String name) {
    if (name.isEmpty) return 'U';
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name[0].toUpperCase();
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        return '${difference.inMinutes} phút trước';
      }
      return '${difference.inHours} giờ trước';
    } else if (difference.inDays == 1) {
      return 'Hôm qua';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} ngày trước';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
} 