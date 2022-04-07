import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lumoz/models/admin_management.dart';
import 'package:lumoz/ui/add_admin_management_screen.dart';
import 'package:lumoz/ui/add_channel_screen.dart';
import 'package:lumoz/ui/add_home_screen.dart';
import 'package:lumoz/ui/add_tv_show_screen.dart';
import 'package:lumoz/ui/add_user_management_screen.dart';
import 'package:lumoz/ui/add_user_screen.dart';
import 'package:lumoz/ui/admin_management_screen.dart';
import 'package:lumoz/ui/channel_screen.dart';
import 'package:lumoz/ui/home_screen.dart';
import 'package:lumoz/ui/tv_show_screen.dart';
import 'package:lumoz/ui/user_management_screen.dart';
import 'package:lumoz/ui/user_screen.dart';
import 'package:lumoz/ui/widgets/admin_management_tile.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../controllers/admin_management_controller.dart';

class HomeAdminManagementScreen extends StatefulWidget {
  const HomeAdminManagementScreen({Key? key}) : super(key: key);

  @override
  State<HomeAdminManagementScreen> createState() => _HomeAdminManagementScreenState();
}

class _HomeAdminManagementScreenState extends State<HomeAdminManagementScreen> {
  final AdminManagementController _adminManagementController = Get.put(AdminManagementController());

  @override
  void initState() {
    super.initState();
    _adminManagementController.getAdminManagements();
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
            itemCount: _adminManagementController.adminManagementList.length,
            itemBuilder: (_, index){
              AdminManagement adminManagement = _adminManagementController.adminManagementList[index];
              print(adminManagement.toJson());
              return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    child: FadeInAnimation(
                      child: Row(
                        children: [
                          GestureDetector(
                              onTap: (){
                               if(adminManagement.text == 'Profile Tab Management'){
                                 Get.to(()=>const HomeScreen());
                               }
                               else if(adminManagement.text == 'Admin Tab Management'){
                                 Get.to(()=>const AdminManagementScreen());
                               }
                               else if( adminManagement.text == 'User Tab Management'){
                                 Get.to(()=> const UserManagementScreen());
                               }
                               else if( adminManagement.text == 'User Management'){
                                 Get.to(()=>const UserScreen());
                               }
                               else if( adminManagement.text == 'Tv Show Management'){
                                 Get.to(()=>const TvShowScreen());
                               }
                               else if( adminManagement.text == 'Channel Management'){
                                 Get.to(()=>const ChannelScreen());
                               }
                              },
                              child: AdminManagementTile(adminManagement)
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

