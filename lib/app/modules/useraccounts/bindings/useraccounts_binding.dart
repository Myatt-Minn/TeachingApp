import 'package:get/get.dart';

import '../controllers/useraccounts_controller.dart';

class UseraccountsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UseraccountsController>(
      () => UseraccountsController(),
    );
  }
}
