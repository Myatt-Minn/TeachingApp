import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:teamx/app/data/string_consts.dart';
import 'package:video_player/video_player.dart';

class AdminHomeController extends GetxController {
  //TODO: Implement AdminHomeController

  final CollectionReference _collection =
      FirebaseFirestore.instance.collection('users');

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController licensekeyController = TextEditingController();
  final TextEditingController websiteLinkCon = TextEditingController();
  final TextEditingController phoneNumberCon = TextEditingController();

  var username = ''.obs;
  var email = ''.obs;
  var phone = ''.obs;
  var address = ''.obs;
  var role = ''.obs;
  var websitelink = StringConsts.website.obs;
  var phonenumber = StringConsts.phone.obs;
  var usercount = 0.obs;
  var pdfcount = 0.obs;
  var videocount = 0.obs;
  var bannercount = 0.obs;
  final box = GetStorage();

  var profileUrl =
      'https://static.vecteezy.com/system/resources/previews/005/129/844/non_2x/profile-user-icon-isolated-on-white-background-eps10-free-vector.jpg'
          .obs;
  Rx<bool> finished = false.obs;
  final expireOn = ''.obs;

  final Rx<bool> isChecked = true.obs;
  late StreamSubscription<DocumentSnapshot<Map<String, dynamic>>> _subscription;

  HomeController() {
    ever(isChecked, (_) => update());
  }

  @override
  void onInit() async {
    super.onInit();
    await amountCounter("uploaded_videos");
    await amountCounter("uploaded_files");
    await amountCounter("users");
    await amountCounter("images");
    _fetchIsChecked();
    loadWebsiteLink();
    loadPhoneNumber();
  }

  @override
  void onReady() async {
    super.onReady();

    DocumentSnapshot documentSnapshot =
        await _collection.doc(_auth.currentUser?.uid).get();

    username.value = documentSnapshot.get('username');
    email.value = documentSnapshot.get('email');
    phone.value = documentSnapshot.get('phoneNumber');
    address.value = documentSnapshot.get('address');
    role.value = documentSnapshot.get('role');
    profileUrl.value = documentSnapshot.get('imageUrl');

    var raw = documentSnapshot.get('expireOn').toDate();
    expireOn.value = DateFormat('MMMM d, yyyy').format(raw);
  }

  @override
  void onClose() {
    _subscription.cancel();
    super.onClose();
  }

  // Save the updated website link and show Snackbar
  void changeWebsiteLink(String name) {
    websitelink.value = name;
    Get.snackbar(
      'Updated',
      'Website Link has Updated',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF8E2DE2),
      colorText: Colors.white,
    );

