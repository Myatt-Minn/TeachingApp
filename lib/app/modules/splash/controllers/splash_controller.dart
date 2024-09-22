import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  //TODO: Implement SplashController


  @override
  void onReady() async {
    super.onReady();
    await Future.delayed(const Duration(seconds: 3), () {
      checkFirstTime();
    });
  }


  void checkFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? repeat = prefs.getBool('repeat');
    if (repeat == null) {
      await prefs.setBool('repeat', true);
      Get.offAllNamed('/on-boarding');
    } else {
      Get.offAllNamed('/auth-gate');
    }
  }
}
