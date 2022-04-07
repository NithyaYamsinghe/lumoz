import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lumoz/controllers/user_controller.dart';
import 'package:lumoz/ui/add_user_screen.dart';
import 'package:lumoz/ui/theme.dart';
import 'package:lumoz/ui/widgets/main_button.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:lumoz/ui/widgets/user_title.dart';
import '../models/user.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final UserController _userController = Get.put(UserController());

  @override
  void initState() {
    super.initState();
    _userController.getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Column(
        children:[
          _addUserBar(),
          SizedBox(height: 10,),
          _showUsers()
        ],
      ),
    );
  }

  _showUsers(){
    return Expanded(
      child: Obx((){
        return ListView.builder(
            itemCount: _userController.userList.length,
            itemBuilder: (_, index){
              User user = _userController.userList[index];
              print(user.toJson());
              return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    child: FadeInAnimation(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: (){
                              _showBottomOptions(context, user);
                            },
                            child: UserTile(user),
                          )
                        ],
                      ),
                    ),
                  ));
            });
      }),
    );
  }

  _showBottomOptions(BuildContext context, User user){
    Get.bottomSheet(
        Container(
          padding: const EdgeInsets.only(top: 4),
          height:  MediaQuery.of(context).size.height*0.30,
          color: Get.isDarkMode?blackColor:Colors.white,
          child: Column(
            children: [
              Container(
                height: 6,
                width: 120,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Get.isDarkMode?Colors.grey[600]:Colors.grey[300]
                ),
              ),
              const Spacer(),
              _bottomOptionsButton(
                  buttonLabel: "Delete User",
                  onTap: (){
                    _userController.deleteUser(user);
                    Get.back();
                  },
                  color: Colors.red[300]!,
                  context:context
              ),
              const SizedBox(
                height: 10,
              ),
              _bottomOptionsButton(
                  buttonLabel: "Close",
                  onTap: (){
                    Get.back();
                  },
                  color: Colors.white,
                  isClosed: true,
                  context:context
              ),
              const SizedBox(
                height: 20,
              ),

            ],
          ),
        )
    );
  }

  _bottomOptionsButton({
    required String buttonLabel,
    required Function()? onTap,
    required Color color,
    bool isClosed=false,
    required BuildContext context

  }){

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 55,
        width:MediaQuery.of(context).size.width*0.9,
        decoration: BoxDecoration(
          border: Border.all(width: 2,
              color: isClosed==true? Get.isDarkMode?Colors.grey[600]!: Colors.grey[300]!:color),
          borderRadius: BorderRadius.circular(20),
          color: isClosed==true? Colors.transparent:color,
        ),
        child: Center(
          child: Text(
            buttonLabel,
            style: isClosed?inputLabelStyles:inputLabelStyles.copyWith(color: Colors.white),
          ),
        ),
      ),

    );
  }

  _addUserBar(){
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Lumoz", style: headingStyles,)
              ],
            ),
          ),
          MainButton(label: "Add New User", onTap: () async {
            await Get.to(() => AddUserScreen());
            _userController.getUsers();
          })
        ],
      ),
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

