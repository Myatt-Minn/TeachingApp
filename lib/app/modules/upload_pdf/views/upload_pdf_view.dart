import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/upload_pdf_controller.dart';

class UploadPdfView extends GetView<UploadPdfController> {
  const UploadPdfView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UploadPdfView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'UploadPdfView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
