import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lumoz/controllers/reminder_controller.dart';
import 'package:lumoz/models/tv_show.dart';
import 'package:lumoz/ui/splash_screen.dart';
import 'package:lumoz/ui/theme.dart';
import 'package:lumoz/ui/widgets/form_input.dart';
import 'package:lumoz/ui/widgets/main_button.dart';
import 'package:timezone/timezone.dart' as tz;
import '../models/reminder.dart';
import 'home_user_management_screen.dart';

class AddReminderScreen extends StatefulWidget {
  final TvShow tvShow;

  const AddReminderScreen({Key? key, required this.tvShow}) : super(key: key);

  @override
  State<AddReminderScreen> createState() => _AddReminderScreenState();
}

class _AddReminderScreenState extends State<AddReminderScreen> {
  final ReminderController _reminderController = Get.put(ReminderController());
  TextEditingController _tvShowNameController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
  }

  DateTime _selectedDate = tz.TZDateTime.now(tz.local);
  String _endTime = "10.30 PM";
  String _startTime =
      DateFormat("hh:mm a").format(tz.TZDateTime.now(tz.local)).toString();
  String _selectedRepeat = "None";
  int _selectedColor = 0;
  List<String> repeatList = ["None", "Daily", "Weekly", "Monthly"];
  int _selectedRemindTime = 5;
  List<int> remindList = [5, 10, 15, 20];

  @override
  Widget build(BuildContext context) {
    _tvShowNameController = TextEditingController(text: widget.tvShow.title);
    return Scaffold(
      appBar: _appBar(context),
      body: Container(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 30),
        child: SingleChildScrollView(
            child: Column(children: [
          Text(
            "Create Reminder",
            style: headingStyles,
          ),
          FormInput(
            inputLabel: "TV Show Name",
            inputHint: "Enter your tv show name",
            controller: _tvShowNameController,
          ),
          FormInput(
            inputLabel: "Note",
            inputHint: "Enter your note",
            controller: _noteController,
          ),
          FormInput(
            inputLabel: "Date",
            inputHint: DateFormat.yMd().format(_selectedDate),
            widget: IconButton(
              icon: Icon(Icons.calendar_today_outlined),
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
          FormInput(
            inputLabel: "Remind Before",
            inputHint: "$_selectedRemindTime minutes early",
            widget: DropdownButton(
              icon: const Icon(
                Icons.keyboard_arrow_down,
                color: Colors.grey,
              ),
              iconSize: 32,
              elevation: 4,
              style: inputHintStyles,
              underline: Container(
                height: 0,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedRemindTime = int.parse(newValue!);
                });
              },
              items: remindList.map<DropdownMenuItem<String>>((int value) {
                return DropdownMenuItem<String>(
                  child: Text(value.toString()),
                  value: value.toString(),
                );
              }).toList(),
            ),
          ),
          FormInput(
            inputLabel: "Repeat",
            inputHint: _selectedRepeat,
            widget: DropdownButton(
              icon: const Icon(
                Icons.keyboard_arrow_down,
                color: Colors.grey,
              ),
              iconSize: 32,
              elevation: 4,
              style: inputHintStyles,
              underline: Container(
                height: 0,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedRepeat = newValue!;
                });
              },
              items: repeatList.map<DropdownMenuItem<String>>((String? value) {
                return DropdownMenuItem<String>(
                  child: Text(
                    value!,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  value: value,
                );
              }).toList(),
            ),
          ),
          const SizedBox(
            height: 18,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _colorPalette(),
              MainButton(
                  label: "Add Reminder", onTap: () => _validateFormData())
            ],
          )
        ])),
      ),
    );
  }

  _validateFormData() {
    if (_tvShowNameController.text.isNotEmpty &&
        _noteController.text.isNotEmpty) {
      _saveFormDataToDB();
      Get.back();
    } else if (_tvShowNameController.text.isEmpty &&
        _noteController.text.isEmpty) {
      Get.snackbar("Required", "All fields are required!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          icon: Icon(Icons.warning_amber_rounded));
    } else if (_tvShowNameController.text.isEmpty) {
      Get.snackbar("Required", "Tv show name required!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          icon: Icon(Icons.warning_amber_rounded));
    } else if (_noteController.text.isEmpty) {
      Get.snackbar("Required", "Note required!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          icon: Icon(Icons.warning_amber_rounded));
    }
  }

  _saveFormDataToDB() async {
    await _reminderController.addReminder(
        reminder: Reminder(
            note: _noteController.text,
            tvShow: _tvShowNameController.text,
            date: DateFormat.yMd().format(_selectedDate),
            startTime: _startTime,
            endTime: _endTime,
            reminder: _selectedRemindTime,
            repeat: _selectedRepeat,
            color: _selectedColor,
            isCompleted: 0));
    Get.snackbar("Success", "Added Successfully!",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        icon: const Icon(Icons.done));
  }


  _colorPalette() {
    return (Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Color",
          style: inputLabelStyles,
        ),
        const SizedBox(
          height: 8.0,
        ),
        Wrap(
            children: List<Widget>.generate(3, (int index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedColor = index;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0, bottom: 8.0),
              child: CircleAvatar(
                radius: 14,
                backgroundColor: index == 0
                    ? primaryClr
                    : index == 1
                        ? pinkColor
                        : yellowColor,
                child: _selectedColor == index
                    ? const Icon(
                        Icons.done,
                        color: Colors.white,
                        size: 16,
                      )
                    : Container(),
              ),
            ),
          );
        }))
      ],
    ));
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
