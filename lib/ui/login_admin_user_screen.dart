import 'package:lumoz/ui/home_admin_management_screen.dart';
import 'package:lumoz/ui/home_management_screen.dart';
import 'package:get/get.dart';
import 'package:lumoz/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:lumoz/ui/widgets/form_input.dart';
import 'package:lumoz/ui/widgets/main_button.dart';
import 'package:lumoz/controllers/user_controller.dart';

class LoginAdminUserScreen extends StatefulWidget {
  const LoginAdminUserScreen({Key? key}) : super(key: key);

  @override
  State<LoginAdminUserScreen> createState() => _LoginAdminUserScreenState();
}

class _LoginAdminUserScreenState extends State<LoginAdminUserScreen> {
  final UserController _userController = Get.put(UserController());
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

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
            "Administrator Sign In",
            style: headingStyles,
          ),
          FormInput(
            inputLabel: "Email",
            inputHint: "email",
            controller: _emailTextController,
          ),
          FormInput(
            inputLabel: "Password",
            inputHint: "password",
            controller: _passwordTextController,
          ),
          const SizedBox(
            height: 18,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MainButton(
                  label: "Sign In",
                  onTap: () {
                    _validateFormData();
                  })
            ],
          )
        ])),
      ),
    );
  }

  _validateFormData() {
    if (_emailTextController.text.isNotEmpty &&
        _passwordTextController.text.isNotEmpty) {
      _userController.getUser(_emailTextController.text, _passwordTextController.text);
      if (_userController.selectedUserList.isNotEmpty) {
        Get.snackbar("Success", "Sign In Successfully!",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            icon: const Icon(Icons.done));
        Get.to(() => const HomeAdminManagementScreen());
      }
      else if(_userController.selectedUserList.isEmpty){
        Get.snackbar("Error", "Email or Password Incorrect!",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.redAccent,
            icon: const Icon(Icons.warning_amber_rounded));
      }
    } else if (_emailTextController.text.isEmpty &&
        _passwordTextController.text.isEmpty) {
      Get.snackbar("Required", "All fields are required!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          icon: const Icon(Icons.warning_amber_rounded));
    }
    else if (
    _passwordTextController.text.isEmpty) {
      Get.snackbar("Required", "Password required!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          icon: const Icon(Icons.warning_amber_rounded));
    }
    else if (_emailTextController.text.isEmpty ) {
      Get.snackbar("Required", "Email required!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          icon: const Icon(Icons.warning_amber_rounded));
    }
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
    );
  }
}
