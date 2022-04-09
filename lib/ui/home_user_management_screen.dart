import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lumoz/controllers/user_management_controller.dart';
import 'package:lumoz/models/user_management.dart';
import 'package:lumoz/ui/home_channel_screen.dart';
import 'package:lumoz/ui/home_management_screen.dart';
import 'package:lumoz/ui/reminder_screen.dart';
import 'package:lumoz/ui/splash_screen.dart';
import 'package:lumoz/ui/widgets/user_management_tile.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:lumoz/ui/wishlist_screen.dart';

import '../services/notification_service.dart';
import '../services/theme_service.dart';

class HomeUserManagementScreen extends StatefulWidget {
  final String? email;
  final String? password;

  const HomeUserManagementScreen({Key? key, this.email, this.password}) : super(key: key);

  @override
  State<HomeUserManagementScreen> createState() =>
      _HomeUserManagementScreenState();
}

class _HomeUserManagementScreenState extends State<HomeUserManagementScreen> {
  final UserManagementController _userManagementController =
      Get.put(UserManagementController());
  var notificationHelper;

  @override
  void initState() {
    super.initState();
    notificationHelper = NotificationHelper();
    notificationHelper.initializeNotification();
    notificationHelper.requestIOSPermissions();
    WidgetsFlutterBinding.ensureInitialized();
    _userManagementController.getUserManagements();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          _showChannels()
        ],
      ),
    );
  }

  _showChannels() {
    return Expanded(
      child: Obx(() {
        return ListView.builder(
            itemCount: _userManagementController.userManagementList.length,
            itemBuilder: (_, index) {
              UserManagement userManagement =
                  _userManagementController.userManagementList[index];
              print(userManagement.toJson());
              return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    child: FadeInAnimation(
                      child: Row(
                        children: [
                          GestureDetector(
                              onTap: () {
                                if (userManagement.text == 'Wish List') {
                                  Get.to(() => WishlistScreen());
                                } else if (userManagement.text == 'Channels') {
                                  Get.to(() => HomeChannelScreen());
                                } else if (userManagement.text == 'Reminders') {
                                  Get.to(() => ReminderScreen());
                                } else if (userManagement.text == 'Profile') {
                                  Get.to(() => HomeManagementScreen(
                                      email: widget.email!, password:widget.password!));
                                }
                              },
                              child: UserManagementTile(userManagement))
                        ],
                      ),
                    ),
                  ));
            });
      }),
    );
  }

  _appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap: () {
          ThemeService().switchTheme();
          notificationHelper.displayNotification(
              title: "Theme Changed",
              body: Get.isDarkMode
                  ? "Activated Lumoz Light Theme"
                  : "Activated Lumoz Dark Theme");
        },
        child: Icon(Get.isDarkMode ? Icons.wb_sunny : Icons.nightlight_round,
            size: 20, color: Get.isDarkMode ? Colors.white : Colors.black),
      ),
      actions: [
        GestureDetector(
          onTap: () {
            Get.to(() => const HomeUserManagementScreen());
          },
          child: Icon(Icons.home,
              size: 30, color: Get.isDarkMode ? Colors.white : Colors.black),
        ),
        const SizedBox(
          width: 20,
        ),
        GestureDetector(
          child: Icon(Icons.account_box,
              size: 25, color: Get.isDarkMode ? Colors.white : Colors.black),
        ),
        const SizedBox(
          width: 20,
        ),
        GestureDetector(
          onTap: () {
            Get.to(() => const SplashScreen());
          },
          child: Icon(Icons.logout,
              size: 20, color: Get.isDarkMode ? Colors.white : Colors.black),
        ),
      ],
    );
  }
}
