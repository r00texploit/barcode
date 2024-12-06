// import 'package:barcode/controller/auth_controller.dart';
// import 'package:barcode/controller/cart_controller.dart';
// import 'package:barcode/screens/scan_products.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class HomeScreen extends StatefulWidget {
//   HomeScreen({Key? key}) : super(key: key);

//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   AuthController auth = Get.find();
//   CartController cartController = Get.put(CartController());
//   @override
//   Widget build(BuildContext context) {
//     final data = MediaQuery.of(context);
//     final width = data.size.width;
//     final height = data.size.height;
//     return Scaffold(
//       appBar: AppBar(title: Text("app Bar"), actions: [
//         IconButton(
//             onPressed: () {
//               auth.signOut();
//             },
//             icon: Icon(Icons.logout)),
//         IconButton(
//             onPressed: () {
//               Get.toNamed("/cart");
//             },
//             icon: Icon(Icons.shopping_cart))
//       ]),
//       body: BarCodeScanner(),
//     );
//   }
// }


import 'package:barcode/controller/auth_controller.dart';
import 'package:barcode/controller/cart_controller.dart';
import 'package:barcode/screens/scan_products.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthController auth = Get.find();
  final CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Home",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              auth.signOut();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Successfully logged out!"),
                  duration: Duration(seconds: 2),
                  backgroundColor: Colors.green,
                ),
              );
            },
            icon: const Icon(Icons.logout),
            tooltip: "Logout",
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                onPressed: () {
                  Get.toNamed("/cart");
                },
                icon: const Icon(Icons.shopping_cart),
                tooltip: "Go to Cart",
              ),
              Obx(() {
                return cartController.cartItems.isNotEmpty
                    ? Positioned(
                        right: 8,
                        top: 8,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 18,
                            minHeight: 18,
                          ),
                          child: Text(
                            '${cartController.cartItems.length}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    : const SizedBox.shrink();
              }),
            ],
          ),
        ],
      ),
      body: _buildBody(size),
    );
  }

  Widget _buildBody(Size size) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child:  BarCodeScanner(),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            onPressed: () {
              Get.toNamed("/cart");
            },
            child: const Text(
              "Go to Cart",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
