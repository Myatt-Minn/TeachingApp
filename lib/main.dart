import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:teamx/app/modules/splash/bindings/splash_binding.dart';

import 'app/routes/app_pages.dart';

final navigatorkey = GlobalKey<NavigatorState>();
void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    GetMaterialApp(
      title: "teamx",
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      //initialRoute: isFirstTime ? AppPages.ON_BOARDING : AppPages.MY_HOME,
      initialRoute: AppPages.INITIAL,
      initialBinding: SplashBinding(),
      getPages: AppPages.routes,
    ),
  );
}
