import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scalp_pure/Screens/Home/product_details.dart';
import 'package:scalp_pure/Widget/AppText.dart';
import 'package:scalp_pure/components/AppColor.dart';
import 'package:camera_camera/camera_camera.dart';
import 'package:scalp_pure/components/AppIcons.dart';
import 'package:scalp_pure/components/AppMessage.dart';
import 'package:scalp_pure/components/AppRoutes.dart';
import 'package:scalp_pure/components/AppSize.dart';
import 'package:scalp_pure/components/GeneralWidget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: expandedFab(),
      appBar: AppBar(
        backgroundColor: AppColor.grayGreen,
        centerTitle: false,
        title: AppText(
          text: 'Hello, welcome to ${AppMessage.appName}',
          fontSize: AppSize.appBarTextSize,
          color: AppColor.white,
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
            padding: EdgeInsets.only(top: 8.h),
            itemCount: 2,
            itemBuilder: (_, i) => productContainer()),
      ),
    );
  }

  openCamera() async {
    File file = File('');
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => CameraCamera(
                  onFile: (image) {
                    file = image;
                    print(file.path);
                    //inputImage = InputImage.fromFile(file);
                    Navigator.pop(context);
                    //  process();
                    setState(() {});
                  },
                )));
  }

  expandedFab() {
    return ExpandableFab(
      distance: 80,
      openButtonBuilder: RotateFloatingActionButtonBuilder(
        child: Icon(AppIcons.scan),
        fabSize: ExpandableFabSize.regular,
        foregroundColor: AppColor.white,
        backgroundColor: AppColor.green,
        shape: const CircleBorder(),
      ),
      closeButtonBuilder: RotateFloatingActionButtonBuilder(
        child: Icon(AppIcons.close),
        fabSize: ExpandableFabSize.regular,
        foregroundColor: AppColor.white,
        backgroundColor: AppColor.green,
        shape: const CircleBorder(),
      ),
      children: [
        FloatingActionButton.small(
          backgroundColor: AppColor.grayGreen,
          onPressed: () {
            openCamera();
          },
          shape: const CircleBorder(),
          child: Icon(
            AppIcons.camera,
            color: AppColor.white,
          ),
        ),
        FloatingActionButton.small(
          backgroundColor: AppColor.grayGreen,
          shape: const CircleBorder(),
          child: Icon(
            AppIcons.gallery,
            color: AppColor.white,
          ),
          onPressed: () {
            pickImage();
          },
        ),
      ],
    );
  }

  productContainer() {
    return InkWell(
      onTap: () {
        AppRoutes.pushTo(context, const ProductDetail());
      },
      child: Container(
        height: 170.h,
        width: double.infinity,
        margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
        decoration: GeneralWidget.decoration(),
        child: Column(
          children: [
            Flexible(
                flex: 2,
                child: SizedBox(
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10.r),
                        topLeft: Radius.circular(10.r)),
                    child: Image.asset(
                      'assets/images/productTest.jpeg',
                      fit: BoxFit.cover,
                    ),
                  ),
                )),
            Flexible(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText(
                    text: 'Monday, March/03 ',
                    fontSize: AppSize.textSize,
                    color: AppColor.darkGray.withOpacity(.6),
                  ),
                  CircleAvatar(
                    radius: 15.r,
                    backgroundColor: AppColor.error,
                    child: Icon(
                      AppIcons.close,
                      color: AppColor.white,
                    ),
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      print(image.path);
      //  _handleLostFiles(files);
    } else {
      //  _handleError(response.exception);
    }
  }
}
