import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lumoz/ui/widgets/home_tile.dart';
import '../controllers/home_controller.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../models/home.dart';
import 'home_admin_management_screen.dart';
import 'home_user_management_screen.dart';

class HomeManagementScreen extends StatefulWidget {
  const HomeManagementScreen({Key? key}) : super(key: key);

  @override
  State<HomeManagementScreen> createState() => _HomeManagementScreenState();
}

class _HomeManagementScreenState extends State<HomeManagementScreen> {
  final HomeController _homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    _homeController.getHomes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Column(
        children:[
          SizedBox(height: 10,),
          _showChannels()
        ],
      ),
    );
  }

  _showChannels(){
    return Expanded(
      child: Obx((){
        return ListView.builder(
            itemCount: _homeController.homeList.length,
            itemBuilder: (_, index){
              Home home = _homeController.homeList[index];
              print(home.toJson());
              return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    child: FadeInAnimation(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: (){
                              if(home.text == 'Admin')
                              {
                                Get.to(()=>HomeAdminManagementScreen());
                              }
                              else{
                                Get.to(()=>HomeUserManagementScreen());
                              }
                            },
                            child: HomeTile(home),
                          )
                        ],
                      ),
                    ),
                  ));
            });
      }),
    );
  }

  _appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap:(){
          Get.back();
        },
        child: Icon(Icons.arrow_back_ios_new_outlined,
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

