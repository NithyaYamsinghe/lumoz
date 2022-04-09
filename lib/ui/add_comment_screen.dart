import 'package:get/get.dart';
import 'package:lumoz/ui/splash_screen.dart';
import 'package:lumoz/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:lumoz/models/comment.dart';
import 'package:lumoz/models/tv_show.dart';
import 'package:lumoz/ui/widgets/form_input.dart';
import 'package:lumoz/ui/widgets/main_button.dart';
import 'package:lumoz/controllers/comment_controller.dart';

import 'home_user_management_screen.dart';

class AddCommentScreen extends StatefulWidget {
  final TvShow tvShow;

  const AddCommentScreen({Key? key, required this.tvShow}) : super(key: key);

  @override
  State<AddCommentScreen> createState() => _AddCommentScreenState();
}

class _AddCommentScreenState extends State<AddCommentScreen> {
  final CommentController _commentController = Get.put(CommentController());
  final TextEditingController _commentTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Container(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 30),
        child: SingleChildScrollView(
            child: Column(children: [
          Text(
            "Add New Comment",
            style: headingStyles,
          ),
          FormInput(
            inputLabel: "Comment",
            inputHint: "add new comment",
            controller: _commentTextController,
          ),
          const SizedBox(
            height: 18,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MainButton(
                  label: "Add Comment",
                  onTap: () => _validateFormData(widget.tvShow))
            ],
          )
        ])),
      ),
    );
  }

  _validateFormData(TvShow tvShow) {
    if (_commentTextController.text.isNotEmpty) {
      _saveFormDataToDB(tvShow);
      Get.back();
    } else if (_commentTextController.text.isEmpty) {
      Get.snackbar("Required", "All fields are required!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          icon: const Icon(Icons.warning_amber_rounded));
    }
  }

  _saveFormDataToDB(TvShow tvShow) async {
    await _commentController.addComment(
        comment: Comment(
      comment: _commentTextController.text,
      tvShowId: tvShow.id,
    ));
    Get.snackbar("Success", "Added Successfully!",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        icon: const Icon(Icons.done));
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
