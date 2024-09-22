import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:teamx/app/modules/home/controllers/home_controller.dart'; // Ensure you have the correct import for GFAppBar

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Function onInfoPressed;
  final Function onPhonePressed;
  final Function onNotiPressed;

  const MyAppBar(
      {super.key,
      required this.scaffoldKey,
      required this.onInfoPressed,
      required HomeController controller,
      required this.onPhonePressed,
      required this.onNotiPressed});

  @override
  Widget build(BuildContext context) {
    return GFAppBar(
      backgroundColor: const Color(0xFF8E2DE2),
      leading: GFIconButton(
        icon: const Icon(
          Icons.menu,
          color: Colors.white,
        ),
        onPressed: () {
          scaffoldKey.currentState!.openDrawer();
        },
        type: GFButtonType.transparent,
      ),
      title: const Text("teamx"),
      actions: <Widget>[
        GFIconButton(
          icon: const Icon(
            Icons.notification_add_outlined,
            color: Colors.white,
          ),
          onPressed: () => onNotiPressed(),
          type: GFButtonType.transparent,
        ),
        GFIconButton(
          icon: const Icon(
            Icons.info_outline_rounded,
            color: Colors.white,
          ),
          onPressed: () => onInfoPressed(),
          type: GFButtonType.transparent,
        ),
        GFIconButton(
          icon: const Icon(
            Icons.phone_android_outlined,
            color: Colors.white,
          ),
          onPressed: () => onPhonePressed(),
          type: GFButtonType.transparent,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
