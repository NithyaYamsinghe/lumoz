import 'package:get/get.dart';
import 'package:lumoz/database/database_helper.dart';
import 'package:lumoz/models/reminder.dart';

class ReminderController extends GetxController{
  @override
  void onReady(){
    super.onReady();
  }


  Future <int> addReminder({Reminder? reminder}) async{
    return await DatabaseHelper.createReminder(reminder);
  }
}