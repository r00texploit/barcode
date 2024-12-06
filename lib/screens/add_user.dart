import 'package:barcode/controller/auth_controller.dart';
import 'package:barcode/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddUser extends StatelessWidget {
  const AddUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Background gradient for a modern look
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1E3C72),
              Color(0xFF2A5298),
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
            'Add New User',
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
    return GetBuilder<AuthController>(
      init: AuthController(),
      builder: (authController) {
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
              key: authController.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Form Header
                  Text(
                    'User Details',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1E3C72),
                        ),
                  ),
                  const SizedBox(height: 20),

                  // Email Field
                  CustomTextField(
                    controller: authController.email,
                    validator: (value) => authController.validateEmail(value!),
                    lable: 'Email Address',
                    icon: const Icon(Icons.email_outlined, color: Colors.blue),
                    input: TextInputType.emailAddress,
                    obscureText: false,
                  ),
                  const SizedBox(height: 20),

                  // Phone Number Field
                  CustomTextField(
                    controller: authController.number,
                    validator: (value) => authController.validateNumber(value!),
                    lable: 'Phone Number',
                    icon: const Icon(Icons.phone_outlined, color: Colors.green),
                    input: TextInputType.phone,
                    obscureText: false,
                  ),
                  const SizedBox(height: 20),

                  // Password Field
                  CustomTextField(
                    controller: authController.password,
                    validator: (value) =>
                        authController.validatePassword(value!),
                    lable: 'Password',
                    icon: const Icon(Icons.lock_outlined, color: Colors.red),
                    input: TextInputType.visiblePassword,
                    obscureText: true,
                  ),
                  const SizedBox(height: 40),

                  // Save Button
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        authController.addUser();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('User added successfully!'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 50.0),
                        backgroundColor: const Color(0xFF1E3C72),
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
