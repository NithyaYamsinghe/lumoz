import 'package:get/get.dart';
import 'package:lumoz/ui/splash_screen.dart';
import 'package:lumoz/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:lumoz/ui/widgets/form_input.dart';
import 'package:lumoz/ui/widgets/main_button.dart';
import '../controllers/home_controller.dart';
import '../models/home.dart';
import 'home_admin_management_screen.dart';

class AddHomeScreen extends StatefulWidget {
  const AddHomeScreen({Key? key}) : super(key: key);

  @override
  State<AddHomeScreen> createState() => _AddHomeScreenState();
}

class _AddHomeScreenState extends State<AddHomeScreen> {
  final HomeController _homeController = Get.put(HomeController());
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _linkController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Container(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 30),
        child: SingleChildScrollView(
            child: Column(children: [
          Text(
            "Add New Home Tab Information",
            style: headingStyles,
          ),
          FormInput(
            inputLabel: "Text",
            inputHint: "add home tab text",
            controller: _textController,
          ),
          const SizedBox(
            height: 18,
          ),
          FormInput(
            inputLabel: "Image URL",
            inputHint: "add home tab image url",
            controller: _imageController,
          ),
          const SizedBox(
            height: 18,
          ),
          FormInput(
            inputLabel: "Link",
            inputHint: "add home tab link",
            controller: _linkController,
          ),
          const SizedBox(
            height: 18,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MainButton(label: "Create Tab", onTap: () => _validateFormData())
            ],
          )
        ])),
      ),
    );
  }

  _validateFormData() {
    if (_textController.text.isNotEmpty &&
        _imageController.text.isNotEmpty &&
        _linkController.text.isNotEmpty) {
      _saveFormDataToDB();
      Get.back();
    } else if (_textController.text.isEmpty &&
        _imageController.text.isEmpty &&
        _linkController.text.isEmpty) {
      Get.snackbar("Required", "All fields are required!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          icon: const Icon(Icons.warning_amber_rounded));
    }else if (_textController.text.isEmpty ) {
      Get.snackbar("Required", "Text required!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          icon: const Icon(Icons.warning_amber_rounded));
    }else if (
    _imageController.text.isEmpty ) {
      Get.snackbar("Required", "Image required!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          icon: const Icon(Icons.warning_amber_rounded));
    }
    else if (
    _linkController.text.isEmpty ) {
      Get.snackbar("Required", "Link required!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          icon: const Icon(Icons.warning_amber_rounded));
    }
  }

  _saveFormDataToDB() async {
     await _homeController.addHome(
        home: Home(
            text: _textController.text,
            image: _imageController.text,
            link: _linkController.text));
     Get.snackbar("Success", "Added Successfully!",
         snackPosition: SnackPosition.TOP,
         backgroundColor: Colors.green,
         icon: const Icon(Icons.done));
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
      actions:  [
        GestureDetector(
          onTap: () {
            Get.to(() => const HomeAdminManagementScreen());
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
              size: 25, color: Get.isDarkMode ? Colors.white : Colors.black),
        ),
      ],
    );
  }
}
