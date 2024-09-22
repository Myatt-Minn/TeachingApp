import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:teamx/app/data/user.model.dart';
import 'package:teamx/app/modules/useraccounts/controllers/useraccounts_controller.dart';

class UserWidget extends StatelessWidget {
  final UserModel user;
  final UseraccountsController controller = Get.find();

  UserWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ListTile(
      leading: FancyShimmerImage(
        height: size.width * 0.15,
        width: size.width * 0.15,
        errorWidget: const Icon(
          Icons.dangerous,
          color: Colors.red,
          size: 28,
        ),
        imageUrl: user.imageUrl,
        boxFit: BoxFit.fill,
      ),
      title: Text(user.username),
      subtitle: Text(user.email),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(
              Icons.edit,
              color: Color(0xFF8E2DE2),
            ),
            onPressed: () {
              _showEditUserDialog(context, user); // Function to edit user
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
            onPressed: () {
              _showDeleteConfirmation(context, user); // Function to delete user
            },
          ),
        ],
      ),
    );
  }

  void _showEditUserDialog(BuildContext context, UserModel user) {
    final usernameController = TextEditingController(text: user.username);
    final emailController = TextEditingController(text: user.email);
    final phoneNumberController = TextEditingController(text: user.phoneNumber);
    final addressController = TextEditingController(text: user.address);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context)
                    .viewInsets
                    .bottom, // Adjust based on keyboard
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      "Edit User",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: usernameController,
                      decoration: const InputDecoration(labelText: "Username"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: emailController,
                      decoration: const InputDecoration(labelText: "Email"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: phoneNumberController,
                      decoration:
                          const InputDecoration(labelText: "Phone Number"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: addressController,
                      decoration: const InputDecoration(labelText: "Address"),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        child: const Text("Cancel"),
                        onPressed: () {
                          Get.back(); // Close the dialog
                        },
                      ),
                      ElevatedButton(
                        child: const Text("Save"),
                        onPressed: () {
                          user.username = usernameController.text;
                          user.email = emailController.text;
                          user.phoneNumber = phoneNumberController.text;
                          user.address = addressController.text;

                          controller.editUser(user);
                          Get.back(); // Close the dialog
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
      barrierDismissible: true,
    );
  }

  void _showDeleteConfirmation(BuildContext context, UserModel user) {
    Get.defaultDialog(
      title: "Delete User",
      middleText: "Are you sure you want to delete this user?",
      textConfirm: "Yes",
      textCancel: "No",
      confirmTextColor: Colors.white,
      onConfirm: () {
        controller.deleteUser(user);
        Get.back(); // Close dialog
      },
      onCancel: () {},
    );
  }
}
