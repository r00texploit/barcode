// import 'package:barcode/controller/auth_controller.dart';
// import 'package:barcode/widgets/custom_button.dart';
// import 'package:barcode/widgets/custom_textfield.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';

// class LoginPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     AuthController cd = Get.put(AuthController());

//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.white,
//         systemOverlayStyle: SystemUiOverlayStyle.dark,
//       ),
//       body: GetBuilder<AuthController>(
//         builder: (_) {
//           return Container(
//             height: MediaQuery.of(context).size.height,
//             width: double.infinity,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 _buildHeader(),
//                 _buildLoginForm(cd),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildHeader() {
//     return const Column(
//       children: [
//         Text(
//           "Login",
//           style: TextStyle(
//             fontSize: 30,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         SizedBox(height: 20),
//         Text(
//           "Welcome back! Login with your credentials",
//           style: TextStyle(
//             fontSize: 15,
//             color: Colors.grey,
//           ),
//         ),
//         SizedBox(height: 30),
//       ],
//     );
//   }

//   Widget _buildLoginForm(AuthController cd) {
//     return Form(
//       key: cd.formKey,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 40),
//         child: Column(
//           children: [
//             CustomTextField(
//               controller: cd.email,
//               validator: (value) => cd.validate(value!),
//               lable: 'Email',
//               icon: const Icon(Icons.email),
//               obscureText: false,
//               input: TextInputType.emailAddress,
//             ),
//             _buildPasswordField(cd),
//             CustomTextButton(
//               lable: 'Login',
//               ontap: () {
//                 cd.login();
//               },
//               color: Colors.blueAccent,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildPasswordField(AuthController cd) {
//     return Column(
//       children: [
//         Obx(() => TextFormField(
//               autofocus: true,
//               controller: cd.password,
//               decoration: const InputDecoration(
//                 labelText: 'Password',
//                 icon: Icon(Icons.lock),
//               ),
//               validator: (value) => cd.validatePassword(value!),
//               obscureText: cd.obscureText.value,
//             )),
//         TextButton.icon(
//           onPressed: () {
//             cd.togglePasswordVisibility();
//           },
//           label: Text(cd.obscureText.value ? "Show" : "Hide"),
//           icon: const Icon(Icons.remove_red_eye),
//         ),
//       ],
//     );
//   }
// }

import 'package:barcode/controller/auth_controller.dart';
import 'package:barcode/widgets/custom_button.dart';
import 'package:barcode/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthController cd = Get.put(AuthController());

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // Gradient Background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.blueAccent,
                  Colors.lightBlue,
                ],
              ),
            ),
          ),
          SafeArea(
            child: GetBuilder<AuthController>(
              builder: (_) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      _buildHeader(),
                      const SizedBox(height: 20),
                      _buildLoginForm(cd, context),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        // Gradient Text for Header
        Text(
          "Login",
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            foreground: Paint()
              ..shader = const LinearGradient(
                colors: <Color>[Colors.white, Colors.blueAccent],
              ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          "Welcome back! Login with your credentials",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  Widget _buildLoginForm(AuthController cd, BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Form(
        key: cd.formKey,
        child: Column(
          children: [
            // Email Field
            // _buildEmailField(cd),
            TextFormField(
              controller: cd.email,
              decoration: const InputDecoration(
                labelText: 'Email',
                icon: Icon(Icons.email, color: Colors.blueAccent),
              ),
              validator: (value) => cd.validateEmail(value!),
              obscureText: false,
            ),
            const SizedBox(height: 10),
            // Password Field
            _buildPasswordField(cd),
            const SizedBox(height: 20),
            // Login Button
            CustomTextButton(
              lable: 'Login',
              ontap: () {
                cd.login();
              },
              color: Colors.blueAccent,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordField(AuthController cd) {
    return Obx(() => Column(
          children: [
            TextFormField(
              controller: cd.password,
              decoration: InputDecoration(
                labelText: 'Password',
                icon: const Icon(Icons.lock, color: Colors.blueAccent),
                suffixIcon: IconButton(
                  icon: Icon(
                    cd.obscureText.value
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: Colors.grey,
                  ),
                  onPressed: cd.togglePasswordVisibility,
                ),
              ),
              validator: (value) => cd.validatePassword(value!),
              obscureText: cd.obscureText.value,
            ),
          ],
        ));
  }

  Widget _buildEmailField(AuthController cd) {
    return Obx(() => TextFormField(
          controller: cd.email,
          decoration: const InputDecoration(
            labelText: 'Email',
            icon: Icon(Icons.email, color: Colors.blueAccent),
          ),
          validator: (value) => cd.validateEmail(value!),
          obscureText: false,
        ));
  }
}
