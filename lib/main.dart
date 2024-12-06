import 'package:barcode/controller/auth_controller.dart';
import 'package:barcode/screens/add_product.dart';
import 'package:barcode/screens/cart_screen.dart';
import 'package:barcode/screens/details.dart';
import 'package:barcode/screens/home_admin.dart';
import 'package:barcode/screens/home_user.dart';
import 'package:barcode/screens/scan_products.dart';
import 'package:barcode/screens/sign_in_page.dart';
import 'package:barcode/screens/welcome_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(AuthController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => HomeScreen()),
        GetPage(name: '/cart', page: () => CartPage()),
        GetPage(name: '/scan', page: () => BarCodeScanner()),
        GetPage(name: '/add_product', page: () => const AddProduct()),
        GetPage(name: '/admin', page: () => HomeAdmin()),
        GetPage(name: '/login', page: () => LoginPage()),
      ],
      home: const WelcomePage(),
    );
  }
}
