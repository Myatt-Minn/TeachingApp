import 'package:get/get.dart';

import '../controllers/upload_pdf_controller.dart';

class UploadPdfBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UploadPdfController>(
      () => UploadPdfController(),
    );
  }
}
