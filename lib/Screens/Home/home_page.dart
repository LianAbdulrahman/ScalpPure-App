import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:scalp_pure/BackEnd/class_models.dart';
import 'package:scalp_pure/BackEnd/provider_class.dart';
import 'package:scalp_pure/Screens/Home/product_details.dart';
import 'package:scalp_pure/Widget/AppDialog.dart';
import 'package:scalp_pure/Widget/AppPicker.dart';
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
  File? image;

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
            itemBuilder: (_, i) => productContainer(index: i)),
      ),
    );
  }

  openCamera() async {
    File file = File('');
    await Permission.camera.request().then((result) {
      result.isGranted
          ? {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => CameraCamera(
                            onFile: (image) async {
                              file = image;
                              Navigator.pop(context);
                              image = (await AppPicker.editImage(image: file))!;
                              context
                                  .read<ProviderClass>()
                                  .testProduct(context: context, image: image);
                            },
                          )))
            }
          : result.isDenied
              ? openCamera()
              : AppDialog.infoDialogue(
                  context: context,
                  title: AppMessage.permission,
                  message: AppMessage.cameraPermission,
                );
    });
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
          onPressed: () async {
            image =
                await AppPicker.getImage(context: context, imageFile: image);
            if (image != null) {
              context
                  .read<ProviderClass>()
                  .testProduct(context: context, image: image!);
            }
          },
        ),
      ],
    );
  }

  productContainer({required int index}) {
    return InkWell(
      onTap: () {
        AppRoutes.pushTo(
            context,
            ProductDetail(
              isFile: false,
              product: Product(
                  image: File('assets/images/productTest.jpeg'),
                  buildingUpChemicals: [
                    'Building-up Ingredient 1',
                    'Building-up Ingredient 2',
                    'Building-up Ingredient 3'
                  ]),
            ));
      },
      child: Container(
        height: 165.h,
        width: double.infinity,
        margin: EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w),
        decoration: GeneralWidget.decoration(),
        child: Column(
          children: [
            Flexible(
                flex: 3,
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
              padding: EdgeInsets.only(top: 8.h, left: 10.w, right: 10.w),
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
                    backgroundColor:
                        index == 0 ? AppColor.error : AppColor.green,
                    child: Icon(
                      index == 0 ? AppIcons.close : AppIcons.done,
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
}
