import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

const Color blueColor = Color(0xFF4e5ae8);
const Color yellowColor = Color(0xFFFFB746);
const Color pinkColor = Color(0xFFff4667);
const Color blackColor = Color(0xFF121212);
const Color greyColor = Color(0xFF424242);
const Color whiteColor = Colors.white;
const primaryClr = blueColor;

class Themes{
  static final light = ThemeData(
    backgroundColor: Colors.white,
      primaryColor: whiteColor,
  brightness: Brightness.light
  );
 static final dark = ThemeData(
   backgroundColor: greyColor,
     primaryColor: greyColor,
  brightness: Brightness.dark
  );
}

TextStyle get subHeadingStyles{
  return GoogleFonts.raleway (
     textStyle: TextStyle(
       fontSize: 24,
       fontWeight: FontWeight.bold,
         color: Get.isDarkMode? Colors.grey[400]:Colors.grey
     )
  ) ;
}

TextStyle get headingStyles{
  return GoogleFonts.raleway(
      textStyle: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
          color: Get.isDarkMode? Colors.white:Colors.black
      )
  ) ;
}

TextStyle get inputLabelStyles{
  return GoogleFonts.raleway(
      textStyle: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: Get.isDarkMode? Colors.white:Colors.black
      )
  ) ;
}


TextStyle get inputHintStyles{
  return GoogleFonts.raleway(
      textStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Get.isDarkMode? Colors.grey[100]:Colors.grey[600]
      )
  ) ;
}