import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/notification_controller.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NotificationView'),
        centerTitle: true,
      ),
      body: controller.messages.isEmpty
          ? const Center(
              child: Text("No notifications yet"),
            )
          : Center(
              child: ListView.builder(
                  itemCount: controller.messages.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        tileColor: const Color.fromARGB(255, 200, 203, 202),
                        leading: const Icon(
                          Icons.info,
                          color: Colors.deepPurpleAccent,
                        ),
                        title: Text(
                            "${controller.messages[index].notification?.title}"),
                        subtitle: Text(
                            "${controller.messages[index].notification?.body}"),
                        trailing: Text("${controller.messages[index].data}"),
                      ),
                    );
                  }),
            ),
    );
  }
}
