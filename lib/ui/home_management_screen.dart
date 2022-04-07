import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lumoz/ui/create_user_profile_screen.dart';
import 'package:lumoz/ui/widgets/home_tile.dart';
import '../controllers/home_controller.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../models/home.dart';
import '../services/notification_service.dart';
import '../services/theme_service.dart';

class HomeManagementScreen extends StatefulWidget {
  final String? email;
  const HomeManagementScreen({Key? key, this.email}) : super(key: key);

  @override
  State<HomeManagementScreen> createState() => _HomeManagementScreenState();
}

class _HomeManagementScreenState extends State<HomeManagementScreen> {
  final HomeController _homeController = Get.put(HomeController());
  var notificationHelper;

  @override
  void initState() {
    super.initState();
    notificationHelper=NotificationHelper();
    notificationHelper.initializeNotification();
    notificationHelper.requestIOSPermissions();
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
                              if(home.text == 'Create User Profile')
                              {
                                Get.to(()=>CreateUserProfileScreen(email:widget.email));
                              }
                              else if (home.text == "View User Profile"){
                                // Get.to(()=>HomeUserManagementScreen());
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
          ThemeService().switchTheme();
          notificationHelper.displayNotification(
              title: "Theme Changed",
              body: Get.isDarkMode? "Activated Lumoz Light Theme": "Activated Lumoz Dark Theme"
          );
          //notificationHelper.scheduledNotification();
        },
        child: Icon(Get.isDarkMode? Icons.wb_sunny: Icons.nightlight_round,
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

