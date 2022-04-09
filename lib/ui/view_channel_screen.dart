import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lumoz/models/channel.dart';
import 'package:lumoz/ui/splash_screen.dart';
import 'package:get/get.dart';

import 'home_user_management_screen.dart';

class ViewChannelScreen extends StatefulWidget {
  final Channel channel;

  const ViewChannelScreen({Key? key, required this.channel}) : super(key: key);

  @override
  State<ViewChannelScreen> createState() => _ViewChannelScreenState();
}

class _ViewChannelScreenState extends State<ViewChannelScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBar(context),
        body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 100),
            width: MediaQuery.of(context).size.width,
            height: 500,
            margin: const EdgeInsets.only(bottom: 12),
            child: Center(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(widget.channel.image!),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.9), BlendMode.dstATop)),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.indigo),
                      child: Row(children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Text(
                                  widget.channel.channel!,
                                  style: GoogleFonts.raleway(
                                    textStyle: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                widget.channel.description!,
                                style: GoogleFonts.raleway(
                                  textStyle: TextStyle(
                                      fontSize: 15, color: Colors.grey[100]),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          height: 60,
                          width: 0.5,
                          color: Colors.grey[200]!.withOpacity(0.7),
                        ),
                        const RotatedBox(
                          quarterTurns: 3,
                        ),
                      ]),
                    ),
                  ),
                ))));
  }



  _appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Icon(Icons.arrow_back_ios_new_outlined,
            size: 20, color: Get.isDarkMode ? Colors.white : Colors.black),
      ),
      actions:  [
        GestureDetector(
          onTap: () {
            Get.to(() => const HomeUserManagementScreen());
          },
          child: Icon(Icons.home,
              size: 30, color: Get.isDarkMode ? Colors.white : Colors.black),
        ),
        const SizedBox(
          width: 20,
        ),
        GestureDetector(
          child: Icon(Icons.account_box,
              size: 25, color: Get.isDarkMode ? Colors.white : Colors.black),
        ),
        const SizedBox(
          width: 20,
        ),
        GestureDetector(
          onTap: () {
            Get.to(() => const SplashScreen());
          },
          child: Icon(Icons.logout,
              size: 25, color: Get.isDarkMode ? Colors.white : Colors.black),
        ),
      ],
    );
  }
}
