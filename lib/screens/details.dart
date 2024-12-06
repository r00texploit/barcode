import 'dart:developer';

import 'package:barcode/controller/add_product_controller.dart';
import 'package:barcode/controller/cart_controller.dart';
import 'package:barcode/model/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetProductDetails extends StatefulWidget {
  final Map<String, dynamic> product;

  const GetProductDetails(this.product, {Key? key}) : super(key: key);

  @override
  State<GetProductDetails> createState() => _GetProductDetailsState();
}

class _GetProductDetailsState extends State<GetProductDetails> {
  final AddProductsController addProductsController =
      Get.put(AddProductsController());
  final CartController cartController = Get.put(CartController());

  bool loading = false;

  @override
  void initState() {
    super.initState();
    log("GetProductDetails => ${widget.product}");
    loading = false;
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(12.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildProductCard(product),
                    const SizedBox(height: 20),
                    _buildActions(context, product),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    return Card(
      color: const Color.fromRGBO(19, 26, 44, 1.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product['products_name'] ?? 'Unknown Product',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Price: \$${product['price'] ?? 'N/A'}',
              style: const TextStyle(fontSize: 16, color: Colors.white70),
            ),
            const SizedBox(height: 5),
            Text(
              'Barcode: ${product['barcode'] ?? 'N/A'}',
              style: const TextStyle(fontSize: 16, color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActions(BuildContext context, Map<String, dynamic> product) {
    return Column(
      children: [
        ElevatedButton.icon(
          onPressed: () {
            final cartItem = CartItem.fromMap(product);
            cartController.addToCart(cartItem, 1);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Added to Cart'),
                duration: Duration(seconds: 2),
                backgroundColor: Colors.green,
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          icon: const Icon(Icons.add_shopping_cart),
          label: const Text(
            'Add to Cart',
            style: TextStyle(fontSize: 16),
          ),
        ),
        const SizedBox(height: 15),
        ElevatedButton.icon(
          onPressed: () {
            Get.toNamed('/cart');
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            backgroundColor: Colors.deepOrangeAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          icon: const Icon(Icons.shopping_cart),
          label: const Text(
            'Go to Cart',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
