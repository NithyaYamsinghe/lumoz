import 'package:get/get.dart';
import 'package:lumoz/controllers/user_management_controller.dart';
import 'package:lumoz/models/user_management.dart';
import 'package:lumoz/ui/splash_screen.dart';
import 'package:lumoz/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:lumoz/ui/user_management_screen.dart';
import 'package:lumoz/ui/widgets/form_input.dart';
import 'package:lumoz/ui/widgets/main_button.dart';

import 'home_admin_management_screen.dart';

class UpdateUserManagementScreen extends StatefulWidget {
  final UserManagement userManagement;

  const UpdateUserManagementScreen({Key? key, required this.userManagement})
      : super(key: key);

  @override
  State<UpdateUserManagementScreen> createState() =>
      _UpdateUserManagementScreenState();
}

class _UpdateUserManagementScreenState
    extends State<UpdateUserManagementScreen> {
  final UserManagementController _userManagementController =
      Get.put(UserManagementController());
  TextEditingController _textController = TextEditingController();
  TextEditingController _imageController = TextEditingController();
  TextEditingController _linkController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _textController = TextEditingController(text: widget.userManagement.text);
    _imageController = TextEditingController(text: widget.userManagement.image);
    _linkController = TextEditingController(text: widget.userManagement.link);
    return Scaffold(
      appBar: _appBar(context),
      body: Container(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 30),
        child: SingleChildScrollView(
            child: Column(children: [
          Text(
            "Update User Management Tab Information",
            style: headingStyles,
          ),
          FormInput(
            inputLabel: "Text",
            inputHint: "add user management tab text",
            controller: _textController,
          ),
          const SizedBox(
            height: 18,
          ),
          FormInput(
            inputLabel: "Image URL",
            inputHint: "add user management tab image url",
            controller: _imageController,
          ),
          const SizedBox(
            height: 18,
          ),
          FormInput(
            inputLabel: "Link",
            inputHint: "add user management tab link",
            controller: _linkController,
          ),
          const SizedBox(
            height: 18,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MainButton(label: "Update Tab", onTap: () => _validateFormData())
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

  _saveFormDataToDB() {
    _userManagementController.updateUserManagementRecord(UserManagement(
        id: widget.userManagement.id,
        text: _textController.text,
        image: _imageController.text,
        link: _linkController.text));
    Get.snackbar("Success", "Updated Successfully!",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        icon: const Icon(Icons.done));
    Get.to(() => const UserManagementScreen());
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
