import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lumoz/controllers/channel_controller.dart';
import 'package:lumoz/models/channel.dart';
import 'package:lumoz/ui/splash_screen.dart';
import 'package:lumoz/ui/theme.dart';
import 'package:lumoz/ui/widgets/form_input.dart';
import 'package:lumoz/ui/widgets/main_button.dart';

import 'home_admin_management_screen.dart';

class AddChannelScreen extends StatefulWidget {
  const AddChannelScreen({Key? key}) : super(key: key);

  @override
  State<AddChannelScreen> createState() => _AddChannelScreenState();
}

class _AddChannelScreenState extends State<AddChannelScreen> {
  final ChannelController _channelController = Get.put(ChannelController());
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _channelNameController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();

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
            "Add Channel",
            style: headingStyles,
          ),
          FormInput(
            inputLabel: "Channel Name",
            inputHint: "Enter the channel name",
            controller: _channelNameController,
          ),
          FormInput(
            inputLabel: "Description",
            inputHint: "Enter the description",
            controller: _descriptionController,
          ),
          FormInput(
            inputLabel: "Image URL",
            inputHint: "Enter the image url",
            controller: _imageController,
          ),
          const SizedBox(
            height: 18,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MainButton(label: "Add Channel", onTap: () => _validateFormData())
            ],
          )
        ])),
      ),
    );
  }

  _validateFormData() {
    if (_channelNameController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty &&
        _imageController.text.isNotEmpty) {
      _saveFormDataToDB();
      Get.back();
    } else if (_channelNameController.text.isEmpty &&
        _descriptionController.text.isEmpty &&
        _imageController.text.isEmpty) {
      Get.snackbar("Required", "All fields are required!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          icon: const Icon(Icons.warning_amber_rounded));
    }
    else if (_channelNameController.text.isEmpty) {
      Get.snackbar("Required", "Channel Name required!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          icon: const Icon(Icons.warning_amber_rounded));
    }
    else if (_descriptionController.text.isEmpty) {
      Get.snackbar("Required", "Description required!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          icon: const Icon(Icons.warning_amber_rounded));
    }
    else if (_imageController.text.isEmpty) {
      Get.snackbar("Required", "Image required!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          icon: const Icon(Icons.warning_amber_rounded));
    }
  }

  _saveFormDataToDB() async {
    await _channelController.addChannel(
        channel: Channel(
            channel: _channelNameController.text,
            image: _imageController.text,
            description: _descriptionController.text));
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
