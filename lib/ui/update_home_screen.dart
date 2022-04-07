import 'package:get/get.dart';
import 'package:lumoz/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:lumoz/ui/widgets/form_input.dart';
import 'package:lumoz/ui/widgets/main_button.dart';
import '../controllers/home_controller.dart';
import '../models/home.dart';

class UpdateHomeScreen extends StatefulWidget {
  final Home home;
  const UpdateHomeScreen({Key? key, required this.home}) : super(key: key);

  @override
  State<UpdateHomeScreen> createState() => _UpdateHomeScreenState();
}

class _UpdateHomeScreenState extends State<UpdateHomeScreen> {
  final HomeController _homeController = Get.put(HomeController());
  TextEditingController _textController = TextEditingController();
  TextEditingController _imageController = TextEditingController();
  TextEditingController _linkController = TextEditingController();

  @override
  Widget build(BuildContext context) {
 _textController = TextEditingController(text: widget.home.text);
_imageController = TextEditingController(text: widget.home.image);
_linkController = TextEditingController(text: widget.home.link);

    return Scaffold(
      appBar: _appBar(context),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 30),
        child: SingleChildScrollView(
            child: Column(
                children:[
                  Text("Update New Home Tab Information",
                    style: headingStyles,),
                  FormInput(
                    inputLabel: "Text",
                    inputHint: "add home tab text",
                    controller: _textController,),

                  const SizedBox(height: 18,),
                  FormInput(
                    inputLabel: "Image URL",
                    inputHint: "add home tab image url",
                    controller: _imageController,),

                  const SizedBox(height: 18,),
                  FormInput(
                    inputLabel: "Link",
                    inputHint: "add home tab link",
                    controller: _linkController,),

                  const SizedBox(height: 18,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MainButton(label: "Update Tab", onTap: ()=>_validateFormData())
                    ],
                  )
                ]
            )
        ),
      ),
    );
  }

  _validateFormData(){
    if(_textController.text.isNotEmpty && _imageController.text.isNotEmpty && _linkController.text.isNotEmpty){
      _saveFormDataToDB();
      Get.back();

    }else if(
    _textController.text.isEmpty || _imageController.text.isEmpty || _linkController.text.isEmpty
    ) {
      Get.snackbar("Required", "All fields are required!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          icon: const Icon(Icons.warning_amber_rounded));
    }}

  _saveFormDataToDB () async {
      _homeController.updateHomeRecord(
         Home(
            id:widget.home.id,
            text: widget.home.text,
            image:_imageController.text,
            link:_linkController.text

        )
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


