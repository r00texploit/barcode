import 'package:barcode/controller/auth_controller.dart';
import 'package:barcode/screens/add_user.dart';
import 'package:barcode/screens/show_user.dart';
import 'package:barcode/screens/add_product.dart';
import 'package:barcode/screens/show_products.dart';
import 'package:barcode/screens/add_admin.dart';
import 'package:barcode/screens/show_admin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:barcode/screens/barcode_scanner_view.dart'; // Ensure this is imported

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({Key? key}) : super(key: key);

  @override
  _HomeAdminState createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  final AuthController auth = Get.find();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Admin Dashboard",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepOrangeAccent,
        actions: [
          IconButton(
            onPressed: () {
              auth.signOut();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Logged out successfully!"),
                  duration: Duration(seconds: 2),
                  backgroundColor: Colors.green,
                ),
              );
            },
            icon: const Icon(Icons.logout),
            tooltip: "Logout",
          ),
        ],
      ),
      body: _buildAdminDashboard(size),
    );
  }

  Widget _buildAdminDashboard(Size size) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.count(
        crossAxisCount: size.width > 600 ? 3 : 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: [
          _buildDashboardTile(
            title: "Manage Users",
            icon: Icons.people,
            color: Colors.blue,
            onTap: () => Get.to(() => const ShowUser()),
          ),
          _buildDashboardTile(
            title: "Add User",
            icon: Icons.person_add,
            color: Colors.green,
            onTap: () => Get.to(() => const AddUser()),
          ),
          _buildDashboardTile(
            title: "Scan Products",
            icon: Icons.qr_code_scanner,
            color: Colors.orange,
            onTap: () => Get.to(() => BarcodeScannerView()),
          ),
          _buildDashboardTile(
            title: "Add Product",
            icon: Icons.add_shopping_cart,
            color: Colors.teal,
            onTap: () => Get.to(() => const AddProduct()),
          ),
          _buildDashboardTile(
            title: "Show Products",
            icon: Icons.shopping_cart,
            color: Colors.purple,
            onTap: () => Get.to(() => const Showproducts()),
          ),
          _buildDashboardTile(
            title: "Add Admin",
            icon: Icons.person_add_alt_1,
            color: Colors.indigo,
            onTap: () => Get.to(() => const AddAdmin()),
          ),
          _buildDashboardTile(
            title: "Show Admin",
            icon: Icons.admin_panel_settings,
            color: Colors.blueGrey,
            onTap: () => Get.to(() => const ShowAdmin()),
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardTile({
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        color: color.withOpacity(0.9),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48, color: Colors.white),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
