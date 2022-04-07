import 'package:get/get.dart';
import 'package:lumoz/controllers/wishlist_controller.dart';
import 'package:lumoz/ui/home_user_management_screen.dart';
import 'package:lumoz/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:lumoz/ui/widgets/form_input.dart';
import 'package:lumoz/ui/widgets/main_button.dart';
import 'package:lumoz/controllers/user_controller.dart';

import '../models/wishlist.dart';

class LoginUserScreen extends StatefulWidget {
  const LoginUserScreen({Key? key}) : super(key: key);

  @override
  State<LoginUserScreen> createState() => _LoginUserScreenState();
}

class _LoginUserScreenState extends State<LoginUserScreen> {
  final WishlistController _wishlistController = Get.put(WishlistController());
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
            "User Sign In",
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
      _userController.getUser(_emailTextController.text);
      if (_userController.selectedUserList.isNotEmpty) {
        const email = "nithya@gmail.com";
        Get.to(() => const HomeUserManagementScreen(email: email));
      }
    } else if (_emailTextController.text.isEmpty &&
        _passwordTextController.text.isEmpty) {
      Get.snackbar("Required", "All fields are required!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
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
      actions: const [
        CircleAvatar(
          backgroundImage: AssetImage("images/profile.jpg"),
        ),
        SizedBox(
          width: 20,
        )
      ],
    );
  }
}
