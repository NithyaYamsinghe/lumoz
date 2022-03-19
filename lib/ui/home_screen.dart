import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lumoz/services/notification_service.dart';
import 'package:lumoz/services/theme_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  var notificationHelper;

  @override
  void initState() {
    super.initState();
    notificationHelper=NotificationHelper();
    notificationHelper.initializeNotification();
    notificationHelper.requestIOSPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Column(
        children: const [
          Text("theme data",
          style: TextStyle(
            fontSize: 40
          ),)
        ],
      ),
    );
  }

  _appBar() {
    return AppBar(
      leading: GestureDetector(
        onTap:(){
           ThemeService().switchTheme();
           notificationHelper.displayNotification(
             title: "Theme Changed",
             body: Get.isDarkMode? "Activated Lumoz Light Theme": "Activated Lumoz Dark Theme"
           );
           notificationHelper.scheduledNotification();
        },
        child: Icon(Icons.nightlight_round, size: 20,),
      ),
      actions: const [
        Icon(Icons.person, size: 20,),
        SizedBox(width: 20,)
      ],
    );
  }
}
