import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lumoz/controllers/user_management_controller.dart';
import 'package:lumoz/models/user_management.dart';
import 'package:lumoz/ui/home_channel_screen.dart';
import 'package:lumoz/ui/home_management_screen.dart';
import 'package:lumoz/ui/reminder_screen.dart';
import 'package:lumoz/ui/widgets/user_management_tile.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:lumoz/ui/wishlist_screen.dart';

class HomeUserManagementScreen extends StatefulWidget {
  final String? email;
  const HomeUserManagementScreen({Key? key, this.email}) : super(key: key);

  @override
  State<HomeUserManagementScreen> createState() => _HomeUserManagementScreenState();
}

class _HomeUserManagementScreenState extends State<HomeUserManagementScreen> {
  final UserManagementController _userManagementController = Get.put(UserManagementController());

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
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
                              if(userManagement.text == 'Wish List')
                              {
                                Get.to(()=>WishlistScreen());
                              }
                              else if (userManagement.text == 'Channels'){
                                Get.to(()=> HomeChannelScreen());
                              }
                              else if (userManagement.text == 'Reminders'){
                                Get.to(()=> ReminderScreen());
                              }
                              else if (userManagement.text == 'Profile'){
                                Get.to(()=> HomeManagementScreen(email:widget.email!));
                              }
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

