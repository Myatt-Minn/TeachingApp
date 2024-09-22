import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:teamx/app/data/video.model.dart';

class WatchTrainingController extends GetxController {
  RxList<VideoModel> videoList = RxList<VideoModel>();

  @override
  void onInit() {
    super.onInit();
    fetchVideos();
  }

  Future<void> fetchVideos() async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      QuerySnapshot querySnapshot =
          await firestore.collection('uploaded_videos').get();

      videoList.value = querySnapshot.docs
          .map((doc) =>
              VideoModel.fromDocument(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print("Error fetching videos: $e");
    }
  }
}
