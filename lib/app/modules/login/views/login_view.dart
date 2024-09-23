import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:teamx/app/data/string_consts.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: ColorConsts.priColor,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 65,
                  ),
                  const GFAvatar(
                    backgroundImage: AssetImage(StringConsts.appLogo),
                    shape: GFAvatarShape.circle,
                    size: GFSize.LARGE,
                    maxRadius: 50,
                    minRadius: 20,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Text(
                    StringConsts.appName,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    style: const TextStyle(color: Colors.black),
                    controller: controller.emailController,
                    autofocus: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(width: 4)),
                      fillColor: Colors.white,
                      filled: true,
                      label: const Text(
                        "Email:",
                        style: TextStyle(
                          //color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      icon: const Icon(
                        Icons.email,
                        //color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Obx(() => TextField(
                        style: const TextStyle(color: Colors.black),
                        obscureText: controller.obscureText.value,
                        controller: controller.passwordController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(width: 4)),
                          suffixIcon: IconButton(
                            onPressed: () {
                              controller.obscureText.value =
                                  !controller.obscureText.value;
                            },
                            icon: (!controller.obscureText.value)
                                ? const Icon(
                                    Icons.visibility,
                                    color: Colors.white,
                                  )
                                : const Icon(
                                    Icons.visibility_off,
                                    color: Colors.black,
                                  ),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          label: const Text(
                            "Password:",
                            style: TextStyle(
                              //color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                          icon: const Icon(
                            Icons.password,
                            //color: Colors.white,
                          ),
                        ),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.toNamed('/forgot-password');
                        },
                        child: Text(
                          'forgot password?',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.white,
                            fontSize: 14,
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(8)),
                    width: 150,
                    height: 50,
                    child: GFButton(
                      onPressed: () {
                        controller.signIn();
                      },
                      blockButton: true,
                      color: const Color(0xFF4A00E0),
                      child: Obx(() => (controller.isLoading.value)
                          ? const GFLoader(
                              type: GFLoaderType.ios,
                            )
                          : const Text(
                              "Login",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            )),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GFButton(
                    onPressed: () {
                      Get.toNamed('/register');
                    },
                    color: GFColors.TRANSPARENT,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Not a member? ",
                          style: TextStyle(
                              fontSize: 14,
                              color:
                                  Theme.of(context).textTheme.bodyLarge?.color),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Text(
                          "Sign up ",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.white,
                              fontSize: 16,
                              color:
                                  Theme.of(context).textTheme.bodyLarge?.color,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
