import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lumoz/controllers/tvshow_controller.dart';
import 'package:lumoz/models/channel.dart';
import 'package:lumoz/ui/add_comment_screen.dart';
import 'package:lumoz/ui/add_reminder_screen.dart';
import 'package:lumoz/ui/reminder_screen.dart';
import 'package:lumoz/ui/theme.dart';
import 'package:lumoz/ui/widgets/tv_show_tile.dart';
import '../models/tv_show.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'comment_screen.dart';

class HomeTvShowScreen extends StatefulWidget {
  final Channel channel;

  const HomeTvShowScreen({Key? key, required this.channel}) : super(key: key);

  @override
  State<HomeTvShowScreen> createState() => _HomeTvShowScreenState();
}

class _HomeTvShowScreenState extends State<HomeTvShowScreen> {
  final TvShowController _tvShowController = Get.put(TvShowController());

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    _tvShowController.getSelectedTvShows(widget.channel.channel!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          _showTvShows()
        ],
      ),
    );
  }

  _showTvShows() {
    return Expanded(
      child: Obx(() {
        return ListView.builder(
            itemCount: _tvShowController.selectedTvShowList.length,
            itemBuilder: (_, index) {
              TvShow tvShow = _tvShowController.selectedTvShowList[index];
              print(_tvShowController.selectedTvShowList);
              print(tvShow.toJson());
              return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    child: FadeInAnimation(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _showBottomOptions(context, tvShow);
                            },
                            child: TvShowTile(tvShow),
                          )
                        ],
                      ),
                    ),
                  ));
            });
      }),
    );
  }

  _showBottomOptions(BuildContext context, TvShow tvShow) {
    Get.bottomSheet(Container(
      padding: const EdgeInsets.only(top: 4),
      height: tvShow.isOngoing == 0
          ? MediaQuery.of(context).size.height * 0.90
          : MediaQuery.of(context).size.height * 0.90,
      color: Get.isDarkMode ? blackColor : Colors.white,
      child: Column(
        children: [
          Container(
            height: 6,
            width: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Get.isDarkMode ? Colors.grey[600] : Colors.grey[300]),
          ),
          const Spacer(),
          const SizedBox(
            height: 6,
          ),
          _bottomOptionsButton(
              buttonLabel: "Add Comment",
              onTap: () {
                Get.to(() => AddCommentScreen(
                      tvShow: tvShow,
                    ));
              },
              color: Colors.indigo,
              context: context),
          const SizedBox(
            height: 8,
          ),
          _bottomOptionsButton(
              buttonLabel: "View Comments",
              onTap: () {
                Get.to(() => CommentScreen(
                      tvShow: tvShow,
                    ));
              },
              color: Colors.green,
              context: context),
          const SizedBox(
            height: 8,
          ),
          _bottomOptionsButton(
              buttonLabel: "Set Reminder",
              onTap: () {
                Get.to(() => AddReminderScreen(tvShow: tvShow));
              },
              color: greyColor,
              context: context),
          const SizedBox(
            height: 8,
          ),
          _bottomOptionsButton(
              buttonLabel: "View Reminder",
              onTap: () {
                Get.to(() => const ReminderScreen());
              },
              color: Colors.indigo,
              context: context),
          const SizedBox(
            height: 8,
          ),
          _bottomOptionsButton(
              buttonLabel: "Close",
              onTap: () {
                Get.back();
              },
              color: Colors.white,
              isClosed: true,
              context: context),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    ));
  }

  _bottomOptionsButton(
      {required String buttonLabel,
      required Function()? onTap,
      required Color color,
      bool isClosed = false,
      required BuildContext context}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 55,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          border: Border.all(
              width: 2,
              color: isClosed == true
                  ? Get.isDarkMode
                      ? Colors.grey[600]!
                      : Colors.grey[300]!
                  : color),
          borderRadius: BorderRadius.circular(20),
          color: isClosed == true ? Colors.transparent : color,
        ),
        child: Center(
          child: Text(
            buttonLabel,
            style: isClosed
                ? inputLabelStyles
                : inputLabelStyles.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
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
      actions: const [
        CircleAvatar(
          backgroundImage: AssetImage("images/profile.jpg"),
        ),
        SizedBox(
          width: 20,
        )
      ],
    );
  }
}
