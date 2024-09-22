import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/image/gf_image_overlay.dart';

class OnBoardingController extends GetxController {
  //TODO: Implement OnBoardingController

  late PageController pageController;
  List<Widget> slideList = [];
  int initialPage = 0;

  @override
  void onInit() {
    pageController = PageController(initialPage: 0);
    super.onInit();
  }

  List<Widget> slides(context) {
    List<Widget> slideList = [
      Container(
        child: GFImageOverlay(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(16),
          color: Colors.orange,
          image: const AssetImage('assets/logo.png'),
          boxFit: BoxFit.contain,
          colorFilter:
              ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.darken),
          borderRadius: BorderRadius.circular(5),
          child: const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 70.0, left: 20),
                child: Text(
                  'Welcome!',
                  style: TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.none,
                      fontSize: 25),
                ),
              ),
            ],
          ),
        ),
      ),
      Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
            image: DecorationImage(
              image: const AssetImage('assets/logo.png'),
              fit: BoxFit.contain,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.2), BlendMode.darken),
            )),
      ),
      Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
            image: DecorationImage(
              image: const AssetImage('assets/logo.png'),
              fit: BoxFit.contain,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.2), BlendMode.darken),
            )),
      ),
      Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
            image: DecorationImage(
              image: const AssetImage('assets/logo.png'),
              fit: BoxFit.contain,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.2), BlendMode.darken),
            )),
      ),
    ];
    return slideList;
  }
}
