import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lumoz/models/admin_management.dart';
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
                                // if(userManagement.text == '')
                                // {
                                //   // Get.to(()=>HomeTvShowScreen());
                                // }
                                // // else;
                                // // Get.to(()=>HomeTvShowScreen());
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

