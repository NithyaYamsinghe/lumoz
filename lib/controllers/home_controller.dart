import 'package:get/get.dart';
import 'package:lumoz/database/database_helper.dart';
import '../models/home.dart';

class HomeController extends GetxController {
  @override
  void onReady() {
    super.onReady();
  }

  var homeList = <Home>[].obs;

  Future<int> addHome({Home? home}) async {
    return await DatabaseHelper.createHome(home);
  }

  void getHomes() async {
    List<Map<String, dynamic>> homes = await DatabaseHelper.queryHomes();
    homeList.assignAll(homes.map((data) => new Home.fromJson(data)).toList());
  }

  void deleteHome(Home home) {
    DatabaseHelper.deleteHome(home);
    getHomes();
  }

  void updateHome(int id, String text) async {
    await DatabaseHelper.updateHome(id, text);
    getHomes();
  }

  void updateHomeRecord(Home home) async {
    await DatabaseHelper.updateHomeRecord(home);
    getHomes();
  }
}
