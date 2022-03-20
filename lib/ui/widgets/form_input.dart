import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:lumoz/ui/theme.dart';

class FormInput extends StatelessWidget {
  final String inputLabel;
  final String inputHint;
  final TextEditingController? controller;
  final Widget? widget;
  const FormInput({Key? key, required this.inputLabel, required this.inputHint, this.controller, this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
             inputLabel,
            style: inputLabelStyles,
          ),
          Container(
            height: 52,
            margin: const EdgeInsets.only(top: 8.0),
            padding: const EdgeInsets.only(left: 14),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1.0
              ),
              borderRadius: BorderRadius.circular(12)
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    readOnly: widget==null?false:true,
                    autofocus: false,
                    cursorColor: Get.isDarkMode?Colors.grey[100]:Colors.grey[700],
                    controller: controller,
                    style: inputHintStyles,
                    decoration: InputDecoration(
                      hintText: inputHint,
                      hintStyle: inputHintStyles,
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Get.isDarkMode?greyColor:Colors.white,
                          width: 0
                        )
                      ),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Get.isDarkMode?greyColor:Colors.white,
                              width: 0
                          )
                      )
                    ),
                  ),
                ),
                widget==null?Container():Container(
                  child: widget,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
