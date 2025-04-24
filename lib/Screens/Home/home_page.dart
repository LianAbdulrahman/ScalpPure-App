import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:scalp_pure/BackEnd/class_models.dart';
import 'package:scalp_pure/BackEnd/post_api.dart';
import 'package:scalp_pure/BackEnd/provider_class.dart';
import 'package:scalp_pure/Screens/Home/product_details.dart';
import 'package:scalp_pure/Widget/AppDialog.dart';
import 'package:scalp_pure/Widget/AppPicker.dart';
import 'package:scalp_pure/Widget/AppSnackBar.dart';
import 'package:scalp_pure/Widget/AppText.dart';
import 'package:scalp_pure/components/AppColor.dart';
import 'package:camera_camera/camera_camera.dart';
import 'package:scalp_pure/components/AppIcons.dart';
import 'package:scalp_pure/components/AppMessage.dart';
import 'package:scalp_pure/components/AppRoutes.dart';
import 'package:scalp_pure/components/AppSize.dart';
import 'package:scalp_pure/components/GeneralWidget.dart';

import '../../Widget/AppButtons.dart';
import '../Auth/sign_up.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? image;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      getData();
    });

    super.initState();
  }

  getData() async {
    await context.read<ProviderClass>().getProducts();
  }

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
        actions: [
          IconButton(
              onPressed: () async {
                await context.read<ProviderClass>().logOut(context: context);
              },
              icon: Icon(
                Icons.logout,
                color: AppColor.white,
              ))
        ],
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Selector<ProviderClass, String>(
            selector: (_, provider) => provider.products.result,
            builder: (context, result, child) {
              return result == AppMessage.loading
                  ? UnconstrainedBox(
                      child: SizedBox(
                          height: 35.h,
                          width: 35.h,
                          child: CircularProgressIndicator(
                              color: AppColor.grayGreen)))
                  : result == AppMessage.loaded
                      ? Selector<ProviderClass, List<Product>>(
                          selector: (_, provider) => provider.products.data!,
                          builder: (context, list, child) {
                            return ListView.builder(
                                padding: EdgeInsets.only(top: 8.h),
                                itemCount: list.length,
                                itemBuilder: (_, i) =>
                                    productContainer(product: list[i]));
                          })
                      : Center(
                          child: AppText(
                              text: AppMessage.somethingWrong,
                              fontSize: AppSize.appBarTextSize + 3),
                        );
            }),
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
          heroTag: "btn1",
          backgroundColor: AppColor.grayGreen,
          onPressed: () async {
            openCamera();
          },
          shape: const CircleBorder(),
          child: Icon(
            AppIcons.camera,
            color: AppColor.white,
          ),
        ),
        FloatingActionButton.small(
          heroTag: "btn2",
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

  productContainer({required Product product}) {
    return InkWell(
      onTap: () {
        AppRoutes.pushTo(
            context,
            ProductDetail(
              isFile: true,
              product: product,
            ));
      },
      child: Dismissible(
        background: Container(
          margin: EdgeInsets.all(5.r),
          padding: EdgeInsets.all(10.r),
          color: AppColor.error,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    AppIcons.delete,
                    color: AppColor.white,
                    size: AppSize.appBarIconsSize + 2,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  AppText(
                    text: AppMessage.delete,
                    fontSize: AppSize.subTitle,
                    color: AppColor.white,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AppText(
                    text: AppMessage.delete,
                    fontSize: AppSize.subTitle,
                    color: AppColor.white,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Icon(
                    AppIcons.delete,
                    color: AppColor.white,
                    size: AppSize.appBarIconsSize + 2,
                  ),
                ],
              ),
            ],
          ),
        ),
        confirmDismiss: (confirmed) async {
          return await AppDialog.infoDialogue(
              context: context,
              title: AppMessage.delete,
              message: AppMessage.deleteMessage,
              child: Padding(
                padding: EdgeInsets.only(
                    left: 20.spMin, right: 20.spMin, bottom: 20.spMin),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppButtons(
                        height: 35.h,
                        width: 110.w,
                        backgroundColor: AppColor.error,
                        textStyleColor: AppColor.white,
                        onPressed: () async {
                          Navigator.of(con!).pop(true);
                          AppDialog.showLoading(context: context);
                          PostApi.deleteProduct(
                                  context: context, productId: product.id!)
                              .then((result) {
                            Navigator.pop(con!);
                            result
                                ? null
                                : AppSnackBar.showInSnackBar(
                                    context: context,
                                    message: AppMessage.somethingWrong,
                                    isSuccessful: false);
                          });
                        },
                        text: AppMessage.confirm),
                    AppButtons(
                        height: 35.h,
                        width: 110.w,
                        textStyleColor: AppColor.white,
                        backgroundColor: AppColor.darkGray.withOpacity(.5),
                        onPressed: () {
                          Navigator.of(con!).pop(false);
                        },
                        text: AppMessage.cancel),
                  ],
                ),
              ));
        },
        key: const Key(''),
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
                      child: Image.file(
                        product.image!,
                        fit: BoxFit.cover,
                        errorBuilder: (_, ___, __) => Container(
                          color: AppColor.lightGrey.withOpacity(.5),
                        ),
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
                      text: product.date!.toDate().toString(),
                      fontSize: AppSize.textSize,
                      color: AppColor.darkGray.withOpacity(.6),
                    ),
                    CircleAvatar(
                      radius: 15.r,
                      backgroundColor: product.buildingUpChemicals.isNotEmpty
                          ? AppColor.error
                          : AppColor.green,
                      child: Icon(
                        product.buildingUpChemicals.isNotEmpty
                            ? AppIcons.close
                            : AppIcons.done,
                        color: AppColor.white,
                      ),
                    )
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
