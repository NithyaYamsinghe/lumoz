import 'package:get/get.dart';
import 'package:lumoz/database/database_helper.dart';
import 'package:lumoz/models/user.dart';

class UserController extends GetxController {
  @override
  void onReady() {
    super.onReady();
  }

  var userList = <User>[].obs;
  var selectedUserList = <User>[].obs;

  // add new user and save in database
  Future<int> addUser({User? user}) async {
    return await DatabaseHelper.createUser(user);
  }

  // get all users from database
  void getUsers() async {
    List<Map<String, dynamic>> users = await DatabaseHelper.queryUsers();
    userList.assignAll(users.map((data) => new User.fromJson(data)).toList());
    print(userList);
  }

  // get specific user from database
  void getUser(String email, String password) async {
    List<Map<String, dynamic>>? users = await DatabaseHelper.queryUser(email, password);
    selectedUserList
        .assignAll(users.map((data) => new User.fromJson(data)).toList());
    print(selectedUserList[0].email);
    print(selectedUserList[0].password);
  }

  // delete a user from database
  void deleteUser(User user) {
    var response = DatabaseHelper.deleteUser(user);
    getUsers();
    print(response);
  }

  // update user based on id on database
  void updateUser(int id, String password) async {
    await DatabaseHelper.updateUser(id, password);
    getUsers();
  }

  void updateUserRecord(User user) async {
    await DatabaseHelper.updateUserRecord(user);
    getUser(user.email!, user.password!);
  }

  void updateUserPassword(String email, String password) async {
    await DatabaseHelper.updateUserPassword(email, password);
  }
}
