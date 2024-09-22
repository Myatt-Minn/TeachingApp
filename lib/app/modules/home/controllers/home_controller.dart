import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/bottom_sheet/gf_bottom_sheet.dart';
import 'package:intl/intl.dart';
import 'package:teamx/app/data/sendNotificationHandler.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  // Observable variable to track the current theme
  var isDarkMode = false.obs;

  GFBottomSheetController bottomSheetController = GFBottomSheetController();
  var imageList = [
    // "https://cdn.pixabay.com/photo/2017/12/03/18/04/christmas-balls-2995437_960_720.jpg",
    // "https://cdn.pixabay.com/photo/2017/12/13/00/23/christmas-3015776_960_720.jpg",
    // "https://cdn.pixabay.com/photo/2019/12/19/10/55/christmas-market-4705877_960_720.jpg",
    // "https://cdn.pixabay.com/photo/2019/12/20/00/03/road-4707345_960_720.jpg",
    // "https://cdn.pixabay.com/photo/2019/12/22/04/18/x-mas-4711785__340.jpg",
    // "https://cdn.pixabay.com/photo/2016/11/22/07/09/spruce-1848543__340.jpg"
  ].obs;

  final CollectionReference _collection =
      FirebaseFirestore.instance.collection('users');

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController licensekeyController = TextEditingController();

  var username = ''.obs;
  var email = ''.obs;
  var phone = ''.obs;
  var address = ''.obs;
  var role = ''.obs;
  var profileUrl = ''.obs;

  final expireOn = ''.obs;

  final Rx<bool> isChecked = true.obs;
  final Rx<bool> isLoading = true.obs;
  late StreamSubscription<DocumentSnapshot<Map<String, dynamic>>> _subscription;

  HomeController() {
    ever(isChecked, (_) => update());
  }

  @override
  void onInit() async {
    super.onInit();
    _fetchIsChecked();
    await SendNotificationHandler().initNotification();
    await retrieveAllImages("images");
  }

  @override
  void onReady() async {
    super.onReady();
    DocumentSnapshot documentSnapshot =
        await _collection.doc(_auth.currentUser?.uid).get();

    username.value = documentSnapshot.get('username');
    email.value = documentSnapshot.get('email');
    phone.value = documentSnapshot.get('phoneNumber');
    address.value = documentSnapshot.get('address');
    role.value = documentSnapshot.get('role');
    profileUrl.value = documentSnapshot.get('imageUrl');

    var raw = documentSnapshot.get('expireOn').toDate();
    expireOn.value = DateFormat('MMMM d, yyyy').format(raw);
  }

  @override
  void onClose() {
    _subscription.cancel();
    super.onClose();
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      Get.snackbar("Error", "Something went wrong");
    }
  }

  void _fetchIsChecked() {
    _subscription = FirebaseFirestore.instance
        .collection('buyingUsers')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((snapshot) {
      isChecked.value = snapshot.data()?['isChecked'] ?? true;
    });
  }

  // Toggle between dark and light mode
  void toggleTheme() {
    if (isDarkMode.value) {
      Get.changeTheme(ThemeData.light());
    } else {
      Get.changeTheme(ThemeData.dark());
    }
    isDarkMode.value = !isDarkMode.value;
  }

  Future<void> retrieveAllImages(String collectionId) async {
    try {
      // Get all documents from the specified collection
      isLoading.value = true;
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection(collectionId).get();

      // Extract the 'imageUrl' field from each document and return as a list
      List<String> imageUrls =
          snapshot.docs.map((doc) => doc['imageUrl'] as String).toList();

      imageList.value = imageUrls;
      isLoading.value = false;
    } catch (e) {
      print('Error retrieving images: $e');
    }
  }
}
