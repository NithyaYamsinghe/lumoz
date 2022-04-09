import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lumoz/controllers/tv_show_controller.dart';
import 'package:lumoz/models/tv_show.dart';
import 'package:lumoz/ui/splash_screen.dart';
import 'package:lumoz/ui/theme.dart';
import 'package:lumoz/ui/widgets/form_input.dart';
import 'package:lumoz/ui/widgets/main_button.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'home_admin_management_screen.dart';

class AddTvShowScreen extends StatefulWidget {
  const AddTvShowScreen({Key? key}) : super(key: key);

  @override
  State<AddTvShowScreen> createState() => _AddTvShowScreenState();
}

class _AddTvShowScreenState extends State<AddTvShowScreen> {
  final TvShowController _tvShowController = Get.put(TvShowController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _channelController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _seasonController = TextEditingController();

  @override
  void initState() {
    tz.initializeTimeZones();
    WidgetsFlutterBinding.ensureInitialized();
    super.initState();
  }

  DateTime _selectedDate = tz.TZDateTime.now(tz.local);
  String _endTime = "10.30 PM";
  String _startTime =
      DateFormat("hh:mm a").format(tz.TZDateTime.now(tz.local)).toString();

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
            "Add Tv Show",
            style: headingStyles,
          ),
          FormInput(
            inputLabel: "TV Show Title",
            inputHint: "Enter the tv show title",
            controller: _titleController,
          ),
          FormInput(
            inputLabel: "Channel",
            inputHint: "Enter the channel",
            controller: _channelController,
          ),
          FormInput(
            inputLabel: "Season",
            inputHint: "Enter the season",
            controller: _seasonController,
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
          FormInput(
            inputLabel: "Date",
            inputHint: DateFormat.yMd().format(_selectedDate),
            widget: IconButton(
              icon: const Icon(Icons.calendar_today_outlined),
              color: Colors.grey,
              onPressed: () {
                _getDate();
              },
            ),
          ),
          Row(
            children: [
              Expanded(
                child: FormInput(
                  inputLabel: "Start Time",
                  inputHint: _startTime,
                  widget: IconButton(
                    onPressed: () {
                      _getTime(isStartTime: true);
                    },
                    icon: const Icon(
                      Icons.access_time_rounded,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: FormInput(
                  inputHint: _endTime,
                  inputLabel: "End Time",
                  widget: IconButton(
                    onPressed: () {
                      _getTime(isStartTime: false);
                    },
                    icon: const Icon(
                      Icons.access_time_rounded,
                      color: Colors.grey,
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 18,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MainButton(label: "Add Tv Show", onTap: () => _validateFormData())
            ],
          )
        ])),
      ),
    );
  }

  _validateFormData() {
    if (_titleController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty &&
        _channelController.text.isNotEmpty &&
        _imageController.text.isNotEmpty &&
        _seasonController.text.isNotEmpty) {
      _saveFormDataToDB();
      Get.back();
    } else if (_titleController.text.isEmpty &&
        _descriptionController.text.isEmpty) {
      Get.snackbar("Required", "All fields are required!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          icon: const Icon(Icons.warning_amber_rounded));
    } else if (_titleController.text.isEmpty) {
      Get.snackbar("Required", "Title required!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          icon: const Icon(Icons.warning_amber_rounded));
    } else if (_descriptionController.text.isEmpty) {
      Get.snackbar("Required", "description required!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          icon: const Icon(Icons.warning_amber_rounded));
    } else if (_channelController.text.isEmpty) {
      Get.snackbar("Required", "Channel required!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          icon: const Icon(Icons.warning_amber_rounded));
    } else if (_imageController.text.isEmpty) {
      Get.snackbar("Required", "Image required!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          icon: const Icon(Icons.warning_amber_rounded));
    } else if (_seasonController.text.isEmpty) {
      Get.snackbar("Required", "Season required!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          icon: const Icon(Icons.warning_amber_rounded));
    }
  }

  _saveFormDataToDB() async {
    await _tvShowController.addTvShow(
        tvShow: TvShow(
      channel: _channelController.text,
      title: _titleController.text,
      image: _imageController.text,
      description: _descriptionController.text,
      season: _seasonController.text,
      isOngoing: 0,
      date: DateFormat.yMd().format(_selectedDate),
      startTime: _startTime,
      endTime: _endTime,
    ));
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

  _getDate() async {
    DateTime? _pickerDate = await showDatePicker(
        context: context,
        initialDate: tz.TZDateTime.now(tz.local),
        firstDate: DateTime(2015),
        lastDate: DateTime(2121));

    if (_pickerDate != null) {
      setState(() {
        _selectedDate = _pickerDate;
      });
    } else {
      if (kDebugMode) {
        print("something went wrong");
      }
    }
  }

  _getTime({required bool isStartTime}) async {
    var pickedTime = await _showTimePicker();
    String _formattedTime = pickedTime.format(context);
    if (pickedTime == null) {
      print("error");
    } else if (isStartTime == true) {
      setState(() {
        _startTime = _formattedTime;
      });
    } else if (isStartTime == false) {
      setState(() {
        _endTime = _formattedTime;
      });
    }
  }

  _showTimePicker() {
    return showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay(
            hour: int.parse(_startTime.split(":")[0]),
            minute: int.parse(_startTime.split(":")[1].split(" ")[0])));
  }
}
