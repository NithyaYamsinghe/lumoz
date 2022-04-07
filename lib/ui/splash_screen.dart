import 'package:flutter/material.dart';
import 'package:lumoz/ui/add_admin_user_screen.dart';
import 'package:lumoz/ui/widgets/main_button.dart';
import 'package:get/get.dart';
import 'add_user_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Center(
            child: Image.asset(
          'images/lumoz.logo.1.png',
          height: 250,
          width: 300,
        )),
        const SizedBox(
          height: 20,
        ),
        MainButton(
            label: "Sign Up As Admin",
            onTap: () {
              Get.to(() => const AddAdminUserScreen());
            }),
        const SizedBox(
          height: 18,
        ),
        MainButton(
            label: "Sign Up As User",
            onTap: () {
              Get.to(() => const AddUserScreen());
            }),
      ]),
    );
  }
}
