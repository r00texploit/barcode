import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class getProductDetails extends StatefulWidget {
  String scanBarcode;
  getProductDetails(this.scanBarcode, {super.key});

  @override
  State<getProductDetails> createState() => _getProductDetailsState();
}

class _getProductDetailsState extends State<getProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products Detials'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('products')
                .where("barcode", isEqualTo: widget.scanBarcode)
                .limit(1)
                .get()
                .asStream(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                var code = snapshot.data!.docs.first['barcode'];
                var name = snapshot.data!.docs.first['product_name'];
                var price = snapshot.data!.docs.first['price'];
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
                              Text('Products name: ${name}',
                                  style: const TextStyle(color: Colors.white)),
                              const SizedBox(
                                height: 5,
                              ),
                              Text('price: ${price}',
                                  style: const TextStyle(color: Colors.white)),
                              const SizedBox(
                                height: 5,
                              ),
                              Text('barcode: ${code}',
                                  style: const TextStyle(color: Colors.white)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return const Text("data");
              }

             
            }),
      ),
    );
  }
}
