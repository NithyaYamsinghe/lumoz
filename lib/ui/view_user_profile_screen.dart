import 'package:lumoz/ui/splash_screen.dart';
import 'package:get/get.dart';
import 'package:lumoz/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:lumoz/ui/widgets/form_input.dart';
import 'package:lumoz/controllers/user_controller.dart';

import 'home_user_management_screen.dart';

class ViewUserProfileScreen extends StatefulWidget {
  final String? email;
  final String? password;

  const ViewUserProfileScreen({Key? key, this.email, this.password}) : super(key: key);

  @override
  State<ViewUserProfileScreen> createState() =>
      _ViewUserProfileScreenState();
}

class _ViewUserProfileScreenState extends State<ViewUserProfileScreen> {
  final UserController _userController = Get.put(UserController());
  TextEditingController _userNameTextController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _userController.getUser(widget.email!, widget.password!);
  }

  @override
  Widget build(BuildContext context) {
    _userNameTextController = TextEditingController(
        text: _userController.selectedUserList[0].userName);
    _firstNameController = TextEditingController(
        text: _userController.selectedUserList[0].firstName);
    _lastNameController = TextEditingController(
        text: _userController.selectedUserList[0].lastName);
    _ageController = TextEditingController(
        text: _userController.selectedUserList[0].age.toString());
    _mobileController =
        TextEditingController(text: _userController.selectedUserList[0].mobile);
    _emailController = TextEditingController(text: widget.email!);
    return Scaffold(
      appBar: _appBar(context),
      body: Container(
        padding:
        const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 30),
        child: SingleChildScrollView(
            child: Column(children: [
              Text(
                "View User Profile",
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
                controller: _emailController,
              ),
              FormInput(
                inputLabel: "First Name",
                inputHint: "first name",
                controller: _firstNameController,
              ),
              FormInput(
                inputLabel: "Last Name",
                inputHint: "last name",
                controller: _lastNameController,
              ),
              FormInput(
                inputLabel: "Age",
                inputHint: "age",
                controller: _ageController,
              ),
              FormInput(
                inputLabel: "Mobile",
                inputHint: "mobile",
                controller: _mobileController,
              ),
              const SizedBox(
                height: 18,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                ],
              )
            ])),
      ),
    );
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
            Get.to(() => const HomeUserManagementScreen());
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
