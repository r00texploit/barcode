import 'dart:developer';

import 'package:barcode/controller/cart_controller.dart';
import 'package:barcode/model/cart_model.dart';
import 'package:barcode/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartPage extends StatefulWidget {
  final Product? product;

  const CartPage({super.key, this.product});
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final CartController cartManager = Get.put(CartController());
  List<CartItem> cartItems = [];

  @override
  void initState() {
    super.initState();
    _loadCart();
  }

  void _loadCart() async {
    await cartManager.loadCartItems();
    setState(() {
      cartItems = cartManager.cartItems;
    });
  }

  // void _addItemToCart(Product product) async {
  //   if (product.id != null &&
  //       product.product_name != null &&
  //       product.price != null) {
  //     // Convert the Product into CartItem
  //     CartItem newItem = CartItem(
  //       id: product
  //           .barcode!, // Use '!' to ensure non-null value since you've checked for null
  //       name: product.product_name!,
  //       quantity: product.quantity ?? 1, // If quantity is null, default to 1
  //       price: product.price!
  //           .toDouble(), // Convert int price to double for CartItem
  //     );

  //     cartManager.addToCart(newItem);
  //     _loadCart();
  //   } else {
  //     // Handle the case when product details are missing
  //     print("Product information is incomplete");
  //   }
  // }

  void _removeItem(String itemId) async {
    cartManager.removeFromCart(itemId);
    _loadCart();
  }

  void _clearCart() async {
    cartManager.clearCart();
    _loadCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Cart'),
          actions: [
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: _clearCart,
            ),
          ],
        ),
        body: cartManager.cartItems.isEmpty
            ? const Center(
                child: Text('No items in cart.'),
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: cartManager.cartItems.length,
                      itemBuilder: (context, index) {
                        log("`cart`" + cartManager.cartItems[index].toString());
                        // final item = cartManager.cartItems[index];
                        // final product = Product.fromJson(item);
                        return ListTile(
                          leading: Text(cartManager.cartItems[index].name),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  '${cartManager.cartItems[index].quantity} x ${cartManager.cartItems[index].price!}'),
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove),
                                    onPressed: () {
                                      cartManager
                                          .removeFromCart(cartItems[index].id);
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.add),
                                    onPressed: () {
                                      cartManager.addToCart(cartItems[index]);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              cartManager.removeFromCart(cartItems[index].id);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total:'),
                        Text('\$${cartManager.totalPrice}'),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        cartManager.checkout();
                      },
                      child: const Text('Checkout'),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      cartManager.clearCart();
                    },
                    child: const Text('Clear Cart'),
                  ),
                ],
              ));
  }
  // }),
}




// import 'dart:developer';

// import 'package:barcode/controller/cart_controller.dart';
// import 'package:barcode/model/product_model.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class CartScreen extends StatelessWidget {
//   // final cartController = Get.put(CartController());

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<CartController>(builder: (cartController) {
//       return Scaffold(
//           appBar: AppBar(
//             title: const Text('Cart'),
//           ),
//           body: cartController.cartItems.isEmpty
//               ? const Center(
//                   child: Text('No items in cart.'),
//                 )
//               : Column(
//                   children: [
//                     Expanded(
//                       child: ListView.builder(
//                         itemCount: cartController.cartItems.length,
//                         itemBuilder: (context, index) {
//                           log("`cart`" +
//                               cartController.cartItems[index].toString());
//                           final item = cartController.cartItems[index];
//                           final product = Product.fromJson(item);
//                           return ListTile(
//                             leading: Text(product.product_name!),
//                             title: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text('${product.quantity} x ${product.price!}'),
//                                 Row(
//                                   children: [
//                                     IconButton(
//                                       icon: const Icon(Icons.remove),
//                                       onPressed: () {
//                                         cartController.removeFromCart(product);
//                                       },
//                                     ),
//                                     IconButton(
//                                       icon: const Icon(Icons.add),
//                                       onPressed: () {
//                                         cartController.addToCart(
//                                             product,1, product.toJson());
//                                       },
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                             trailing: IconButton(
//                               icon: const Icon(Icons.delete),
//                               onPressed: () {
//                                 cartController.removeFromCart(product);
//                               },
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text('Total:'),
//                           Text('\$${cartController.totalPrice.value}'),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: ElevatedButton(
//                         onPressed: () {
//                           cartController.checkout();
//                         },
//                         child: const Text('Checkout'),
//                       ),
//                     ),
//                     ElevatedButton(
//                       onPressed: () {
//                         cartController.clearCart();
//                       },
//                       child: const Text('Clear Cart'),
//                     ),
//                   ],
//                 ));
//     }
//         // }),
//         );
//   }
// }
