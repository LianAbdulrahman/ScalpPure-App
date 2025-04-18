import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
 import '../components/AppColor.dart';
import '../components/AppConstants.dart';

class AppShimmer extends StatelessWidget {
  final List<ItemShape> itemShapeList;
  final CrossAxisAlignment? crossAxisAlignment;
  const AppShimmer(
      {super.key, required this.itemShapeList, this.crossAxisAlignment});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Shimmer.fromColors(
        baseColor: AppColor.darkGray.withOpacity(0.4),
        highlightColor: AppColor.darkGray,
        direction: ShimmerDirection.rtl,
        enabled: true,
        child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment:
              crossAxisAlignment ?? CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: itemShapeList
                  .map(
                    (ItemShape e) => e.isHorizontalList == true
                    ? Container(
                  height: e.high,
                  width: e.width,
                  margin: e.horizontalListWidthMargin,
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (covariant, i) => AspectRatio(
                      aspectRatio: e.horizontalListAspectRatio!,
                      child: Container(
                        margin: e.horizontalListMargin,
                        decoration: BoxDecoration(
                          borderRadius: e.borderRadius,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
                    : Container(
                  width: e.width,
                  height: e.high,
                  margin: e.margin,
                  decoration: BoxDecoration(
                      borderRadius: e.borderRadius,
                      color: Colors.white,
                      shape: e.shape == null
                          ? BoxShape.rectangle
                          : e.shape!),
                ),
              )
                  .toList(),
            )),
      ),
    );
  }

  static gridShimmerLoading(
      {int? numColumns,
        int? itemCount,
        double? height,
        bool addMainTitleShimmer = false}) {
    return Shimmer.fromColors(
      baseColor: AppColor.darkGray.withOpacity(0.4),
      highlightColor: AppColor.darkGray,
      direction: ShimmerDirection.rtl,
      enabled: true,
      child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                  visible: addMainTitleShimmer,
                  child: Container(
                    height: 30.h,
                    width: 150.w,
                    margin: EdgeInsets.all(15.r),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: Colors.white,
                    ),
                  )),
              GridView.builder(
                  shrinkWrap: true,
                  itemCount: itemCount ?? 4,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: numColumns ?? 2,
                      crossAxisSpacing: 10.w,
                      mainAxisSpacing: 10.h),
                  padding:
                  EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  itemBuilder: (_, index) {
                    return Container(
                      height: height ?? 150.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: Colors.white,
                      ),
                    );
                  }),
            ],
          )),
    );
  }
}