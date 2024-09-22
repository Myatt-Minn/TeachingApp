import 'package:flutter/material.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:getwidget/components/bottom_sheet/gf_bottom_sheet.dart';
import 'package:teamx/app/modules/home/controllers/home_controller.dart';

class MyBottomSheet extends StatelessWidget {
  const MyBottomSheet({
    super.key,
    required this.controller,
  });

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return GFBottomSheet(
      controller: controller.bottomSheetController,
      maxContentHeight: 150,
      contentBody: Container(
        height: 200,
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: ListView(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          children: const [
            Center(
                child: Text(
              'Getwidget reduces your overall app development time to minimum 30% because of its pre-build clean UI widget that you can use in flutter app development. We have spent more than 1000+ hours to build this library to make flutter developer’s life easy.',
              style:
                  TextStyle(fontSize: 15, wordSpacing: 0.3, letterSpacing: 0.2),
            ))
          ],
        ),
      ),
      stickyFooter: Container(
        color: GFColors.SUCCESS,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Get in touch',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              'info@getwidget.dev',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          ],
        ),
      ),
      stickyFooterHeight: 50,
    );
  }
}
