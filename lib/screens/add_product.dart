import 'package:barcode/controller/add_product_controller.dart';
import 'package:barcode/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Gradient background for consistency with modern UI
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF6A11CB),
              Color(0xFF2575FC),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(context),
              const SizedBox(height: 20),
              Expanded(
                child: _buildForm(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: const Icon(Icons.arrow_back_ios, color: Colors.white),
          ),
          const SizedBox(width: 10),
          Text(
            'Add New Product',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return GetBuilder<AddProductsController>(
      init: AddProductsController(),
      builder: (productController) {
        return Container(
          padding: const EdgeInsets.all(20.0),
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Form(
              key: productController.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Form Header
                  Text(
                    'Product Details',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF6A11CB),
                        ),
                  ),
                  const SizedBox(height: 20),

                  // Product Name Field
                  CustomTextField(
                    controller: productController.product_name,
                    validator: (value) =>
                        productController.validateAddress(value!),
                    lable: 'Product Name',
                    icon: const Icon(Icons.shopping_cart_outlined,
                        color: Colors.blue),
                    input: TextInputType.text,
                    obscureText: false,
                  ),
                  const SizedBox(height: 20),

                  // Price Field
                  CustomTextField(
                    controller: productController.price,
                    validator: (value) =>
                        productController.validateAddress(value!),
                    lable: 'Price',
                    icon: const Icon(Icons.attach_money_outlined,
                        color: Colors.green),
                    input: TextInputType.number,
                    obscureText: false,
                  ),
                  const SizedBox(height: 20),

                  // Barcode Field
                  CustomTextField(
                    controller: productController.bar_code,
                    validator: (value) =>
                        productController.validateAddress(value!),
                    lable: 'Barcode',
                    icon: const Icon(Icons.qr_code_2_outlined,
                        color: Colors.deepOrange),
                    input: TextInputType.text, 
                    obscureText: false,
                  ),
                  const SizedBox(height: 40),

                  // Save Button
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        productController.addProduct();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Product added successfully!'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 50.0),
                        backgroundColor: const Color(0xFF6A11CB),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Save',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
