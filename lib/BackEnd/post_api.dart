import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudinary_api/uploader/cloudinary_uploader.dart';
import 'package:cloudinary_url_gen/cloudinary.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:scalp_pure/BackEnd/class_models.dart';
import 'package:scalp_pure/BackEnd/provider_class.dart';

// Create a Cloudinary instance and set your cloud name.
var cloudinary = Cloudinary.fromStringUrl(
    'cloudinary://524828953747846:2A0eOsaMZqzH-JvHYSvQguNmYX4@dowdvpepy');

class PostApi {
  static Future addProduct(
      {required BuildContext context, required Product product}) async {
    try {

      String? imagePath = await upload( image: File(product.image!));

      await FirebaseFirestore.instance
          .collection('users')
          .doc('${context.read<ProviderClass>().userId}')
          .collection('products')
          .add({
        'image': imagePath,
        'date': DateTime.now(),
        'chemicals': product.buildingUpChemicals
      });

      return true;
    } catch (error) {
      return false;
    }
  }

  static Future deleteProduct(
      {required BuildContext context, required String productId}) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc('${context.read<ProviderClass>().userId}')
          .collection('products')
          .doc(productId)
          .delete();

      return true;
    } catch (error) {
      return false;
    }
  }

  static Future<String?> upload({required File image}) async {
    cloudinary.config.urlConfig.secure = true;

    var response = await cloudinary.uploader().upload(
          image
        );
    print("Public ID:");
    print(response?.data?.publicId);
    print("Secure URL:");
    print(response?.data?.secureUrl);

    return response?.data?.secureUrl;
  }
}
