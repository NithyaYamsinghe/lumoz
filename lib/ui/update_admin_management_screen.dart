import 'package:get/get.dart';
import 'package:lumoz/controllers/admin_management_controller.dart';
import 'package:lumoz/models/admin_management.dart';
import 'package:lumoz/ui/splash_screen.dart';
import 'package:lumoz/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:lumoz/ui/widgets/form_input.dart';
import 'package:lumoz/ui/widgets/main_button.dart';

import 'admin_management_screen.dart';
import 'home_admin_management_screen.dart';

class UpdateAdminManagementScreen extends StatefulWidget {
  final AdminManagement adminManagement;

  const UpdateAdminManagementScreen({Key? key, required this.adminManagement})
      : super(key: key);

  @override
  State<UpdateAdminManagementScreen> createState() =>
      _UpdateAdminManagementScreenState();
}

class _UpdateAdminManagementScreenState
    extends State<UpdateAdminManagementScreen> {
  final AdminManagementController _adminManagementController =
      Get.put(AdminManagementController());
  TextEditingController _textController = TextEditingController();
  TextEditingController _imageController = TextEditingController();
  TextEditingController _linkController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _textController = TextEditingController(text: widget.adminManagement.text);
    _imageController =
        TextEditingController(text: widget.adminManagement.image);
    _linkController = TextEditingController(text: widget.adminManagement.link);
    return Scaffold(
      appBar: _appBar(context),
      body: Container(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 30),
        child: SingleChildScrollView(
            child: Column(children: [
          Text(
            "Update Admin Management Tab Information",
            style: headingStyles,
          ),
          FormInput(
            inputLabel: "Text",
            inputHint: "add admin management tab text",
            controller: _textController,
          ),
          const SizedBox(
            height: 18,
          ),
          FormInput(
            inputLabel: "Image URL",
            inputHint: "add admin management tab image url",
            controller: _imageController,
          ),
          const SizedBox(
            height: 18,
          ),
          FormInput(
            inputLabel: "Link",
            inputHint: "add admin management tab link",
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
    _adminManagementController.updateAdminManagementRecord(AdminManagement(
        id: widget.adminManagement.id,
        text: _textController.text,
        image: _imageController.text,
        link: _linkController.text));
    Get.snackbar("Success", "Updated Successfully!",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        icon: const Icon(Icons.done));
    Get.to(() => const AdminManagementScreen());
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
