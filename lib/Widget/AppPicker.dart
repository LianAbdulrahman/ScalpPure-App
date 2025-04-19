import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:path/path.dart' as Path;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../components/AppColor.dart';
import 'AppDialog.dart';
import 'AppSnackBar.dart';

class AppPicker extends StatelessWidget {
  final String imageFile;

  const AppPicker({
    Key? key,
    required this.imageFile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }

  static Future<File?> getImage({required context, required imageFile}) async {
    XFile? pickedFile;
    File? file;
    final Directory directory = await getApplicationDocumentsDirectory();
    String? path;
    String? fileName;
    String? fileExtension;
    File? newImage;
    BaseDeviceInfo? device;
    Platform.isIOS
        ? {
            await Permission.photos.request().then((value) async {
              value.isGranted
                  ? {
                      pickedFile = await ImagePicker.platform
                          .getImageFromSource(source: ImageSource.gallery)
                          .onError((error, stackTrace) {
                        AppSnackBar.showInSnackBar(
                            context: context,
                            message: 'something went wrong please try again later',
                            isSuccessful: false);
                      }),
                      if (pickedFile != null)
                        {
                          file = File(pickedFile!.path),
                          path = directory.path,
                          fileName = Path.basename(pickedFile!.path),
                          fileExtension = Path.extension(fileName!),
                          newImage = await file!.copy('$path/$fileName'),
                          if (fileExtension!.toLowerCase() == ".png" ||
                              fileExtension!.toLowerCase() == ".jpg" ||
                              fileExtension!.toLowerCase() == ".jpeg")
                            {
                              imageFile =
                                  await AppPicker.editImage(image: newImage!)
                            }
                          else
                            {
                              AppSnackBar.showInSnackBar(
                                  context: context,
                                  message:
                                      ' image allowed extensions are png or jpg',
                                  isSuccessful: false)
                            }
                        }
                    }
                  : {
                      AppDialog.infoDialogue(
                        context: context,
                        title: 'Permission',
                        message:
                            "please enable storage permission to continue",
                      )
                    };
            })
          }
        : {
            device = await DeviceInfoPlugin().deviceInfo,
            device.data['version']['sdkInt'] > 32
                ? {
                    await Permission.photos.request().then((value) async {
                      print(value);
                      if (value.isGranted) {
                        pickedFile = await ImagePicker.platform
                            .getImageFromSource(source: ImageSource.gallery)
                            .onError((error, stackTrace) {
                          AppSnackBar.showInSnackBar(
                              context: context,
                              message: 'something went wrong please try again later',
                              isSuccessful: false);
                        });
                        if (pickedFile != null) {
                          file = File(pickedFile!.path);
                          path = directory.path;
                          fileName = Path.basename(pickedFile!.path);
                          fileExtension = Path.extension(fileName!);
                          newImage = await file!.copy('$path/$fileName');
                          if (fileExtension!.toLowerCase() == ".png" ||
                              fileExtension!.toLowerCase() == ".jpg" ||
                              fileExtension!.toLowerCase() == ".jpeg") {
                            imageFile =
                                await AppPicker.editImage(image: newImage!);
                          } else {
                            AppSnackBar.showInSnackBar(
                                context: context,
                                message: ' image allowed extensions are png or jpg',
                                isSuccessful: false);
                          }
                        }
                      } else {
                        AppDialog.infoDialogue(
                          context: context,
                          title: 'Permission',
                          message:
                              "please enable storage permission to continue",
                        );
                      }
                    })
                  }
                : {
                    await Permission.storage.request().then((value) async {
                      print(value);
                      value.isGranted
                          ? {
                              pickedFile = await ImagePicker.platform
                                  .getImageFromSource(
                                      source: ImageSource.gallery)
                                  .onError((error, stackTrace) {
                                AppSnackBar.showInSnackBar(
                                    context: context,
                                    message: 'something went wrong please try again later',
                                    isSuccessful: false);
                              }),
                              if (pickedFile != null)
                                {
                                  file = File(pickedFile!.path),
                                  path = directory.path,
                                  fileName = Path.basename(pickedFile!.path),
                                  fileExtension = Path.extension(fileName!),
                                  newImage =
                                      await file!.copy('$path/$fileName'),
                                  if (fileExtension!.toLowerCase() == ".png" ||
                                      fileExtension!.toLowerCase() == ".jpg" ||
                                      fileExtension!.toLowerCase() == ".jpeg")
                                    {
                                      imageFile = await AppPicker.editImage(
                                          image: newImage!),
                                    }
                                  else
                                    {
                                      AppSnackBar.showInSnackBar(
                                          context: context,
                                          message:
                                              'image allowed extensions are png or jpg',
                                          isSuccessful: false)
                                    }
                                }
                            }
                          : {
                              AppDialog.infoDialogue(
                                context: context,
                                title: 'Permission',
                                message:
                                    "please enable storage permission to continue",
                              )
                            };
                    })
                  }
          };
    return imageFile;
  }

  static Future<File?> editImage({required File image}) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: image.path,
      cropStyle: CropStyle.rectangle,
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 100,
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Edit Photo',
            toolbarColor: AppColor.green,
            toolbarWidgetColor: AppColor.white,
            activeControlsWidgetColor: AppColor.lightGreen,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Edit Photo',
        ),
      ],
    );
    return croppedFile == null ? null : File(croppedFile.path);
  }
}
