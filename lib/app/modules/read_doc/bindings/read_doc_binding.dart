import 'package:get/get.dart';

import '../controllers/read_doc_controller.dart';

class ReadDocBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReadDocController>(() => ReadDocController());
  }
}
