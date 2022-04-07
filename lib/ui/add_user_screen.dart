import 'package:lumoz/ui/login_user_screen.dart';
import '../models/user.dart';
import 'package:get/get.dart';
import 'package:lumoz/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:lumoz/ui/widgets/form_input.dart';
import 'package:lumoz/ui/widgets/main_button.dart';
import 'package:lumoz/controllers/user_controller.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({Key? key}) : super(key: key);

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
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
            "User Sign Up",
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
                    Get.to(() => const LoginUserScreen());
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
      _saveFormDataToDB();
      Get.back();
    } else if (_userNameTextController.text.isEmpty ||
        _emailTextController.text.isEmpty ||
        _passwordTextController.text.isEmpty ||
        _confirmPasswordTextController.text.isEmpty) {
      Get.snackbar("Required", "All fields are required!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
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
    Get.to(() => const LoginUserScreen());
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
