import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamx/app/modules/forgot_password/controllers/forgot_password_controller.dart';
class ResetPasswordView extends StatelessWidget {
  ResetPasswordView({super.key});
  final ForgotPasswordController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Reset Password")),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/password_recovery/3.png', height: 200),
                const SizedBox(height: 20),
                const Text("Enter Your New Password"),
                TextField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "New Password",
                    prefixIcon: Icon(Icons.lock),
                  ),
                  onChanged: (value) => controller.newPassword.value = value,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: controller.resetPassword,
                  child: const Text("Reset Password"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}