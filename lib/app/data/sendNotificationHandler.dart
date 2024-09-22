import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print("Title: ${message.notification?.title}");
  print("Body: ${message.notification?.body}");
  print("Payload: ${message.data}");
}

class SendNotificationHandler {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;
    Get.toNamed('/notification', arguments: message);
  }

  Future initPushNotification() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);

    await FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }

  Future<void> initNotification() async {
    await messaging.requestPermission();
    final fCMToken = await messaging.getToken();
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      "token": fCMToken,
    }, SetOptions(merge: true));
    print("Token $fCMToken");

    initPushNotification();
  }

  Future<void> sendPushNotification(
      String token, String title, String body) async {
    const String serverKey =
        'YOUR_SERVER_KEY'; // Your FCM server key from Firebase Console
    final Uri url = Uri.parse('https://fcm.googleapis.com/fcm/send');

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'key=$serverKey', // Server key goes here
    };

    final payload = {
      'to': token, // User's FCM device token
      'notification': {
        'title': title,
        'body': body,
      },
      'data': {
        'click_action': 'FLUTTER_NOTIFICATION_CLICK',
        'message': 'Data payload can go here',
      },
    };

    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(payload),
    );

    if (response.statusCode == 200) {
      print('Push Notification Sent!');
    } else {
      print('Failed to send push notification: ${response.body}');
    }
  }
}
