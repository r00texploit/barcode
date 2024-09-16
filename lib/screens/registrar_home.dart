import 'package:barcodesystem/controller/auth_controller.dart';
import 'package:barcodesystem/screens/scan_products.dart';
import 'package:barcodesystem/screens/show_product.dart';
import 'package:barcodesystem/screens/show_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistrarHome extends StatefulWidget {
  const RegistrarHome({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<RegistrarHome> {
  AuthController auth = Get.find();
  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    final width = data.size.width;
    final height = data.size.height;
    return Scaffold(
      appBar: AppBar(title: const Text('user HomePage'), actions: [
        IconButton(
            onPressed: () {
              auth.signOut();
            },
            icon: Icon(Icons.logout))
      ]),
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
              children: [
                Card_d(
                  icon: const Icon(Icons.add, size: 30, color: Colors.white),
                  title: 'Scan a Product',
                  nav: BarCodeScanner(),
                ),
                const Card_d(
                  icon: Icon(Icons.person, size: 30, color: Colors.white),
                  title: 'Show All Products',
                  nav: ShowProduct(),
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
