import 'package:barcode/controller/auth_controller.dart';
import 'package:barcode/widgets/custom_button.dart';
import 'package:barcode/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  bool _obscureText = true;
  String? _password;
  void _toggle() {
    _obscureText = !_obscureText;
  }

  @override
  Widget build(BuildContext context) {
    AuthController cd = Get.put(AuthController());
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        body: GetBuilder<AuthController>(
          builder: (_) {
            return Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Form(
                    key: _.formKey,
                    child: Column(
                      children: [
                        Column(
                          children: [
                            const Text(
                              "Login",
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Welcome back ! Login with your credentials",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey[700],
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Column(
                            children: [
                              CustomTextField(
                                  controller: _.email,
                                  validator: (value) {
                                    return _.validate(value!);
                                  },
                                  lable: 'Email',
                                  icon: const Icon(Icons.email),
                                  input: TextInputType.emailAddress),
                              Container(
                                  child: Column(children: <Widget>[
                                TextFormField(
                                  autofocus: true,
                                  controller: _.password,
                                  decoration: const InputDecoration(
                                      labelText: 'Password',
                                      icon: Padding(
                                          padding: EdgeInsets.only(top: 15.0),
                                          child: Icon(Icons.lock))),
                                  validator: (value) {
                                    return _.validatePassword(value!);
                                  },
                                  obscureText: _obscureText,
                                ),
                                TextButton.icon(
                                  onPressed: () {
                                    _obscureText = !_obscureText;
                                    cd.update();
                                  },
                                  label: Text(_obscureText ? "Show" : "Hide"),
                                  icon: const Icon(Icons.remove_red_eye),
                                )
                              ])),
                              // CustomTextField(
                              //     controller: _.password,
                              //     validator: (value) {
                              //       return _.validatePassword(value!);
                              //     },
                              //     lable: 'Password',
                              //     icon: const Icon(Icons.lock),
                              //     input: TextInputType.text
                              //     ),
                            ],
                          ),
                        ),
                        CustomTextButton(
                            lable: 'Login',
                            ontap: () {
                              _.login();
                            },
                            color: Colors.blueAccent)
                        // SizedBox(
                        //   height: 20,
                        // ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     Text("Dont have an account?"),
                        //     Text(
                        //       "Sign Up",
                        //       style:4
                        //           Te                         رxtStyle(fontWeight: FontWeight.w600, fontSize: 18),
                        //     ),
                        //   ],
                        // )
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }
}
