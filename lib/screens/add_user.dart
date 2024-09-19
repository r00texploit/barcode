import 'package:barcode/controller/auth_controller.dart';
import 'package:barcode/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/add_product_controller.dart';

class AddUser extends StatelessWidget {
  const AddUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add User'),
      ),
      resizeToAvoidBottomInset: false,
      body: form(context),
    );
  }
}

Widget form(context) {
  TextEditingController n = TextEditingController();
  var height = MediaQuery.of(context).size.height;
  var width = MediaQuery.of(context).size.width;
  return GetBuilder<AuthController>(
      init: AuthController(),
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
                        controller: _.email,
                        validator: (value) {
                          return _.validateEmail(value!);
                        },
                        lable: 'user email',
                        icon: const Icon(Icons.numbers),
                        input: TextInputType.text,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: _.number,
                        validator: (value) {
                          return _.validateNumber(value!);
                        },
                        lable: 'user number',
                        icon: const Icon(Icons.numbers),
                        input: TextInputType.number,
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        controller: _.password,
                        validator: (value) {
                          return _.validatePassword(value!);
                        },
                        lable: 'user password',
                        icon: const Icon(Icons.visibility),
                        input: TextInputType.visiblePassword,
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: TextButton(
                            onPressed: () async {
                              _.addUser();
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
