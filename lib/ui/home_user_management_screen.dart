import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lumoz/controllers/user_management_controller.dart';
import 'package:lumoz/models/user_management.dart';
import 'package:lumoz/ui/home_admin_management_screen.dart';
import 'package:lumoz/ui/widgets/user_management_tile.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class HomeUserManagementScreen extends StatefulWidget {
  const HomeUserManagementScreen({Key? key}) : super(key: key);

  @override
  State<HomeUserManagementScreen> createState() => _HomeUserManagementScreenState();
}

class _HomeUserManagementScreenState extends State<HomeUserManagementScreen> {
  final UserManagementController _userManagementController = Get.put(UserManagementController());

  @override
  void initState() {
    super.initState();
    _userManagementController.getUserManagements();
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
            itemCount: _userManagementController.userManagementList.length,
            itemBuilder: (_, index){
              UserManagement userManagement = _userManagementController.userManagementList[index];
              print(userManagement.toJson());
              return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    child: FadeInAnimation(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: (){
                              // if(userManagement.text == 'Admin')
                              // {
                              //   Get.to(()=>HomeAdminManagementScreen());
                              // }
                              // else{
                              //   Get.to(()=>HomeUserManagementScreen());
                              // }
                            },
                            child: UserManagementTile(userManagement)
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

