import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamx/app/modules/admin_home/controllers/admin_home_controller.dart';

class UploadVideoDialog extends StatelessWidget {
  UploadVideoDialog({super.key});
  final TextEditingController videoNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AdminHomeController());
    return AlertDialog(
      title: const Text('Upload Video'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // TextField for Video Name
          TextField(
            controller: videoNameController,
            decoration: const InputDecoration(
              labelText: 'Video Name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),

          // Button to pick video
          ElevatedButton.icon(
              icon: const Icon(Icons.video_library),
              label: const Text('Pick Video'),
              onPressed: () {
                controller.chooseVideoFile();
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
            String videoName = videoNameController.text;
            if (videoName.isNotEmpty) {
              controller.uploadVideo(videoNameController.text);
              if (controller.finished.value == true) {
                Get.back();
              }
            } else {
              // Show an error message if video name is empty
              Get.snackbar(
                'Error',
                'Please enter a video name',
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
