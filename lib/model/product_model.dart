import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String? id;
  String? product_name;
  String? barcode;
  int? price;

  Product({
    this.id,
    required this.product_name,
    required this.barcode,
    required this.price,
  });

  Product.fromMap(DocumentSnapshot data) {
    product_name = data["product_name"];
    barcode = data["barcode"];
    price = data["price"];
  }
}
