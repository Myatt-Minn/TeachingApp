import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:teamx/app/modules/home/controllers/home_controller.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return GFDrawer(
      child: Stack(
        children: <Widget>[
          // The ListView for the main drawer content
          ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              GFDrawerHeader(
                centerAlign: true,
                currentAccountPicture: GFAvatar(
                  radius: 80.0,
                  backgroundImage: NetworkImage(controller.profileUrl.value),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(
                      height: 14,
                    ),
                    Text(
                      'Username: ${controller.username.value}',
                      style: const TextStyle(color: GFColors.WHITE),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      '${controller.email}, ${controller.phone}',
                      style: const TextStyle(
                        color: GFColors.WHITE,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      'Account Type: ${controller.role}',
                      style: const TextStyle(
                        color: GFColors.WHITE,
                      ),
                    ),
                  ],
                ),
              ),

              // Setting & Privacy
              const Padding(
                padding: EdgeInsets.only(
                  left: 16,
                ),
                child: Text(
                  'Setting & Privacy',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const ListTile(
                leading: Icon(Icons.language_outlined),
                title: Text('Language'),
                onTap: null,
              ),
              Obx(
                () => ListTile(
                  leading: const Icon(Icons.dark_mode_outlined),
                  title: Text(
                    controller.isDarkMode.value
                        ? "Dark Mode is ON"
                        : "Light Mode is ON",
                    style: const TextStyle(fontSize: 18),
                  ),
                  onTap: () {
                    controller.toggleTheme();
                  },
                ),
              ),
              const ListTile(
                leading: Icon(Icons.password_outlined),
                title: Text('Recovery Password'),
                onTap: null,
              ),
              const ListTile(
                leading: Icon(Icons.privacy_tip),
                title: Text('Privacy Policy'),
                onTap: null,
              ),
              const Divider(
                color: Colors.black, // Line color
                thickness: 0.5, // Line thickness
                height: 16, // Space around the line
                indent: 19,
                endIndent: 19,
              ),

              // Help & Support
              const Padding(
                padding: EdgeInsets.only(
                  left: 16,
                ),
                child: Text(
                  'Help & Support',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const ListTile(
                leading: Icon(Icons.language_outlined),
                title: Text('Call Center'),
                onTap: null,
              ),
              const ListTile(
                leading: Icon(Icons.message_outlined),
                title: Text('Send Message'),
                onTap: null,
              ),
              const ListTile(
                leading: Icon(Icons.web_stories),
                title: Text('Go to website'),
                onTap: null,
              ),
              const Divider(
                color: Colors.black, // Line color
                thickness: 0.5, // Line thickness
                height: 16, // Space around the line
                indent: 19,
                endIndent: 19,
              ),
              const ListTile(
                leading: Icon(Icons.language_outlined),
                title: Text('Share this app'),
                onTap: null,
              ),
              const Divider(
                color: Colors.black, // Line color
                thickness: 0.5, // Line thickness
                height: 16, // Space around the line
                indent: 19,
                endIndent: 19,
              ),

              // logout
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: GFButton(
                  onPressed: () {
                    Get.snackbar(
                      'Info',
                      'Signing out!',
                      backgroundColor: GFColors.INFO,
                    );
                    controller.signOut();
                  },
                  color: GFColors.WARNING,
                  icon: const Icon(Icons.logout_outlined),
                  child: const Text(
                    'Logout',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: GFColors.DARK,
                    ),
                  ),
                ),
              ),

              // delete account
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: GFButton(
                  onPressed: () {
                    Get.snackbar('Info', 'Deleting account!');
                    controller.signOut();
                  },
                  color: GFColors.DANGER,
                  icon: const Icon(
                    Icons.remove_circle_outline,
                    color: GFColors.WHITE,
                  ),
                  child: const Text(
                    'Delete Account',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // The footer positioned at the bottom
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: const Text(
                '© 2024 app.com.mm. All rights reserved.',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black, // Change color as needed
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
