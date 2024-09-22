import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/colors/gf_color.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var obscureText = true.obs;
  var isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
    isLoading.value = false;
  }

  Future<void> signIn() async {
    isLoading.value = true;
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      final user = FirebaseAuth.instance.currentUser;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user?.uid)
          .update({'password': passwordController.text});
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", e.toString(),
          backgroundColor: GFColors.DANGER, colorText: Colors.white);
    }
  }
}
