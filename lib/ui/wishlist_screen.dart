import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lumoz/ui/splash_screen.dart';
import '../services/theme_service.dart';
import 'add_wishlist_items_screen.dart';
import 'home_wishlist_screen.dart';

class WishlistScreen extends StatelessWidget {
  final navigatorKey = GlobalKey<NavigatorState>();
  var notificationHelper;

  @override
  void initState() {
    notificationHelper.initializeNotification();
    notificationHelper.requestIOSPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeService().theme,
      navigatorKey:navigatorKey,
      home: Scaffold(
        appBar: _appBar(context),
        body: const HomeWishlistScreen(),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.push(context,
                MaterialPageRoute(builder: (context)=>AddWishlistItemsScreen())
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  _appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Icon(Icons.arrow_back_ios_new_outlined,
            size: 20, color: Get.isDarkMode ? Colors.white : Colors.black),
      ),
      actions: [
        const CircleAvatar(
            backgroundImage: AssetImage("images/profile.jpg")
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
