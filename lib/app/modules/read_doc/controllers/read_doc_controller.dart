import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ReadDocController extends GetxController {
  // List to hold PDF data
  var pdfList = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    fetchPDFs(); // Fetch PDFs on controller initialization
    super.onInit();
  }

  Future<void> fetchPDFs() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('uploaded_files')
          .orderBy('timestamp', descending: true)
          .get();

      var loadedPDFs = querySnapshot.docs
          .map((doc) => {
                'url': doc['url'],
                'name': doc['name'],
                'timestamp': doc['timestamp'],
              })
          .toList();

      pdfList.assignAll(loadedPDFs); // Update the observable list
    } catch (e) {
      print('Error fetching PDFs: $e');
    }
  }
}
