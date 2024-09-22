import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:teamx/app/modules/useraccounts/views/widgets/user_widget.dart';

import '../controllers/useraccounts_controller.dart';

class UseraccountsView extends GetView<UseraccountsController> {
  const UseraccountsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('GG'),
          centerTitle: true,
        ),
        body: Obx(() {
          // If the pdfList is empty, show a loading indicator or "no documents found"
          if (controller.userList.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
              itemCount: controller.userList.length,
              itemBuilder: (context, index) {
                return UserWidget(
                  user: controller.userList[index],
                );
              });
        }));
  }
}
