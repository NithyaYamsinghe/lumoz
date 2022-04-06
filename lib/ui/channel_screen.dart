import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lumoz/controllers/channel_controller.dart';
import 'package:lumoz/ui/add_channel_screen.dart';
import 'package:lumoz/ui/theme.dart';
import 'package:lumoz/ui/widgets/channel_tile.dart';
import 'package:lumoz/ui/widgets/main_button.dart';
import '../models/channel.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ChannelScreen extends StatefulWidget {
  const ChannelScreen({Key? key}) : super(key: key);

  @override
  State<ChannelScreen> createState() => _ChannelScreenState();
}

class _ChannelScreenState extends State<ChannelScreen> {
  final ChannelController _channelController = Get.put(ChannelController());

  @override
  void initState() {
    super.initState();
    _channelController.getChannels();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Column(
        children:[
          _addChannelBar(),
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
            itemCount: _channelController.channelList.length,
            itemBuilder: (_, index){
              Channel channel= _channelController.channelList[index];
              print(channel.toJson());
              return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    child: FadeInAnimation(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: (){
                              _showBottomOptions(context, channel);
                            },
                            child: ChannelTile(channel),
                          )
                        ],
                      ),
                    ),
                  ));
            });
      }),
    );
  }

  _showBottomOptions(BuildContext context, Channel channel){
    Get.bottomSheet(
        Container(
          padding: const EdgeInsets.only(top: 4),
          height: MediaQuery.of(context).size.height*0.45,
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
                  buttonLabel: "Delete Channel",
                  onTap: (){
                    _channelController.deleteChannel(channel);
                    Get.back();
                  },
                  color: Colors.red[300]!,
                  context:context
              ),
              const SizedBox(
                height: 10,
              ),
              _bottomOptionsButton(
                  buttonLabel: "Update Channel",
                  onTap: (){
                    // Get.to(()=>AddCommentScreen(channel: channel,));
                  },
                  color: greyColor,
                  isClosed: true,
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

  _addChannelBar(){
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
          MainButton(label: "Add New Channel", onTap: () async {
            await Get.to(() => const AddChannelScreen());
            _channelController.getChannels();
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
