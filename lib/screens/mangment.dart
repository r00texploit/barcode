import 'package:barcode/screens/add_admin.dart';
import 'package:barcode/screens/show_admin.dart';
import 'package:barcode/screens/show_products.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/auth_controller.dart';
import 'add_product.dart';

import '../screens/add_user.dart';
import '../screens/show_user.dart';

class Managment extends StatefulWidget {
  const Managment({Key? key}) : super(key: key);

  @override
  _ManagmentState createState() => _ManagmentState();
}

class _ManagmentState extends State<Managment> {
  AuthController auth = Get.find();
  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    final width = data.size.width;
    final height = data.size.height;
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(
          top: height / 7,
        ),
        padding: EdgeInsets.only(left: width / 8, right: width / 8),
        child: Center(
          child: GridView.count(
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              crossAxisCount: 2,
              childAspectRatio: .90,
              children: const [
                Card_d(
                  icon: Icon(Icons.add, size: 30, color: Colors.white),
                  title: 'Add User',
                  nav: AddUser(),
                ),
                Card_d(
                  icon: Icon(Icons.person, size: 30, color: Colors.white),
                  title: 'Show User',
                  nav: ShowUser(),
                ),
                Card_d(
                  icon: Icon(Icons.person, size: 30, color: Colors.white),
                  title: 'Add Product',
                  nav: AddProduct(),
                ),
                Card_d(
                  icon: Icon(Icons.manage_accounts,
                      size: 30, color: Colors.white),
                  title: 'Add Admin',
                  nav: AddAdmin(),
                ),
                Card_d(
                  icon: Icon(Icons.manage_accounts,
                      size: 30, color: Colors.white),
                  title: 'Show Admin',
                  nav: ShowAdmin(),
                ),
                Card_d(
                  icon: Icon(Icons.manage_accounts,
                      size: 30, color: Colors.white),
                  title: 'Show Products',
                  nav: Showproducts(),
                ),
              ]),
        ),
      ),
    );
  }
}

class Card_d extends StatefulWidget {
  const Card_d(
      {Key? key, required this.title, required this.icon, required this.nav})
      : super(key: key);
  final String title;
  final dynamic icon;
  final dynamic nav;

  @override
  State<Card_d> createState() => _Card_dState();
}

// ignore: camel_case_types
class _Card_dState extends State<Card_d> {
  void showBar(BuildContext context, String msg) {
    var bar = SnackBar(
      content: Text(msg),
    );
    ScaffoldMessenger.of(context).showSnackBar(bar);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => widget.nav));
      },
      child: Card(
        color: Colors.blueAccent,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Center(child: widget.icon),
              const SizedBox(
                height: 10,
              ),
              Text(widget.title, style: const TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}
