import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String? id;
  String? product_name;
  String? barcode;
  int? price, quantity;

  Product({
    this.id,
    required this.product_name,
    required this.barcode,
    required this.price,
    required this.quantity,
  });

  Product.fromMap(DocumentSnapshot data) {
    product_name = data["product_name"];
    barcode = data["barcode"];
    price = data["price"];
    quantity = data["quantity"];
  }
  Product.fromJson(Map<String, dynamic> data) {
    product_name = data["product_name"];
    barcode = data["barcode"];
    price = int.parse(data["price"]);
    quantity = data["quantity"];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_name': product_name,
      'barcode': barcode,
      'price': price,
      'quantity': quantity,
    };
  }
}