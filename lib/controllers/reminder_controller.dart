import 'package:get/get.dart';
import 'package:lumoz/database/database_helper.dart';
import 'package:lumoz/models/reminder.dart';

class ReminderController extends GetxController {
  @override
  void onReady() {
    super.onReady();
  }

  var remindersList = <Reminder>[].obs;

  // add new reminder and save in database
  Future<int> addReminder({Reminder? reminder}) async {
    return await DatabaseHelper.createReminder(reminder);
  }

  // get all reminders from database
  void getReminders() async {
    List<Map<String, dynamic>> reminders = await DatabaseHelper.query();
    remindersList.assignAll(
        reminders.map((data) => new Reminder.fromJson(data)).toList());
  }

  // delete a reminder from database
  void deleteReminder(Reminder reminder) {
    var response = DatabaseHelper.delete(reminder);
    getReminders();
    print(response);
  }

  // update reminder completed status on database
  void updateReminder(int id) async {
    await DatabaseHelper.updateReminder(id);
    getReminders();
  }


  // update reminder record  on database
  void updateReminderRecord(Reminder reminder) async {
    await DatabaseHelper.updateReminderRecord(reminder);
   getReminders();
  }
}
