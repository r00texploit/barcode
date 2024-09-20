import 'dart:developer';

import 'package:barcode/controller/add_product_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class getProductDetails extends StatefulWidget {
  Map<String, dynamic> product;
  getProductDetails(this.product, {super.key});

  @override
  State<getProductDetails> createState() => _getProductDetailsState();
}

class _getProductDetailsState extends State<getProductDetails> {
  Map<String, dynamic>? productData;
  AddProductsController addProductsController =
      Get.put(AddProductsController());
  bool loading = false;
  var snap;
  @override
  void initState() {
    super.initState();
    loading = true;
    log("message: getProductDetails => ${widget.product}");
    // getSnap();
  }

  // getSnap() async {
  //   try {
  //     await addProductsController.getProductByBarcode(widget.product).then(
  //       (value) {
  //         setState(() {
  //           addProductsController.update();
  //           productData = addProductsController.pro;
  //           loading = false;
  //         });
  //         if (productData == null || productData!.isEmpty) {
  //           ScaffoldMessenger.of(context).showSnackBar(
  //             SnackBar(content: Text('Product not found')),
  //           );
  //         }
  //       },
  //     );
  //   } catch (error) {
  //     setState(() {
  //       loading = false;
  //     });
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Error fetching product: $error')),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Products Detials'),
        ),
        body: loading
            ? Padding(
                padding: const EdgeInsets.all(12.0),
                child: ListView.builder(
                  itemCount: 1,
                  itemBuilder: (BuildContext context, int index) {
                    log(widget.product['products_name'].toString());
                    log(widget.product['price'].toString());
                    log(widget.product['barcode'].toString());
                    return Column(
                      children: [
                        SizedBox(
                          height: 150,
                          child: Card(
                            color: const Color.fromRGBO(19, 26, 44, 1.0),
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                      'Products name: ${widget.product['products_name']}',
                                      style:
                                          const TextStyle(color: Colors.white)),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text('price: ${widget.product['price']}',
                                      style:
                                          const TextStyle(color: Colors.white)),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text('barcode: ${widget.product['barcode']}',
                                      style:
                                          const TextStyle(color: Colors.white)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ))
            : const Center(
                child: CircularProgressIndicator(),
              ));
  }
}
