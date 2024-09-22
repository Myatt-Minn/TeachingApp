import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SendnotificationController extends GetxController {
  //TODO: Implement SendnotificationController

  final count = 0.obs;
  final pnameController = TextEditingController();
  final pdetailController = TextEditingController();
  final pbodyController = TextEditingController();
  var checked = false.obs;
  final formKey = GlobalKey<FormState>();

  void increment() => count.value++;
}
