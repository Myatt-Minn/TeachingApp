import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:teamx/app/data/color_consts.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'teamx - Sign Up',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w600,
            color: ColorConsts.blackColor,
          ),
        ),
        backgroundColor: ColorConsts.scaffoldBgColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Image Choose View
                Obx(() {
                  return Container(
                    width: 100,
                    height: 100,
                    color: Colors.grey.shade300,
                    child: controller.isProfileImageChooseSuccess.value
                        ? Image.file(controller.file)
                        : const Center(
                            child: Text(
                            "?",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          )),
                  );
                }),
                const SizedBox(
                  height: 10,
                ),
                // Choose Image
                Obx(() => GFButton(
                      onPressed: !controller.isProfileImageChooseSuccess.value
                          ? () {
                              controller.chooseImage();
                            }
                          : null,
                      color: ColorConsts.priColor,
                      child: const Text("Choose Image..."),
                    )),

                // Username:
                TextField(
                  controller: controller.usernameController,
                  decoration: const InputDecoration(
                    label: Text("UserName: "),
                    suffixIcon: Icon(Icons.person),
                    hintText: 'SMT User',
                  ),
                ),

                // Email:
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: controller.emailController,
                  decoration: const InputDecoration(
                    label: Text("Email: "),
                    suffixIcon: Icon(Icons.email),
                    hintText: 'smtuser@gmail.com',
                  ),
                ),

                // Password:
                TextField(
                  controller: controller.passwordController,
                  decoration: const InputDecoration(
                    label: Text("Password: "),
                    suffixIcon: Icon(Icons.lock),
                    hintText: '******',
                  ),
                ),

                // PhoneNumber:
                TextField(
                  keyboardType: TextInputType.phone,
                  controller: controller.phonenumberController,
                  decoration: const InputDecoration(
                    label: Text("Phone Number: "),
                    suffixIcon: Icon(Icons.phone),
                    hintText: '09xxxxxxxx',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                // Address:
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Address: "),
                    Obx(
                      () => DropdownButton<String>(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        borderRadius: BorderRadius.circular(10),
                        hint: const Text("Address: "),
                        style: const TextStyle(
                          color: ColorConsts.blackColor,
                        ),
                        value: controller.selectedItem.value,
                        onChanged: (newValue) {
                          controller.selectedItem.value = newValue ?? '';
                        },
                        items: controller.items
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 20,
                ),
                // Signup Button
                Obx(
                  () => GFButton(
                    onPressed: controller.isSignUpLoading.value
                        ? null
                        : () {
                            controller.signUp();
                          },
                    color: ColorConsts.priColor,
                    blockButton: true,
                    child: controller.isSignUpLoading.value
                        ? const GFLoader()
                        : const Text('Sign Up'),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(children: [
                    const TextSpan(
                      text: 'အကောင့်ဖွင့်ခြင်းဆိုင်ရာ ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                      ),
                    ),
                    TappableTextSpan(
                      style: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                      text: 'စည်းမျဥ်းစည်းကမ်း',
                      onTap: () {
                        // Add your onTap logic for the "colorful text" here
                        Get.toNamed('/rules');
                      },
                    ),
                    const TextSpan(
                      text: ' နှင့် ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                      ),
                    ),
                    TappableTextSpan(
                      style: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                      text: 'လုံခြုံရေးမူဝါဒများ',
                      onTap: () {
                        // Add your onTap logic for the "colorful text" here
                        Get.toNamed('/privacy-policy');
                      },
                    ),
                    const TextSpan(
                      text: 'ကို သဘောတူနားလည်ပြီးဖြစ်ပါသည်။',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
