import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:teamx/app/modules/admin_home/controllers/admin_home_controller.dart';

class PdfDialog extends StatelessWidget {
  PdfDialog({super.key});
  final TextEditingController pdfContoller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AdminHomeController());
    return AlertDialog(
      title: const Text('Upload Pdf File'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // TextField for Video Name
          TextField(
            controller: pdfContoller,
            decoration: const InputDecoration(
              labelText: 'PDF Name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),

          // Button to pick video
          ElevatedButton.icon(
              icon: const Icon(Icons.video_library),
              label: const Text('Pick .pdf file'),
              onPressed: () {
                controller.chooseFile();
              }),
        ],
      ),
      actions: [
        // Cancel button
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Get.back(); // Closes the dialog
          },
        ),
        // Upload button
        ElevatedButton(
          child: const Text('Upload'),
          onPressed: () {
            String pdfName = pdfContoller.text;
            if (pdfName.isNotEmpty) {
              controller.uploadPDF(pdfContoller.text);
              if (controller.finished.value == true) {
                Get.back();
              }
            } else {
              // Show an error message if video name is empty
              Get.snackbar(
                'Error',
                'Please enter a pdf name',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.red,
                colorText: Colors.white,
              );
            }
          },
        ),
      ],
    );
  }
}
