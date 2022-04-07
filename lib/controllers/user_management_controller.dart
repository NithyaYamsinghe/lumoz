import 'package:get/get.dart';
import 'package:lumoz/database/database_helper.dart';
import '../models/user_management.dart';

class UserManagementController extends GetxController {
  @override
  void onReady() {
    super.onReady();
  }

  var userManagementList = <UserManagement>[].obs;

  Future<int> addUserManagement({UserManagement? userManagement}) async {
    return await DatabaseHelper.createUserManagement(userManagement);
  }

  void getUserManagements() async {
    List<Map<String, dynamic>> userManagements =
        await DatabaseHelper.queryUserManagements();
    userManagementList.assignAll(userManagements
        .map((data) => new UserManagement.fromJson(data))
        .toList());
  }

  void deleteUserManagement(UserManagement userManagement) {
    DatabaseHelper.deleteUserManagement(userManagement);
    getUserManagements();
  }

  void updateUserManagement(int id, String text) async {
    await DatabaseHelper.updateUserManagement(id, text);
    getUserManagements();
  }

  void updateUserManagementRecord(UserManagement userManagement) async {
    await DatabaseHelper.updateUserManagementRecord(userManagement);
    getUserManagements();
  }
}
