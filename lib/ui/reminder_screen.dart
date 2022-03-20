import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lumoz/services/notification_service.dart';
import 'package:lumoz/services/theme_service.dart';
import 'package:lumoz/ui/add_reminder_screen.dart';
import 'package:lumoz/ui/theme.dart';
import 'package:lumoz/ui/widgets/main_button.dart';

class ReminderScreen extends StatefulWidget {
  const ReminderScreen({Key? key}) : super(key: key);

  @override
  State<ReminderScreen> createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {

  DateTime _selectedDate= DateTime.now();
  var notificationHelper;

  @override
  void initState() {
    super.initState();
    notificationHelper=NotificationHelper();
    notificationHelper.initializeNotification();
    notificationHelper.requestIOSPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Column(
        children:[
           _addReminderBar(),
          _addDateBar()
        ],
      ),
    );
  }

  _addDateBar(){
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 75,
        initialSelectedDate: DateTime.now(),
        selectionColor: primaryClr,
        selectedTextColor: Colors.white,
        dateTextStyle: GoogleFonts.raleway(
          textStyle:const TextStyle(
              fontSize: 20,
              fontWeight:FontWeight.w600,
              color: Colors.grey
          ), ),
        dayTextStyle: GoogleFonts.raleway(
          textStyle:const TextStyle(
              fontSize: 14,
              fontWeight:FontWeight.w600,
              color: Colors.grey
          ), ),
        monthTextStyle: GoogleFonts.raleway(
          textStyle:const TextStyle(
              fontSize: 12,
              fontWeight:FontWeight.w600,
              color: Colors.grey
          ), ),
        onDateChange: (date){
          _selectedDate=date;
        },
      ),
    );
  }

  _addReminderBar(){
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(DateFormat.yMMMMd().format(DateTime.now()),
                  style: subHeadingStyles,),
                Text("Today", style: headingStyles,)
              ],
            ),
          ),
          MainButton(label: "Add Reminder", onTap: ()=> Get.to(() => const AddReminderScreen()))
        ],
      ),
    );
  }

  _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap:(){
           ThemeService().switchTheme();
           notificationHelper.displayNotification(
             title: "Theme Changed",
             body: Get.isDarkMode? "Activated Lumoz Light Theme": "Activated Lumoz Dark Theme"
           );
           notificationHelper.scheduledNotification();
        },
        child: Icon(Get.isDarkMode? Icons.wb_sunny: Icons.nightlight_round,
          size: 20,
        color: Get.isDarkMode? Colors.white : Colors.black),
      ),
      actions: const [
        CircleAvatar(
          backgroundImage: AssetImage(
            "images/profile.jpg"
          ),
        ),
        SizedBox(width: 20,)
      ],
    );
  }
}
