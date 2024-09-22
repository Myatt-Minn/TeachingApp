import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamx/app/modules/watch_training/views/video_player_screen.dart';
import '../controllers/watch_training_controller.dart';

class WatchTrainingView extends GetView<WatchTrainingController> {
  const WatchTrainingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Videos'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.videoList.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemCount: controller.videoList.length,
            itemBuilder: (context, index) {
              final video = controller.videoList[index];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Card(
                  elevation: 4.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Video Player Section
                      VideoPlayerWidget(videoUrl: video.url),
                      const SizedBox(height: 10),
                      // Metadata Section
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              video.name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Duration: ${video.duration} seconds',
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      }),
    );
  }
}
