import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lumoz/models/reminder.dart';
import 'package:lumoz/services/notification_service.dart';
import 'package:lumoz/ui/splash_screen.dart';
import 'package:lumoz/ui/theme.dart';
import 'package:lumoz/ui/update_reminder_screen.dart';
import 'package:lumoz/ui/view_reminder_screen.dart';
import 'package:lumoz/ui/widgets/reminder_tile.dart';
import 'package:timezone/timezone.dart' as tz;
import '../controllers/reminder_controller.dart';
import 'home_user_management_screen.dart';

class ReminderScreen extends StatefulWidget {
  const ReminderScreen({Key? key}) : super(key: key);

  @override
  State<ReminderScreen> createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  final ReminderController _reminderController = Get.put(ReminderController());
  DateTime _selectedDate = DateTime.now().add(const Duration(days: 1));
  var notificationHelper;

  @override
  void initState() {
    super.initState();
    notificationHelper = NotificationHelper();
    notificationHelper.initializeNotification();
    notificationHelper.requestIOSPermissions();
    _reminderController.getReminders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Column(
        children: [
          _addReminderBar(),
          _addDateBar(),
          const SizedBox(
            height: 10,
          ),
          _showReminders()
        ],
      ),
    );
  }

  _showReminders() {
    return Expanded(
      child: Obx(() {
        return ListView.builder(
            itemCount: _reminderController.remindersList.length,
            itemBuilder: (_, index) {
              Reminder reminder = _reminderController.remindersList[index];
              print(reminder.toJson());
              print(tz.TZDateTime.now(tz.local));
              if (reminder.repeat == 'Daily') {
                DateTime date =
                    DateFormat.jm().parse(reminder.startTime.toString());
                var formattedTime = DateFormat("HH:mm").format(date);
                notificationHelper.scheduledNotification(
                    int.parse(formattedTime.toString().split(":")[0]),
                    int.parse(formattedTime.toString().split(":")[1]),
                    reminder);
                return AnimationConfiguration.staggeredList(
                    position: index,
                    child: SlideAnimation(
                      child: FadeInAnimation(
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                _showBottomOptions(context, reminder);
                              },
                              child: ReminderTile(reminder),
                            )
                          ],
                        ),
                      ),
                    ));
              }
              if (reminder.date == DateFormat.yMd().format(_selectedDate)) {
                return AnimationConfiguration.staggeredList(
                    position: index,
                    child: SlideAnimation(
                      child: FadeInAnimation(
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                _showBottomOptions(context, reminder);
                              },
                              child: ReminderTile(reminder),
                            )
                          ],
                        ),
                      ),
                    ));
              } else {
                return Container();
              }
            });
      }),
    );
  }

  _showBottomOptions(BuildContext context, Reminder reminder) {
    Get.bottomSheet(Container(
      padding: const EdgeInsets.only(top: 4),
      height: reminder.isCompleted == 1
          ? MediaQuery.of(context).size.height * 0.60
          : MediaQuery.of(context).size.height * 0.60,
      color: Get.isDarkMode ? blackColor : Colors.white,
      child: Column(
        children: [
          Container(
            height: 6,
            width: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Get.isDarkMode ? Colors.grey[600] : Colors.grey[300]),
          ),
          const Spacer(),
          reminder.isCompleted == 1
              ? Container()
              : _bottomOptionsButton(
                  buttonLabel: "Reminder Completed",
                  onTap: () {
                    _reminderController.updateReminder(reminder.id!);
                    Get.back();
                  },
                  color: primaryClr,
                  context: context),
          _bottomOptionsButton(
              buttonLabel: "Delete Reminder",
              onTap: () {
                showDialog(context: context, builder:(BuildContext context){
                  return AlertDialog(
                    title: Text("Confirm"),
                    content: Text("Are you sure?"),
                    actions: <Widget>[
                      FlatButton(
                        child: Text("Ok"),
                        onPressed: () {
                          _reminderController.deleteReminder(reminder);
                          Get.back();
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
              },
              color: Colors.red[300]!,
              context: context),
          const SizedBox(
            height: 10,
          ),
          _bottomOptionsButton(
              buttonLabel: "View Reminder",
              onTap: () {
                Get.to(() => ViewReminderScreen(
                    label: "${reminder.tvShow}|" +
                        "${reminder.note}|" +
                        "${reminder.isCompleted}|" +
                        "${reminder.date}|" +
                        "${reminder.endTime}|" +
                        "${reminder.startTime}|" +
                        "${reminder.color}|" +
                        "${reminder.repeat}|" +
                        "${reminder.reminder}"));
              },
              color: Colors.green,
              context: context),
          const SizedBox(
            height: 10,
          ),
          _bottomOptionsButton(
              buttonLabel: "Update Reminder",
              onTap: () {
                Get.to(() => UpdateReminderScreen(reminder: reminder));
              },
              color: Colors.indigo,
              context: context),
          const SizedBox(
            height: 10,
          ),
          _bottomOptionsButton(
              buttonLabel: "Close",
              onTap: () {
                Get.back();
              },
              color: Colors.white,
              isClosed: true,
              context: context),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    ));
  }

  _bottomOptionsButton(
      {required String buttonLabel,
      required Function()? onTap,
      required Color color,
      bool isClosed = false,
      required BuildContext context}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 55,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          border: Border.all(
              width: 2,
              color: isClosed == true
                  ? Get.isDarkMode
                      ? Colors.grey[600]!
                      : Colors.grey[300]!
                  : color),
          borderRadius: BorderRadius.circular(20),
          color: isClosed == true ? Colors.transparent : color,
        ),
        child: Center(
          child: Text(
            buttonLabel,
            style: isClosed
                ? inputLabelStyles
                : inputLabelStyles.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }

  _addDateBar() {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20),
      child: DatePicker(
        tz.TZDateTime.now(tz.local),
        height: 100,
        width: 75,
        initialSelectedDate: tz.TZDateTime.now(tz.local),
        selectionColor: primaryClr,
        selectedTextColor: Colors.white,
        dateTextStyle: GoogleFonts.raleway(
          textStyle: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        dayTextStyle: GoogleFonts.raleway(
          textStyle: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        monthTextStyle: GoogleFonts.raleway(
          textStyle: const TextStyle(
              fontSize: 12, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        onDateChange: (date) {
          setState(() {
            _selectedDate = date;
          });
        },
      ),
    );
  }

  _addReminderBar() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat.yMMMMd().format(tz.TZDateTime.now(tz.local)),
                  style: subHeadingStyles,
                ),
                Text(
                  "Today",
                  style: headingStyles,
                )
              ],
            ),
          ),
        ],
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
