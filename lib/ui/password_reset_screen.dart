import 'package:lumoz/ui/login_user_screen.dart';
import 'package:lumoz/ui/splash_screen.dart';
import 'package:get/get.dart';
import 'package:lumoz/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:lumoz/ui/widgets/form_input.dart';
import 'package:lumoz/ui/widgets/main_button.dart';
import 'package:lumoz/controllers/user_controller.dart';

class PasswordResetScreen extends StatefulWidget {
  const PasswordResetScreen({Key? key}) : super(key: key);

  @override
  State<PasswordResetScreen> createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  final UserController _userController = Get.put(UserController());
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
  }

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
            "Reset Password",
            style: headingStyles,
          ),
          FormInput(
            inputLabel: "Email",
            inputHint: "email",
            controller: _emailController,
          ),
          FormInput(
            inputLabel: "Password",
            inputHint: "password",
            controller: _passwordController,
          ),
          FormInput(
            inputLabel: "Confirm Password",
            inputHint: "confirm password",
            controller: _confirmPasswordController,
          ),
          const SizedBox(
            height: 18,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MainButton(
                  label: "Reset Password",
                  onTap: () {
                    _validateFormData();
                  }),
            ],
          )
        ])),
      ),
    );
  }

  _validateFormData() {
    if (_passwordController.text.isNotEmpty &&
        _confirmPasswordController.text.isNotEmpty &&
        _emailController.text.isNotEmpty) {
      if (_passwordController.text == _confirmPasswordController.text) {
        showDialog(context: context, builder:(BuildContext context){
          return AlertDialog(
            title: Text("Confirm"),
            content: Text("Are you sure?"),
            actions: <Widget>[
              FlatButton(
                child: Text("Ok"),
                onPressed: () {
                  _saveFormDataToDB();
                },
              ),
              FlatButton(
                child: Text("Cancel"),
                onPressed: (){
                  Get.back();
                },
              ),
            ],
          );
        });
      } else if (_passwordController.text != _confirmPasswordController.text) {
        Get.snackbar("Required", "confirm password & password not equal!",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            icon: const Icon(Icons.warning_amber_rounded));
      }
    } else if (_passwordController.text.isEmpty &&
        _confirmPasswordController.text.isEmpty &&
        _emailController.text.isEmpty) {
      Get.snackbar("Required", "All fields are required!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          icon: const Icon(Icons.warning_amber_rounded));
    } else if (_passwordController.text.isEmpty) {
      Get.snackbar("Required", "password required!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          icon: const Icon(Icons.warning_amber_rounded));
    } else if (_confirmPasswordController.text.isEmpty) {
      Get.snackbar("Required", "confirm password required!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          icon: const Icon(Icons.warning_amber_rounded));
    } else if (_emailController.text.isEmpty) {
      Get.snackbar("Required", "email required!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          icon: const Icon(Icons.warning_amber_rounded));
    }
  }

  _saveFormDataToDB() {
    _userController.updateUserPassword(
        _emailController.text, _passwordController.text);
    Get.snackbar("Success", "Password Reset Successfully!",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        icon: const Icon(Icons.done));
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
    );
  }
}
