import 'dart:convert';
import 'package:barcode/model/cart_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartController extends GetxController {
  var cartItems = <CartItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadCartItems();
  }
  double get totalPrice => cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));

  // Load cart items from SharedPreferences
  Future<void> loadCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    final cartString = prefs.getString('cartItems');
    if (cartString != null) {
      List<dynamic> cartJson = jsonDecode(cartString);
      cartItems.value = cartJson.map((item) => CartItem.fromMap(item)).toList();
    }
  }

  // Add item to cart
  void addToCart(CartItem item) {
    int existingIndex = cartItems.indexWhere((i) => i.id == item.id);
    if (existingIndex != -1) {
      var quantity = cartItems[existingIndex].quantity;
      quantity = quantity + item.quantity;
    } else {
      cartItems.add(item);
    }
    saveCartItems();
  }

  // Remove item from cart
  void removeFromCart(String? itemId) {
    cartItems.removeWhere((item) => item.id == itemId);
    saveCartItems();
  }

  // Save cart items to SharedPreferences
  Future<void> saveCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      'cartItems',
      jsonEncode(cartItems.map((i) => i.toMap()).toList()),
    );
  }

  // Clear the entire cart
  void clearCart() {
    cartItems.clear();
    saveCartItems();
  }

  void checkout() {
    // Implement checkout logic here
    // For example:
    // 1. Clear the cart
    clearCart();
    // 2. Navigate to a confirmation screen
    Get.toNamed('/');
    // 3. Process the order (e.g., send data to a server)
    Get.snackbar(
      'Checkout Successful',
      'Your order has been placed!',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
    );
    // ...
  }
}



// import 'dart:convert';
// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:barcode/model/product_model.dart';
// import 'add_product_controller.dart';

// var products = Get.put(AddProductsController());

// class CartController extends GetxController {
//   List<Map<String, dynamic>> cartItems = [{}];
//   var totalPrice = 0.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     loadCart();
//   }

//   void removeFromCart(Product product) {
//     cartItems.removeWhere((item) => item['barcode'] == product.barcode);
//     totalPrice.value -= product.price!;
//     saveCart(cartItems);
//     update();
//   }

//   void clearCart() {
//     cartItems.clear();
//     totalPrice.value = 0;
//     saveCart(cartItems);
//     update();
//   }

//   Future<void> loadCart() async {
//     final prefs = await SharedPreferences.getInstance();
//     var cartJson = await prefs.getString('cart');
//     log("Loading cart items from SharedPreferences...");
//     if (cartJson != null) {
//       final cartList = jsonDecode(cartJson) as List<dynamic>;
//       cartItems = cartList.map((item) => item as Map<String, dynamic>).toList();
//       totalPrice.value =
//           cartItems.fold(0, (sum, item) => sum + (item['price'] as int));
//     } else {
//       cartItems = [];
//       totalPrice.value = 0;
//     }
//     log("Cart loaded successfully.");
//     update();
//   }

//   void addToCart(Product prod, int quantity, Map<String, dynamic> i) async {
//     final prefs = await SharedPreferences.getInstance();
//     try {
//       log("Get the current cart from shared preferences");
//       List<Map<String, dynamic>>? cart = await getCart();
//       log("Check if the product already exists in the cart");
//       bool productExists =
//           cart?.any((item) => item['barcode'] == prod.barcode!) ?? false;
//       if (productExists) {
//         log("If the product exists, update the quantity");
//         cart!.asMap().forEach((index, item) {
//           if (item['barcode'] == prod.barcode!) {
//             cart[index]['quantity'] = (item['quantity'] ?? 0) + quantity;
//           }
//         });
//       } else {
//         log("If the product doesn't exist, add it to the cart");
//         Map<String, dynamic>? product = i;
//         cart!.add({
//           'product_name': product['product_name'],
//           'barcode': product['barcode'],
//           'price': product['price'],
//           'quantity': quantity,
//         });
//         await prefs.setString('cart', jsonEncode(cart));
//         log("Product added to cart: ${product['product_name']}");
//       }
//       cartItems = cart!;
//       await saveCart(cart);
//     } catch (e) {
//       log("Error adding product to cart: $e");
//     }
//   }

//   Future<List<Map<String, dynamic>>> getCart() async {
//     try {
//       final SharedPreferences prefs = await SharedPreferences.getInstance();
//       String? cartJson = prefs.getString('cart');
//       if (cartJson != null && cartJson.isNotEmpty) {
//         final List<dynamic> cartList = jsonDecode(cartJson);
//         return cartList.cast<Map<String, dynamic>>();
//       } else {
//         return []; // Return an empty list directly if cartJson is null or empty
//       }
//     } catch (e) {
//       log("Error getting cart from shared preferences: $e");
//       return []; // Return an empty list in case of an error
//     }
//   }

//   Future<void> saveCart(List<Map<String, dynamic>> list) async {
//     try {
//       // Encode the cart to JSON
//       final String cartJson = jsonEncode(list);
//       // Save the cart to shared preferences
//       final SharedPreferences prefs = await SharedPreferences.getInstance();
//       await prefs.setString('cart', cartJson);
//     } catch (e) {
//       log("Error saving cart to shared preferences: $e");
//     }
//   }

//   Future<void> checkout() async {
//     // Implement checkout logic here
//     // For example, you could navigate to a checkout screen
//     // or process the order directly
//     // ...
//     // 1. Clear the cart
//     clearCart();
//     // 2. Show a success message or navigate to a confirmation screen
//     Get.snackbar("Checkout", "Your order has been placed successfully!",
//         snackPosition: SnackPosition.BOTTOM,
//         colorText: Colors.white,
//         backgroundColor: Colors.green);
//   }

//   void goToCart() {
//     Get.toNamed('/cart');
//   }
// }
