import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

enum NotificationType { alert, order }

class DataHandle<T> {
  T? data;
  String? url;
  String result;
  DataHandle({this.data, this.url, required this.result});
}

class Product {
  String? id;
  File? image;
  List<dynamic> buildingUpChemicals = [];
  Timestamp? date;

  Product({required this.image, required this.buildingUpChemicals, this.date ,this.id});

  static Product fromJson(Map<String, dynamic> json) {
    return Product(
        image: File(json['image']),
        buildingUpChemicals: json['chemicals'],
        date: json['date']);
  }
}
