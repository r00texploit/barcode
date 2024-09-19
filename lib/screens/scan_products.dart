import 'dart:developer';

import 'package:barcode/screens/barcode_scanner_view.dart';
import 'package:barcode/screens/details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:simple_barcode_scanner/enum.dart';
// import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

import '../controller/add_product_controller.dart';

class BarCodeScanner extends StatefulWidget {
  @override
  _BarCodeScannerState createState() => _BarCodeScannerState();
}

class _BarCodeScannerState extends State<BarCodeScanner> {
  String? _scanBarcode;
  bool isInitilized = false;
  @override
  void initState() {
    super.initState();
    _scanBarcode = "unkown product";
  }

  @override
  Widget build(BuildContext context) {
    AddProductsController controller = Get.put(AddProductsController());
    return Scaffold(
        // appBar: AppBar(title: const Text('Barcode scanner')),
        body: Builder(builder: (BuildContext context) {
      return Container(
          alignment: Alignment.center,
          child: Flex(
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () async {
                    Get.to(() => BarcodeScannerView());
                    // var res = await Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => const SimpleBarcodeScannerPage(
                    //         scanType: ScanType.barcode,
                    //       ),
                    //     ));
                    // log(res);
                    // setState(() {
                    //   //if (res is String) {
                    //   _scanBarcode = res;

                    //   //}
                    // });
                  },
                  child: const Text('Scan Product'),
                ),
                Text(_scanBarcode!),
              ]));
    }));
  }

  dynamic _fetch(String? code) async {
    AddProductsController controller = Get.put(AddProductsController());
    var prod = controller.getProductByBarcode(code!);
    return prod;
  }
}
