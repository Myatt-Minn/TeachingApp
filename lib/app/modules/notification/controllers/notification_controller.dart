import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class NotificationController extends GetxController {
  //TODO: Implement NotificationController

  final count = 0.obs;

  List<dynamic> messages = [].obs;
  void increment() => count.value++;
  final box = GetStorage();

  @override
  void onInit() async {
    super.onInit();
    List<dynamic>? savedMessages = box.read<List<dynamic>>('messages');
    if (savedMessages != null) {
      messages.addAll(savedMessages); // Load persisted messages
    }

    var message = Get.arguments;
    if (message != null) {
      messages.add(message); // Add new message
      box.write('messages', messages); // Persist the updated list
    }
  }
}
