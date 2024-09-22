import 'package:get/get.dart';

import '../controllers/watch_training_controller.dart';

class WatchTrainingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WatchTrainingController>(
      () => WatchTrainingController(),
    );
  }
}
