import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import '../components/AppColor.dart';
import '../components/AppConstants.dart';

class ShimmerPage extends StatelessWidget {
  final List<ItemShape> itemShapeList;
  final CrossAxisAlignment? crossAxisAlignment;
  const ShimmerPage(
      {super.key, required this.itemShapeList, this.crossAxisAlignment});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Shimmer.fromColors(
        baseColor: const Color(0xFFf5f5f5),
        highlightColor: const Color(0xFFe1e1e1).withOpacity(0.5),
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
      double? childAspectRatio,
      bool addMainTitleShimmer = false}) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFFf5f5f5),
      highlightColor: const Color(0xFFe1e1e1).withOpacity(0.5),
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
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: numColumns ?? 2,
                      crossAxisSpacing: 8.w,
                      mainAxisSpacing: 8.h,
                      childAspectRatio: childAspectRatio ?? 1),
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

class AppShimmerWidget extends StatelessWidget {
  final Widget child;
  const AppShimmerWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: const Color(0xFFf5f5f5),
        highlightColor: const Color(0xFFe1e1e1).withOpacity(0.5),
        direction: ShimmerDirection.rtl,
        enabled: true,
        child: child);
  }
}
