import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/read_doc_controller.dart';

class ReadDocView extends GetView<ReadDocController> {
  const ReadDocView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ReadDocView'),
      ),
      body: Obx(() {
        // If the pdfList is empty, show a loading indicator
        if (controller.pdfList.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        // Display the list of PDFs in a GridView
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Two columns
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.75, // Adjust aspect ratio
            ),
            itemCount: controller.pdfList.length,
            itemBuilder: (context, index) {
              var pdf = controller.pdfList[index];
              return _buildPdfItem(pdf, context);
            },
          ),
        );
      }),
    );
  }

  Widget _buildPdfItem(Map<String, dynamic> pdf, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // PDF Icon
              Expanded(
                child: Center(
                  child: Image.asset(
                    'assets/pdf_icon.jpg', // Replace with your PDF icon asset
                    height: 80,
                    width: 80,
                  ),
                ),
              ),
              // PDF name
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  pdf['name'],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          // Download button in the top-right corner
          Positioned(
            top: 10,
            right: 10,
            child: IconButton(
              icon: const Icon(Icons.download, color: Colors.purple),
              onPressed: () {
                _launchURL(pdf['url']);
              },
            ),
          ),
        ],
      ),
    );
  }

  // Method to launch the PDF URL
  void _launchURL(String urlString) async {
    Uri url = Uri.parse(urlString);

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $urlString';
    }
  }
}
