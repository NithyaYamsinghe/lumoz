import 'package:get/get.dart';
import 'package:lumoz/database/database_helper.dart';
import 'package:lumoz/models/admin_management.dart';

class AdminManagementController extends GetxController {
  @override
  void onReady() {
    super.onReady();
  }

  var adminManagementList = <AdminManagement>[].obs;

  Future<int> addAdminManagement({AdminManagement? adminManagement}) async {
    return await DatabaseHelper.createAdminManagement(adminManagement);
  }

  void getAdminManagements() async {
    List<Map<String, dynamic>> adminManagements =
        await DatabaseHelper.queryAdminManagements();
    adminManagementList.assignAll(adminManagements
        .map((data) => new AdminManagement.fromJson(data))
        .toList());
  }

  void deleteAdminManagement(AdminManagement adminManagement) {
    DatabaseHelper.deleteAdminManagement(adminManagement);
    getAdminManagements();
  }

  void updateAdminManagement(int id, String text) async {
    await DatabaseHelper.updateAdminManagement(id, text);
    getAdminManagements();
  }

  void updateAdminManagementRecord(AdminManagement adminManagement) async {
    await DatabaseHelper.updateAdminManagementRecord(adminManagement);
    getAdminManagements();
  }
}
