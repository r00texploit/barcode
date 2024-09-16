import 'package:barcodesystem/controller/add_product_controller.dart';
import 'package:barcodesystem/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      resizeToAvoidBottomInset: false,
      body: form(context),
    );
    ;
  }
}

Widget form(context) {
  TextEditingController n = TextEditingController();
  var height = MediaQuery.of(context).size.height;
  var width = MediaQuery.of(context).size.width;
  return GetBuilder<AddProductsController>(
      init: AddProductsController(),
      builder: (_) {
        return Form(
          key: _.formKey,
          child: Container(
              // height: height * 0.65,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(46),
                  topRight: Radius.circular(46),
                ),
              ),
              child: ListView(
                padding: EdgeInsets.only(top: 5),
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: _.product_name,
                        validator: (value) {
                          return _.validateAddress(value!);
                        },
                        lable: 'Product name',
                        icon: const Icon(Icons.shopping_cart_outlined),
                        input: TextInputType.text,
                      ),
                      CustomTextField(
                        controller: _.price,
                        validator: (value) {
                          return _.validateAddress(value!);
                        },
                        lable: 'price',
                        icon: const Icon(Icons.price_change),
                        input: TextInputType.text,
                      ),
                      CustomTextField(
                        controller: _.bar_code,
                        validator: (value) {
                          return _.validateAddress(value!);
                        },
                        lable: 'BarCode',
                        icon: const Icon(Icons.qr_code),
                        input: TextInputType.text,
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: TextButton(
                            onPressed: () async {
                              _.addProduct();
                            },
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                  EdgeInsets.only(
                                      top: height / 55,
                                      bottom: height / 55,
                                      left: width / 10,
                                      right: width / 10)),
                              backgroundColor: MaterialStateProperty.all(
                                  const Color.fromRGBO(19, 26, 44, 1.0)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(13),
                                      side: const BorderSide(
                                          color: Color.fromRGBO(
                                              19, 26, 44, 1.0)))),
                            ),
                            child: const Text(
                              'Save',
                              style: TextStyle(fontSize: 16),
                            )),
                      )
                    ],
                  ),
                ],
              )),
        );
      });
}
