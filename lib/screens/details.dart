import 'dart:developer';

import 'package:barcode/controller/add_product_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class getProductDetails extends StatefulWidget {
  String scanBarcode;
  getProductDetails(this.scanBarcode, {super.key});

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
    log("message: ${widget.scanBarcode}");
    getSnap();
  }

  getSnap() async {
    await addProductsController
        .getProductByBarcode(widget.scanBarcode);
    //     .then((onValue) {
    //   if (onValue != null) {
        setState(() {
          productData = addProductsController.pro;
          loading = false;
        });
    //   } else {
    //     // Handle the case when no product is found
    //     setState(() {
    //       loading = false;
    //     });
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(content: Text('Product not found')),
    //     );
    //   }
    // }).catchError((error) {
    //   // Handle any errors that occur during the fetch
    //   setState(() {
    //     loading = false;
    //   });
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text('Error fetching product: $error')),
    //   );
    // });
  }

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
                    // log(addProductsController.pro!['product_name'].toString());
                    // log(addProductsController.pro!['price'].toString());
                    // log(addProductsController.pro!['barcode'].toString());
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
                                      'Products name: ${addProductsController.pro!['product_name']}',
                                      style:
                                          const TextStyle(color: Colors.white)),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text('price: ${addProductsController.pro!['price']}',
                                      style:
                                          const TextStyle(color: Colors.white)),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text('barcode: ${addProductsController.pro!['barcode']}',
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
