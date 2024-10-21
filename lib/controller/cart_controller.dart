import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:barcode/model/product_model.dart';
import 'add_product_controller.dart';

var products = Get.put(AddProductsController());

class CartController extends GetxController {
  List<Map<String, dynamic>> cartItems = [{}];
  var totalPrice = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadCart();
  }

  void removeFromCart(Product product) {
    cartItems.removeWhere((item) => item['barcode'] == product.barcode);
    totalPrice.value -= product.price!;
    saveCart(cartItems);
    update();
  }

  void clearCart() {
    cartItems.clear();
    totalPrice.value = 0;
    saveCart(cartItems);
    update();
  }

  Future<void> loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartJson = prefs.getString('cart');
    if (cartJson != null) {
      final cartList = jsonDecode(cartJson) as List<dynamic>;
      cartItems = cartList.map((item) => item as Map<String, dynamic>).toList();
      totalPrice.value =
          cartItems.fold(0, (sum, item) => sum + (item['price'] as int));
    }
    update();
  }

  void addToCart(String barcode, int quantity) async {
    Map<String, dynamic> product = {};
    try {
      await products.updateProductQuantity(barcode, quantity);
      // Get the current cart from shared preferences
      List<Map<String, dynamic>>? cart = await getCart();
      // Check if the product already exists in the cart
      bool productExists =
          cart?.any((item) => item['barcode'] == barcode) ?? false;
      if (productExists) {
        // If the product exists, update the quantity
        cart!.asMap().forEach((index, item) {
          if (item['barcode'] == barcode) {
            cart[index]['quantity'] = (item['quantity'] ?? 0) + quantity;
          }
        });
      } else {
        // If the product doesn't exist, add it to the cart
        product = await products.getProductByBarcode(barcode) ?? {};
        product['quantity'] = quantity;
        cart?.add(product);
      }
      // Save the updated cart to shared preferences
      await saveCart(cart!);
      var added;

      cart!.asMap().forEach((index, item) {
        if (item['barcode'] == barcode) {
          added = item["product_name"];
          update();
        }
      });
      log("Product added to cart: $barcode => $added");
    } catch (e) {
      log("Error adding product to cart: $e");
    }
  }

  Future<List<Map<String, dynamic>>?> getCart() async {
    try {
      // Get the cart from shared preferences
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? cartJson = prefs.getString('cart');
      if (cartJson != null) {
        // Decode the cart from JSON
        final List<dynamic> cartList = jsonDecode(cartJson);
        // Convert the list of dynamic to a list of maps
        return cartList.cast<Map<String, dynamic>>();
      }
    } catch (e) {
      log("Error getting cart from shared preferences: $e");
    }
    return null;
  }

  Future<void> saveCart(List<Map<String, dynamic>> list) async {
    try {
      // Encode the cart to JSON
      final String cartJson = jsonEncode(list);
      // Save the cart to shared preferences
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('cart', cartJson);
    } catch (e) {
      log("Error saving cart to shared preferences: $e");
    }
  }

  Future<void> checkout() async {
    // Implement checkout logic here
    // For example, you could navigate to a checkout screen
    // or process the order directly
    // ...
    // 1. Clear the cart
    clearCart();
    // 2. Show a success message or navigate to a confirmation screen
    Get.snackbar("Checkout", "Your order has been placed successfully!",
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        backgroundColor: Colors.green);
  }
  void goToCart() {
    Get.toNamed('/cart');
  }
}