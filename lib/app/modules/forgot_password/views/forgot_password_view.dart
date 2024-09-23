import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/forgot_password_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Recovery Password")),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/password_recovery/1.png', height: 200),
                SizedBox(height: 20),
                TextField(
                  decoration: InputDecoration(
                    labelText: "Enter Your Email Address",
                    prefixIcon: Icon(Icons.email),
                  ),
                  onChanged: (value) => controller.email.value = value,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: controller.sendPasswordResetEmail,
                  child: Text("Continue"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