    Get.back(); // Close the dialog
    // Save to GetStorage
    box.write('website_link', name);
  }

  // Load the website link from GetStorage
  void loadWebsiteLink() {
    String? savedLink = box.read('website_link');

    if (savedLink != null) {
      websitelink.value = savedLink;
    }
  }

  // Save the updated website link and show Snackbar
  void changePhoneNumber(String name) {
    phonenumber.value = name;
    Get.snackbar(
      'Updated',
      'Phone Number has Updated',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF8E2DE2),
      colorText: Colors.white,
    );

    Get.back(); // Close the dialog
    // Save to GetStorage
    box.write('phone', name);
  }

  // Load the website link from GetStorage
  void loadPhoneNumber() {
    String? savedLink = box.read('phone');

    if (savedLink != null) {
      phonenumber.value = savedLink;
    }
  }

  Future<void> amountCounter(String collectionName) async {
    try {
      // Get the reference to the specified collection
      CollectionReference collectionRef =
          FirebaseFirestore.instance.collection(collectionName);

      // Retrieve all documents in the specified collection
      QuerySnapshot collectionSnap = await collectionRef.get();

      // Return the number of documents in the collection
      int count = collectionSnap.size;

      // You can handle different counts here (e.g., update the correct count variable)
      switch (collectionName) {
        case 'uploaded_videos':
          videocount.value = count;
          break;
        case 'users':
          usercount.value = count;
          break;
        case 'uploaded_files':
          pdfcount.value = count;
          break;
        case 'images':
          bannercount.value = count;
          break;
        default:
          print('Unknown collection name');
      }

      print('Count of $collectionName: $count');
    } catch (e) {
      print('Error getting count for $collectionName: $e');
    }
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      Get.snackbar("Error", "Something went wrong");
    }
  }

  void _fetchIsChecked() {
    _subscription = FirebaseFirestore.instance
        .collection('buyingUsers')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((snapshot) {
      isChecked.value = snapshot.data()?['isChecked'] ?? true;
    });
  }

  File? selectedFile; // Global variable to store the selected file

  Future<void> chooseFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      selectedFile = File(
          result.files.single.path!); // Store the file in a global variable
      Get.snackbar(
        'PDF File Picked',
        'You have choosen a PDF file!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF8E2DE2),
        colorText: Colors.white,
      );
    } else {
      // User canceled the picker
      print('User canceled or something went wrong');
    }
  }

  Future<void> uploadPDF(String filename) async {
    if (selectedFile != null) {
      try {
        // Create a reference to the storage location
        FirebaseStorage storage = FirebaseStorage.instance;
        String filePath =
            'uploads/${DateTime.now().millisecondsSinceEpoch}.pdf'; // Unique file path
        Reference ref = storage.ref().child(filePath);

        // Upload the file to the reference
        await ref.putFile(selectedFile!);

        // Optionally, get the download URL
        String downloadUrl = await ref.getDownloadURL();
        Get.snackbar(
          'Uploaded',
          'You have successfully uploaded a PDF file!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFF8E2DE2),
          colorText: Colors.white,
        );

        storeFileData(
          downloadUrl,
          filename,
        );

        // Optionally, update UI or do something else after upload
        await amountCounter("uploaded_files");
      } catch (e) {
        print('Error occurred while uploading file: $e');
      }
    } else {
      print('No file selected');
      Get.snackbar(
        'Error',
        'Please select a file before uploading!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> storeFileData(String downloadUrl, String fileName) async {
    try {
      CollectionReference filesCollection =
          FirebaseFirestore.instance.collection('uploaded_files');

      await filesCollection.add({
        'url': downloadUrl,
        'name': fileName,
        'timestamp': FieldValue.serverTimestamp(),
        // Add any other metadata you want to store
      });

      print('File metadata stored successfully.');
    } catch (e) {
      print('Error storing file metadata: $e');
    }
  }

  File? pickedVideoFile;
  Duration? videoDuration;

  Future<void> chooseVideoFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp4', 'avi', 'mov', 'mkv'], // Video file formats
    );

    if (result != null) {
      pickedVideoFile = File(result.files.single.path!);
      Get.snackbar(
        'Picked',
        'You have picked a video file!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF8E2DE2),
        colorText: Colors.white,
      );

      // Retrieve the video duration
      videoDuration = await _getVideoDuration(pickedVideoFile!);
      if (videoDuration != null) {
        print('Video Duration: ${videoDuration!.inSeconds} seconds');
      } else {
        print('Unable to retrieve video duration.');
      }
    } else {
      // User canceled the picker or an error occurred
      print('User canceled or something went wrong');
    }
  }

  Future<Duration?> _getVideoDuration(File file) async {
    VideoPlayerController videoController = VideoPlayerController.file(file);
    await videoController.initialize();
    Duration videoDuration = videoController.value.duration;
    videoController.dispose(); // Make sure to dispose the controller after use
    return videoDuration;
  }

  Future<void> uploadVideo(String filename) async {
    if (pickedVideoFile == null || videoDuration == null) {
      Get.snackbar(
        'Error',
        'No video selected for upload',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      // Create a reference to the storage location for the video
      FirebaseStorage storage = FirebaseStorage.instance;
      String filePath =
          'uploads/videos/$filename'; // Change the path for videos
      Reference ref = storage.ref().child(filePath);

      // Upload the file to the reference (this can take time for large files)
      await ref.putFile(pickedVideoFile!);

      // Get the download URL after upload
      String downloadUrl = await ref.getDownloadURL();
      print('Video uploaded successfully. Download URL: $downloadUrl');

      Get.snackbar(
        'Video Uploaded',
        'Your video has been uploaded successfully!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF8E2DE2),
        colorText: Colors.white,
      );

      // Store the file metadata in Firestore
      await storeVideoMetadata(downloadUrl, filename, videoDuration!.inSeconds);
    } catch (e) {
      print('Error occurred while uploading video: $e');
    }
  }

  Future<void> storeVideoMetadata(
      String downloadUrl, String fileName, int videoDuration) async {
    try {
      CollectionReference videosCollection =
          FirebaseFirestore.instance.collection('uploaded_videos');

      await videosCollection.add({
        'url': downloadUrl,
        'name': fileName,
        'timestamp': FieldValue.serverTimestamp(), // Store server timestamp
        'duration': videoDuration, // Store the video duration in seconds
        // Add any other metadata (file size, etc.)
      });
      finished.value = true;
      await amountCounter("uploaded_videos");
    } catch (e) {
      print('Error storing video metadata: $e');
    }
  }

  Future<void> pickAndUploadImage() async {
    try {
      // Check and request storage permission
      if (await _requestPermission()) {
        // Pick image from gallery
        final ImagePicker _picker = ImagePicker();
        final XFile? pickedImage =
            await _picker.pickImage(source: ImageSource.gallery);

        if (pickedImage != null) {
          File imageFile = File(pickedImage.path);
          String fileName = DateTime.now().millisecondsSinceEpoch.toString();

          // Upload image to Firebase Storage
          String downloadUrl =
              await _uploadToFirebaseStorage(imageFile, fileName);

          // Store the image URL in Firestore
          await _saveImageUrlToFirestore(downloadUrl);

          // Show success notification
          Get.snackbar(
            'Image Uploaded',
            'Your Image has been uploaded successfully!',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: const Color(0xFF8E2DE2),
            colorText: Colors.white,
          );
          amountCounter("images");
        } else {
          print('No image selected.');
        }
      } else {
        print('Permission denied');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  // Request storage permission
  Future<bool> _requestPermission() async {
    PermissionStatus status = await Permission.storage.request();
    return status.isGranted;
  }

  // Upload image to Firebase Storage
  Future<String> _uploadToFirebaseStorage(
      File imageFile, String fileName) async {
    try {
      Reference storageRef =
          FirebaseStorage.instance.ref().child('images/$fileName');
      UploadTask uploadTask = storageRef.putFile(imageFile);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }

  // Save image URL to Firestore
  Future<void> _saveImageUrlToFirestore(String imageUrl) async {
    try {
      CollectionReference imagesRef =
          FirebaseFirestore.instance.collection('images');
      await imagesRef.add({
        'imageUrl': imageUrl,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to save image URL to Firestore: $e');
    }
  }

  Future<void> editWebsiteAddress() async {}

  Future<void> editFacebookPageAddress() async {}
}
