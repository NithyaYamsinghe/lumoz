import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lumoz/database/database_helper.dart';
import 'package:lumoz/services/theme_service.dart';
import 'package:lumoz/ui/reminder_screen.dart';
import 'package:lumoz/ui/theme.dart';

Future<void> main() async {
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
        home: const ReminderScreen()
    );
  }
}


