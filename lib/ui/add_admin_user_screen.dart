import 'package:lumoz/ui/login_admin_user_screen.dart';
import 'package:lumoz/ui/login_user_screen.dart';
import 'package:lumoz/ui/splash_screen.dart';
import '../models/user.dart';
import 'package:get/get.dart';
import 'package:lumoz/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:lumoz/ui/widgets/form_input.dart';
import 'package:lumoz/ui/widgets/main_button.dart';
import 'package:lumoz/controllers/user_controller.dart';

class AddAdminUserScreen extends StatefulWidget {
  const AddAdminUserScreen({Key? key}) : super(key: key);

  @override
  State<AddAdminUserScreen> createState() => _AddAdminUserScreenState();
}

class _AddAdminUserScreenState extends State<AddAdminUserScreen> {
  final UserController _userController = Get.put(UserController());
  final TextEditingController _userNameTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _confirmPasswordTextController =
      TextEditingController();

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
            "Administrator Sign Up",
            style: headingStyles,
          ),
          FormInput(
            inputLabel: "User Name",
            inputHint: "user name",
            controller: _userNameTextController,
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
          FormInput(
            inputLabel: "Confirm Password",
            inputHint: "confirm password",
            controller: _confirmPasswordTextController,
          ),
          const SizedBox(
            height: 18,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MainButton(
                  label: "Create New Account",
                  onTap: () {
                    _validateFormData();
                  }),
              MainButton(
                  label: "Sign In",
                  onTap: () {
                    Get.to(() => const LoginAdminUserScreen());
                  }),
            ],
          )
        ])),
      ),
    );
  }

  _validateFormData() {
    if (_userNameTextController.text.isNotEmpty &&
        _emailTextController.text.isNotEmpty &&
        _passwordTextController.text.isNotEmpty &&
        _confirmPasswordTextController.text.isNotEmpty) {
      if (_passwordTextController.text == _confirmPasswordTextController.text) {
        _saveFormDataToDB();
        Get.back();
      } else if (_passwordTextController.text !=
          _confirmPasswordTextController.text) {
        Get.snackbar("Required", "Passwords are not match!",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.redAccent,
            icon: const Icon(Icons.warning_amber_rounded));
      }
    } else if (_userNameTextController.text.isEmpty &&
        _emailTextController.text.isEmpty &&
        _passwordTextController.text.isEmpty &&
        _confirmPasswordTextController.text.isEmpty) {
      Get.snackbar("Required", "All fields are required!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          icon: const Icon(Icons.warning_amber_rounded));
    } else if (_userNameTextController.text.isEmpty) {
      Get.snackbar("Required", "Username required!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          icon: const Icon(Icons.warning_amber_rounded));
    } else if (_emailTextController.text.isEmpty) {
      Get.snackbar("Required", "Email required!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          icon: const Icon(Icons.warning_amber_rounded));
    } else if (_passwordTextController.text.isEmpty) {
      Get.snackbar("Required", "Password required!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          icon: const Icon(Icons.warning_amber_rounded));
    } else if (_confirmPasswordTextController.text.isEmpty) {
      Get.snackbar("Required", "Confirm Password required!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          icon: const Icon(Icons.warning_amber_rounded));
    }
  }

  _saveFormDataToDB() async {
    await _userController.addUser(
        user: User(
      userName: _userNameTextController.text,
      firstName: "",
      lastName: "",
      mobile: "",
      age: "",
      email: _emailTextController.text,
      password: _passwordTextController.text,
    ));
    Get.snackbar("Success", "Sign Up Successfully!",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        icon: const Icon(Icons.done));
    Get.to(() => const LoginAdminUserScreen());
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
