import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/sendnotification_controller.dart';

class SendnotificationView extends GetView<SendnotificationController> {
  const SendnotificationView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Form"),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            const SizedBox(
              height: 10.0,
            ),
            const Text(
              "Send Notification",
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            const Text(
              "Send notification to the user",
              style: TextStyle(fontSize: 17.0),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Obx(
              () => Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      myTextFeild(
                          pnameController: controller.pnameController,
                          icon: Icons.verified_user_outlined,
                          lblname: "Title",
                          prefixcolor: Colors.purple),
                      const SizedBox(
                        height: 20.0,
                      ),
                      myTextFeild(
                          pnameController: controller.pdetailController,
                          icon: Icons.verified_user_outlined,
                          lblname: "Subtitle",
                          prefixcolor: Colors.purple),
                      const SizedBox(
                        height: 20.0,
                      ),
                      myTextFeild(
                          pnameController: controller.pbodyController,
                          icon: Icons.verified_user_outlined,
                          lblname: "Body",
                          prefixcolor: Colors.purple),
                      const SizedBox(
                        height: 20.0,
                      ),
                      // Container(
                      //   margin: const EdgeInsets.only(right: 210.0),
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(8.0),
                      //     color: Colors.purple[50],
                      //   ),
                      //   child: Row(
                      //     children: [
                      //       Checkbox(
                      //           value: controller.checked.value,
                      //           onChanged: (val) {
                      //             controller.checked.value = val!;
                      //           }),
                      //       const Text(
                      //         "On Cash",
                      //         style: TextStyle(fontSize: 18.0),
                      //       )
                      //     ],
                      //   ),
                      // ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      myBtn(context),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }

  OutlinedButton myBtn(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(minimumSize: const Size(100, 50)),
      onPressed: () async {
        if (controller.formKey.currentState!.validate()) {
          String name = controller.pnameController.text;
          String title = controller.pdetailController.text;
          String body = controller.pbodyController.text;

          if (name != "") {
            var snap = await FirebaseFirestore.instance
                .collection("users")
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .get(const GetOptions(source: Source.server));
            if (snap.exists) {
              var token = snap.get("token");
            }
          }
        }
      },
      child: const Text(
        "Send",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.purple),
      ),
    );
  }
}

class myTextFeild extends StatelessWidget {
  const myTextFeild(
      {super.key,
      required this.pnameController,
      required this.lblname,
      required this.icon,
      required this.prefixcolor});

  final TextEditingController pnameController;
  final String lblname;
  final IconData icon;
  final Color prefixcolor;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a title';
        } else {
          return null;
        }
      },
      controller: pnameController,
      decoration: InputDecoration(
        labelText: lblname,
        labelStyle: const TextStyle(color: Colors.purple),
        prefixIcon: Icon(
          icon,
          color: prefixcolor,
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.purple),
          borderRadius: BorderRadius.all(
            Radius.circular(4.0),
          ),
        ),
      ),
    );
  }
}
