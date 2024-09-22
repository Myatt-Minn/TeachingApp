import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  //TODO: Implement RegisterController

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phonenumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  late File file;

  Rx<String> selectedItem = 'Yangon Region'.obs;
  List<String> items = [
    'Ayeyarwady Region',
    'Bago Region',
    'Chin State',
    'Kachin State',
    'Kayin State',
    'Kayah State',
    'Magway Region',
    'Mandalay Region',
    'Mon State',
    'Rakhine State',
    'Sagaing Region',
    'Shan State',
    'Tanintharyi Region',
    'Yangon Region',
  ];

  bool isUsernameValid = false;
  bool isPhonenumberValid = false;
  bool isPasswordValid = false;
  var isProfileImageChooseSuccess = false.obs;
  var isSignUpLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
    isProfileImageChooseSuccess.value = false;
  }

  Future<void> chooseImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      file = File(result.files.single.path!);
      isProfileImageChooseSuccess.value = true;
    } else {
      // User canceled the picker
      Get.snackbar("Cancel", "No Image");
    }
  }

  Future<void> signUp() async {
    if (!isProfileImageChooseSuccess.value) {
      Get.snackbar("Profile Image", 'Choose image please');
      return;
    }

    if (usernameController.text.length > 6) {
      isUsernameValid = true;
    } else {
      Get.snackbar("Username", 'Username is too short');
      return;
    }

    if (passwordController.text.length > 5) {
      isPasswordValid = true;
    } else {
      Get.snackbar("Password", "Password is too short");
      return;
    }
    if (phonenumberController.text.length > 8) {
      isPasswordValid = true;
    } else {
      Get.snackbar("PhoneNumber", "Enter a valid Phone number");
      return;
    }
    try {
      isSignUpLoading.value = true;
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);
      String userId = userCredential.user!.uid;
      String imageUrl = await uploadProfileImage(file);
      createUserInDb(userId, imageUrl);
      Get.offAllNamed('/home');
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  Future<String> uploadProfileImage(File imageFile) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference storageRef = storage.ref();
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference imageRef = storageRef.child('profileImages/$fileName');

    UploadTask uploadTask = imageRef.putFile(imageFile);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);

    String imageUrl = await taskSnapshot.ref.getDownloadURL();
    return imageUrl;
  }

  Future<void> createUserInDb(String userId, String imageUrl) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'userId': userId,
        'username': usernameController.text,
        'email': emailController.text,
        'password': passwordController.text,
        'phoneNumber': phonenumberController.text,
        'address': selectedItem.value,
        'role': 'user',
        'expireOn': DateTime.now(),
        'imageUrl': imageUrl,
        // Add any other user-specific data you want to store
      });
    } catch (e) {
      print(e.toString());
    }
  }
}

class TappableTextSpan extends TextSpan {
  final VoidCallback onTap;

  TappableTextSpan({
    required TextStyle style,
    required String text,
    required this.onTap,
  }) : super(
          text: text,
          style: style,
          recognizer: TapGestureRecognizer()..onTap = onTap,
        );
}
