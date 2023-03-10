import 'package:barcodesystem/controller/auth_controller.dart';
import 'package:barcodesystem/screens/scan_products.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthController auth = Get.find();
  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    final width = data.size.width;
    final height = data.size.height;
    return Scaffold(
      appBar: AppBar(title: Text("app Bar"), actions: [
        IconButton(
            onPressed: () {
              auth.signOut();
            },
            icon: Icon(Icons.logout))
      ]),
      body: BarCodeScanner(),
    );
  }
}
