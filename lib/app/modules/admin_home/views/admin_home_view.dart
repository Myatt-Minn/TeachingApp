import 'dart:ffi';

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:teamx/app/data/string_consts.dart';
import 'package:teamx/app/modules/admin_home/views/widgets/panel_widget.dart';
import 'package:teamx/app/modules/admin_home/views/widgets/pdf_dialog.dart';
import 'package:teamx/app/modules/admin_home/views/widgets/upload_dialog.dart';

import '../controllers/admin_home_controller.dart';

class AdminHomeView extends GetView<AdminHomeController> {
  const AdminHomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 216, 216, 216),
      appBar: GFAppBar(
        backgroundColor: const Color(0xFF8E2DE2),
        title: const Text("${StringConsts.appName} - Admin"),
        actions: <Widget>[
          GFIconButton(
            icon: const Icon(
              Icons.logout_outlined,
              color: Colors.white,
            ),
            onPressed: () {
              controller.signOut();
            },
            type: GFButtonType.transparent,
          ),
        ],
      ),
      body: Column(
        children: [
          Obx(() => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color(0xFF202244),
                ),
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Dashboard",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Welcome to ${StringConsts.appName} App",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              NetworkImage(controller.profileUrl.value),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          controller.username.value,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
          Obx(
            () => Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.2,
                  children: [
                    PanelWidget(
                      title: 'Total User Account',
                      icon: Icons.person,
                      count: '${controller.usercount.value} accounts',
                      actionText: 'View Details',
                      onPressed: () {
                        Get.toNamed('/useraccounts');
                      },
                    ),
                    PanelWidget(
                      title: 'Banner',
                      icon: Icons.photo,
                      count: '${controller.bannercount.value} photos',
                      actionText: 'Update',
                      onPressed: () async {
                        controller.pickAndUploadImage();
                      },
                    ),
                    PanelWidget(
                      title: 'Total Documentation',
                      icon: Icons.file_present,
                      count: '${controller.pdfcount.value} documents',
                      actionText: 'Update',
                      onPressed: () {
                        Get.dialog(PdfDialog());
                      },
                    ),
                    PanelWidget(
                      title: 'Total Video',
                      icon: Icons.videocam,
                      count: '${controller.videocount.value} videos',
                      actionText: 'Update',
                      onPressed: () {
                        Get.dialog(UploadVideoDialog());
                      },
                    ),
                    PanelWidget(
                      title: 'Website',
                      icon: Icons.web,
                      count: controller.websitelink.value,
                      actionText: 'Update',
                      onPressed: () {
                        Get.dialog(
                          AlertDialog(
                            title: const Text('Enter Website Link'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextField(
                                  controller: controller.websiteLinkCon,
                                  decoration: const InputDecoration(
                                      hintText: 'Enter Website Link'),
                                ),
                              ],
                            ),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  controller.changeWebsiteLink(
                                      controller.websiteLinkCon.text);
                                  Get.snackbar(
                                    'Updated',
                                    'Website Name has Updated',
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: const Color(0xFF8E2DE2),
                                    colorText: Colors.white,
                                  );

                                  Get.back(); // Close the dialog
                                },
                                child: const Text('Submit'),
                              ),
                            ],
                          ),
// Dialog won't close on outside tap
                        );
                      },
                    ),
                    PanelWidget(
                      title: 'Phone Number',
                      icon: Icons.phone,
                      count: controller.phonenumber.value,
                      actionText: 'Update',
                      onPressed: () {
                        Get.dialog(
                          AlertDialog(
                            title: const Text('Enter Phone Number'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextField(
                                  controller: controller.phoneNumberCon,
                                  decoration: const InputDecoration(
                                      hintText: 'Enter Phone Number'),
                                ),
                              ],
                            ),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  controller.changePhoneNumber(
                                      controller.phoneNumberCon.text);
                                  Get.snackbar(
                                    'Updated',
                                    'Phone Number has Updated',
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: const Color(0xFF8E2DE2),
                                    colorText: Colors.white,
                                  );

                                  Get.back(); // Close the dialog
                                },
                                child: Text('Submit'),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
              color: const Color.fromARGB(255, 216, 216, 216),
              child: Obx(() => Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.email.value,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                controller.phone.value,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: 80,
                            height: 80,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/doc/adminimg.webp"))),
                          )
                        ],
                      ),
                    ),
                  ))),
        ],
      ),
    );
  }
}
