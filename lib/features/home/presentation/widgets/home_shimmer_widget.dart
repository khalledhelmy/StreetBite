import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class HomeShimmerWidget extends StatelessWidget {
  const HomeShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final baseColor = isDark ? Colors.grey.shade800 : Colors.grey.shade300;

    final highlightColor = isDark ? Colors.grey.shade700 : Colors.grey.shade100;

    Widget skeletonBox({
      double? width,
      required double height,
      double radius = 8,
    }) {
      return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radius.r),
        ),
      );
    }

    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      period: const Duration(milliseconds: 1500),
      child: CustomScrollView(
        slivers: [
          // Hot Offers title
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.h),
              child: skeletonBox(width: 125.w, height: 24.h),
            ),
          ),

          // Horizontal offers cards
          SliverToBoxAdapter(
            child: SizedBox(
              height: 200.h,
              child: ListView.separated(
                padding: EdgeInsetsDirectional.only(
                  start: 12.w,
                  top: 12.h,
                  bottom: 12.h,
                ),
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                separatorBuilder: (_, _) => SizedBox(width: 12.w),
                itemBuilder: (_, _) {
                  return skeletonBox(width: 300.w, height: 170.h, radius: 12);
                },
              ),
            ),
          ),

          // All meals title
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(12.w, 8.h, 12.w, 12.h),
              child: skeletonBox(width: 110.w, height: 24.h),
            ),
          ),

          // Meals grid
          SliverPadding(
            padding: EdgeInsetsDirectional.fromSTEB(12.w, 0, 12.w, 16.h),
            sliver: SliverGrid.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12.w,
                mainAxisSpacing: 12.h,
                childAspectRatio: 0.72,
              ),
              itemCount: 6,
              itemBuilder: (_, _) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: skeletonBox(height: double.infinity, radius: 0),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            skeletonBox(width: 115.w, height: 14.h),
                            SizedBox(height: 8.h),
                            skeletonBox(width: 75.w, height: 12.h),
                            SizedBox(height: 10.h),
                            skeletonBox(height: 36.h, radius: 8),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
