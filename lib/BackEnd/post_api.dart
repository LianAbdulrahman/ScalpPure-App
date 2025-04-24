import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:scalp_pure/BackEnd/class_models.dart';
import 'package:scalp_pure/BackEnd/provider_class.dart';

class PostApi {
  static Future addProduct(
      {required BuildContext context, required Product product}) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc('${context.read<ProviderClass>().userId}')
          .collection('products')
          .add({
        'image': product.image!.path,
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
      print(productId);
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
}
