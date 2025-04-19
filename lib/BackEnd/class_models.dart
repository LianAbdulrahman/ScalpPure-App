import 'dart:convert';
import 'dart:io';

enum NotificationType { alert, order }

class DataHandle<T> {
  T? data;
  String? url;
  String result;
  DataHandle({this.data, this.url, required this.result});
}

class Product {
  File? image;
  List<String> buildingUpChemicals = [];

  Product({required this.image, required this.buildingUpChemicals});
}
