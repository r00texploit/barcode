// import 'dart:math';
import 'dart:convert';
import 'dart:developer';

import 'package:barcode/model/product_model.dart';
import 'package:barcode/widgets/loading.dart';
import 'package:bottom_picker/bottom_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import '../widgets/snackbar.dart';
import 'package:path/path.dart';

class AddProductsController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController bar_code,
      cat,
      price,
      no,
      email,
      password,
      product_name,
      number;
  DateTime time = DateTime.now();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  late CollectionReference collectionReference;
  late CollectionReference productsref;
  late Product products;
  Map<String, dynamic>? pro;
  auth.User? user;
  // Stream<List<Product>> getAllTravels() => collectionReference
  //     .snapshots()
  //     .map((query) => query.docs.map((item) => Product.fromMap(item)).toList());
  Stream<QuerySnapshot<Map<String, dynamic>>> getproduct() =>
      FirebaseFirestore.instance
          .collection('products')
          .where('barcode', isEqualTo: products.barcode)
          .snapshots();

  @override
  void onInit() {
    user = FirebaseAuth.instance.currentUser;
    super.onInit();
    //products.bindStream(getproduct());
    bar_code = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
    cat = TextEditingController();
    product_name = TextEditingController();
    number = TextEditingController();
    price = TextEditingController();
    no = TextEditingController();
    pro = {};

    collectionReference = firebaseFirestore.collection("user");
    productsref = firebaseFirestore.collection("products");
    // realestates.bindStream(getAllRealEstate());
  }

  String? validateAddress(String value) {
    if (value.isEmpty) {
      return "Please Add All Field";
    }
    return null;
  }

  void clear() {
    no.clear();
  }

  void addUser() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      update();
      return;
    } else {
      showdilog();
      FirebaseAuth auth = FirebaseAuth.instance;
      final credential = await auth.createUserWithEmailAndPassword(
          email: email.text, password: password.text);
      await credential.user!.reload();
      var re = <String, dynamic>{
        'uid': credential.user!.uid,
        "type": "user",
        "email": email.text,
        "number": no.text
      };
      collectionReference.doc().set(re).whenComplete(() {
        Get.back();
        showbar("user Added", "user Added", "user Added ", true);
        clear();
      }).catchError((error) {
        Get.back();
        showbar("Error", "Error", error.toString(), false);
      });
    }
  }

  void addAdmin() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      update();
      return;
    } else {
      try {
        showdilog();
        FirebaseAuth auth = FirebaseAuth.instance;
        final credential = await auth.createUserWithEmailAndPassword(
            email: email.text, password: password.text);
        await credential.user!.reload();
        await FirebaseFirestore.instance
            .collection('admin')
            .doc(credential.user!.uid)
            .set({
          'type': "admin",
          'number': no.text,
          'email': email.text,
          'uid': credential.user!.uid,
        });
        Get.back();
        email.clear();
        password.clear();
        Get.back();
        showbar("Admin Added", "Admin Added", "Admin Added ", true);
      } catch (e)
      // clear();
      {
        Get.back();
        showbar("Error", "Error", e.toString(), false);
      }
    }
  }

  void addProduct() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      update();
      return;
    } else {
      try {
        showdilog();
        await FirebaseFirestore.instance.collection('products').doc().set({
          "price": price.text,
          "products_name": product_name.text,
          "barcode": bar_code.text
        });
        Get.back();
        cat.clear();
        Get.back();
        showbar("Product Added", "Product Added", "Product Added ", true);
      } catch (e)
      // clear();
      {
        Get.back();
        showbar("Error", "Error", e.toString(), false);
      }
    }
  }

  Future<Map<String, dynamic>?> getProductByBarcode(String barcode) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('products')
          .where('barcode', isEqualTo: barcode)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        pro = querySnapshot.docs.first.data() as Map<String, dynamic>;
        log("Product found with barcode: ${pro!["barcode"]}");
        update();
        return pro;
      } else {
        log("No product found with barcode: $barcode");
        return null;
      }
    } catch (e) {
      log("Error retrieving product: $e");
      return null;
    }
  }

  updateProductQuantity(String barcode, int i) async {
    try {
      await FirebaseFirestore.instance
          .collection('products')
          .where('barcode', isEqualTo: barcode)
          .limit(1)
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          Map<String, dynamic> productData =
              value.docs.first.data() as Map<String, dynamic>;
          int currentQuantity = productData['quantity'] ?? 0;
          int newQuantity = currentQuantity + i;
          FirebaseFirestore.instance
              .collection('products')
              .doc(value.docs.first.id)
              .update({'quantity': newQuantity});
        } else {
          log("No product found with barcode: $barcode");
        }
      });
    } catch (e) {
      log("Error updating product quantity: $e");
    }
  }

 
}
