import 'package:barcodesystem/controller/auth_controller.dart';
import 'package:barcodesystem/screens/add_user.dart';
import 'package:barcodesystem/screens/mangment.dart';
import 'package:barcodesystem/screens/scan_products.dart';
import 'package:barcodesystem/screens/show_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeAdmin extends StatefulWidget {
  HomeAdmin({Key? key}) : super(key: key);

  @override
  _HomeAdminState createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  AuthController auth = Get.find();
  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    final width = data.size.width;
    final height = data.size.height;
    return Scaffold(
      appBar: AppBar(title: Text("Admin Dashbord"), actions: [
       
        IconButton(
            onPressed: () {
              auth.signOut();
            },
            icon: Icon(Icons.logout))
      ]),
      body: Managment(),
    );
  }
}
