import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scalp_pure/BackEnd/class_models.dart';
import 'package:scalp_pure/Widget/AppText.dart';
import 'package:scalp_pure/components/AppColor.dart';
import 'package:scalp_pure/components/AppIcons.dart';
import 'package:scalp_pure/components/AppMessage.dart';
import 'package:scalp_pure/components/AppSize.dart';
import '../../components/GeneralWidget.dart';

class ProductDetail extends StatefulWidget {
  final Product product;
  final bool isFile;
  const ProductDetail({super.key, required this.product, required this.isFile});

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
          text:
              '${widget.product.buildingUpChemicals.length} ${AppMessage.productDetailsTitle}',
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
                height: 200.h,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: widget.isFile
                      ? Image.file(
                          widget.product.image!,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          widget.product.image!.path,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),
            Flexible(
              child: ListView.builder(
                  padding: EdgeInsets.only(top: 8.h),
                  itemCount: widget.product.buildingUpChemicals.length,
                  shrinkWrap: true,
                  itemBuilder: (_, i) => itemContainer(index: i)),
            ),
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
              Flexible(
                flex: 3,
                child: AppText(
                  text: widget.product.buildingUpChemicals[index],
                  fontSize: AppSize.smallSubText,
                  color: AppColor.darkGray,
                  overflow: TextOverflow.visible,
                ),
              ),
              Flexible(
                child: CircleAvatar(
                  radius: 15.r,
                  backgroundColor: AppColor.green,
                  child: Icon(
                    AppIcons.info,
                    color: AppColor.white,
                    size: AppSize.iconsSize,
                  ),
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
