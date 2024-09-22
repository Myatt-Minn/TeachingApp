import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/components/button/gf_button_bar.dart';
import 'package:getwidget/components/card/gf_card.dart';
import 'package:getwidget/components/carousel/gf_carousel.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:teamx/app/modules/home/views/widgets/my_app_bar.dart';
import 'package:teamx/app/modules/home/views/widgets/my_bottom_sheet.dart';
import 'package:teamx/app/modules/home/views/widgets/my_drawer.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      endDrawerEnableOpenDragGesture: false,
      appBar: MyAppBar(
          scaffoldKey: scaffoldKey,
          controller: controller,
          onInfoPressed: () {
            controller.bottomSheetController.isBottomSheetOpened
                ? controller.bottomSheetController.hideBottomSheet()
                : controller.bottomSheetController.showBottomSheet();
          },
          onPhonePressed: () {
            //PhoneCall.calling('09777562256');

            //await FlutterPhoneDirectCaller.callNumber('09777562256');
          },
          onNotiPressed: () {
            Get.toNamed('/notification');
          }),
      drawer: const MyDrawer(),
      bottomSheet: MyBottomSheet(controller: controller),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(
              () => controller.isLoading.value == true
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : GFCarousel(
                      passiveIndicator: GFColors.ALT,
                      activeIndicator: GFColors.DANGER,
                      autoPlay: true,
                      items: controller.imageList.map(
                        (url) {
                          return Container(
                            margin: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5.0)),
                              child: Image.network(url,
                                  fit: BoxFit.cover, width: 1000.0),
                            ),
                          );
                        },
                      ).toList(),
                      onPageChanged: (index) {
                        index;
                        controller.update();
                      },
                    ),
            ),

            const SizedBox(
              height: 19,
            ),

            // readf Doc
            GFCard(
              color: const Color.fromARGB(255, 226, 224, 224),
              boxFit: BoxFit.cover,
              image: Image.asset('assets/doc/doc.png'),
              title: const GFListTile(
                avatar: GFAvatar(
                  backgroundImage: AssetImage('assets/doc/doc.png'),
                ),
                title: Text(
                  'Documentation ဖတ်မယ်။',
                  style: TextStyle(color: Colors.black),
                ),
                // subTitle: Text('Card Sub Title'),
              ),
              // content: Text("Some quick example text to build on the card"),
              buttonBar: GFButtonBar(
                children: <Widget>[
                  GFButton(
                    onPressed: () {
                      Get.toNamed('/read-doc');
                    },
                    text: 'Let\'s Go',
                    color: const Color(0xFF8E2DE2),
                  ),
                ],
              ),
            ),
            const Divider(),
            GFCard(
              color: const Color.fromARGB(255, 213, 211, 211),
              boxFit: BoxFit.cover,
              image: Image.asset('assets/logo/xlogo.png'),
              title: const GFListTile(
                avatar: GFAvatar(
                  backgroundImage: AssetImage('assets/tuto/video.png'),
                ),
                title: Text(
                  'Training Videos များကြည့်မယ်။',
                  style: TextStyle(color: Colors.black),
                ),
                // subTitle: Text('Card Sub Title'),
              ),
              // content: Text("Some quick example text to build on the card"),
              buttonBar: GFButtonBar(
                children: <Widget>[
                  GFButton(
                    onPressed: () {
                      Get.toNamed('/watch-training');
                    },
                    text: 'Let\'s Go',
                    color: const Color(0xFF8E2DE2),
                  ),
                ],
              ),
            ),

            const Divider(),

            // Text('End of Page, Thanks...'),
            // SizedBox(
            //   height: 16,
            // ),
          ],
        ),
      ),
    );
  }
}
