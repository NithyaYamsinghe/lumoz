import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lumoz/database/database_helper.dart';
import 'package:lumoz/models/channel.dart';
import 'package:lumoz/services/theme_service.dart';
import 'package:lumoz/ui/add_home_screen.dart';
import 'package:lumoz/ui/add_user_screen.dart';
import 'package:lumoz/ui/admin_management_screen.dart';
import 'package:lumoz/ui/channel_screen.dart';
import 'package:lumoz/ui/home_admin_management_screen.dart';
import 'package:lumoz/ui/home_channel_screen.dart';
import 'package:lumoz/ui/home_management_screen.dart';
import 'package:lumoz/ui/home_screen.dart';
import 'package:lumoz/ui/login_user_screen.dart';
import 'package:lumoz/ui/splash_screen.dart';
import 'package:lumoz/ui/theme.dart';
import 'package:lumoz/ui/tv_show_screen.dart';
import 'package:lumoz/ui/user_management_screen.dart';
import 'package:lumoz/ui/user_screen.dart';
import 'package:timezone/data/latest.dart' as tz;

Future<void> main() async {
  tz.initializeTimeZones();
  WidgetsFlutterBinding.ensureInitialized(); // ensure initialize
  await DatabaseHelper.initDatabase();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
        themeMode: ThemeService().theme,
        darkTheme: Themes.dark,
        home: const SplashScreen()
    );
  }
}


