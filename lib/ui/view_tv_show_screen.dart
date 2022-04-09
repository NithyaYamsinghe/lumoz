import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lumoz/models/tv_show.dart';
import 'package:lumoz/ui/splash_screen.dart';
import 'package:get/get.dart';

import 'home_user_management_screen.dart';

class ViewTvShowScreen extends StatefulWidget {
  final TvShow tvShow;

  const ViewTvShowScreen({Key? key, required this.tvShow}) : super(key: key);

  @override
  State<ViewTvShowScreen> createState() => _ViewTvShowScreenState();
}

class _ViewTvShowScreenState extends State<ViewTvShowScreen> {
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
                    image: NetworkImage(widget.tvShow.image!),
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
                              widget.tvShow.title!,
                              style: GoogleFonts.raleway(
                                textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.calendar_today_outlined,
                                color: Colors.grey[200],
                                size: 18,
                              ),
                              const SizedBox(width: 4),
                              Center(
                                child: Text(
                                  widget.tvShow.date!,
                                  style: GoogleFonts.raleway(
                                    textStyle: TextStyle(
                                        fontSize: 13, color: Colors.grey[100]),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Center(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Center(
                                  child: Icon(
                                    Icons.access_time_rounded,
                                    color: Colors.grey[200],
                                    size: 18,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Center(
                                  child: Text(
                                    "${widget.tvShow.startTime} - ${widget.tvShow.endTime}",
                                    style: GoogleFonts.raleway(
                                      textStyle: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey[100]),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            widget.tvShow.description!,
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
                    RotatedBox(
                      quarterTurns: 3,
                      child: Text(
                        widget.tvShow.isOngoing == 1 ? "COMPLETED" : "ON GOING",
                        style: GoogleFonts.raleway(
                          textStyle: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
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
