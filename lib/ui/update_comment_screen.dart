import 'package:get/get.dart';
import 'package:lumoz/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:lumoz/models/comment.dart';
import 'package:lumoz/ui/widgets/form_input.dart';
import 'package:lumoz/ui/widgets/main_button.dart';
import 'package:lumoz/controllers/comment_controller.dart';

class UpdateCommentScreen extends StatefulWidget {
  final Comment comment;
  const UpdateCommentScreen({Key? key, required this.comment}) : super(key: key);

  @override
  State<UpdateCommentScreen> createState() => _UpdateCommentScreenState();
}

class _UpdateCommentScreenState extends State<UpdateCommentScreen> {
  final CommentController _commentController = Get.put(CommentController());
   TextEditingController _commentTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _commentTextController = TextEditingController(text: widget.comment.comment);
    return Scaffold(
      appBar: _appBar(context),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 30),
        child: SingleChildScrollView(
            child: Column(
                children:[
                  Text("Update Comment",
                    style: headingStyles,),
                  FormInput(
                    inputLabel: "Comment",
                    inputHint: "update new comment",
                    controller: _commentTextController,),

                  const SizedBox(height: 18,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MainButton(label: "Update Comment", onTap: ()=>_validateFormData())
                    ],
                  )
                ]
            )
        ),
      ),
    );
  }

  _validateFormData(){
    if(_commentTextController.text.isNotEmpty){
      _saveFormDataToDB();
      Get.back();

    }else if(
    _commentTextController.text.isEmpty
    ) {
      Get.snackbar("Required", "All fields are required!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          icon: const Icon(Icons.warning_amber_rounded));
    }}

  _saveFormDataToDB ()  {
   _commentController.updateCommentRecord( Comment(
       id: widget.comment.id,
       comment:_commentTextController.text,
       tvShowId: widget.comment.tvShowId
   ));
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


