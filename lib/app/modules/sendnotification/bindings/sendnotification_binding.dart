import 'package:get/get.dart';

import '../controllers/sendnotification_controller.dart';

class SendnotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SendnotificationController>(
      () => SendnotificationController(),
    );
  }
}
