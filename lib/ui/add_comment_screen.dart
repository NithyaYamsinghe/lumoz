import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lumoz/controllers/tvshow_controller.dart';
import 'package:lumoz/models/tv_show.dart';
import 'package:lumoz/ui/theme.dart';
import 'package:lumoz/ui/widgets/form_input.dart';
import 'package:lumoz/ui/widgets/main_button.dart';

class AddCommentScreen extends StatefulWidget {
  const AddCommentScreen({Key? key, required TvShow tvShow}) : super(key: key);

  @override
  State<AddCommentScreen> createState() => _AddCommentScreenState();
}

class _AddCommentScreenState extends State<AddCommentScreen> {
  final TvShowController _tvShowController = Get.put(TvShowController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _channelController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _seasonController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 30),
        child: SingleChildScrollView(
            child: Column(
                children:[
                  Text("Add New Comment",
                    style: headingStyles,),
                  FormInput(
                    inputLabel: "TV Show Title",
                    inputHint: "Enter the tv show title",
                    controller: _titleController,),
                  FormInput(
                    inputLabel: "Channel",
                    inputHint: "Enter the channel",
                    controller: _channelController,
                  ),
                  FormInput(
                    inputLabel: "Season",
                    inputHint: "Enter the season",
                    controller: _seasonController,
                  ),
                  FormInput(
                    inputLabel: "Description",
                    inputHint: "Enter the description",
                    controller: _descriptionController,
                  ),
                  FormInput(
                    inputLabel: "Image URL",
                    inputHint: "Enter the image url",
                    controller: _imageController,
                  ),
                  const SizedBox(height: 18,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MainButton(label: "Add Tv Show", onTap: ()=>_validateFormData())
                    ],
                  )
                ]
            )
        ),
      ),
    );
  }

  _validateFormData(){
    if(_titleController.text.isNotEmpty && _descriptionController.text.isNotEmpty){

      _saveFormDataToDB();
      Get.back();

    }else if(
    _titleController.text.isEmpty && _descriptionController.text.isEmpty
    ) {
      Get.snackbar("Required", "All fields are required!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          icon: const Icon(Icons.warning_amber_rounded));
    }}

  _saveFormDataToDB () async {
    int response =  await  _tvShowController.addTvShow(
        tvShow: TvShow(
            channel: _channelController.text,
            title:_titleController.text,
            image:_imageController.text,
            description:_descriptionController.text,
            season:_seasonController.text,
            isOngoing:0
        )
    );
    print(_titleController.text);
    print("id" + "$response");
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


