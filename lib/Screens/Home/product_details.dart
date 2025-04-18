import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scalp_pure/Widget/AppText.dart';
import 'package:scalp_pure/components/AppColor.dart';
import 'package:scalp_pure/components/AppIcons.dart';
import 'package:scalp_pure/components/AppSize.dart';

import '../../components/GeneralWidget.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.grayGreen,
        centerTitle: false,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            AppIcons.backArrow,
            color: AppColor.white,
            size: AppSize.appBarIconsSize,
          ),
        ),
        title: AppText(
          text: 'Scalp Building up Chemicals',
          fontSize: AppSize.appBarTextSize,
          color: AppColor.white,
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
              decoration: GeneralWidget.decoration(),
              child: SizedBox(
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: Image.asset(
                    'assets/images/productTest.jpeg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            ListView.builder(
                padding: EdgeInsets.only(top: 8.h),
                itemCount: 3,
                shrinkWrap: true,
                itemBuilder: (_, i) => itemContainer(index: i)),
          ],
        ),
      ),
    );
  }

  itemContainer({required int index}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                text: 'Building-up Ingredient $index',
                fontSize: AppSize.textSize,
                color: AppColor.darkGray,
              ),
              CircleAvatar(
                radius: 15.r,
                backgroundColor: AppColor.green,
                child: Icon(
                  AppIcons.info,
                  color: AppColor.white,
                  size: AppSize.iconsSize,
                ),
              )
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Divider(
            height: 5.h,
            color: AppColor.lightGrey.withOpacity(.3),
          )
        ],
      ),
    );
  }
}
