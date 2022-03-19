import 'package:flutter/material.dart';

const Color blueColor = Color(0xFF4e5ae8);
const Color yellowColor = Color(0xFFFFB746);
const Color pinkColor = Color(0xFFff4667);
const Color blackColor = Color(0xFF121212);
const Color greyColor = Color(0xFF424242);
const Color whiteColor = Colors.white;
const primaryClr = blueColor;

class Themes{
  static final light = ThemeData(
      primaryColor: primaryClr,
  brightness: Brightness.light
  );
 static final dark = ThemeData(
     primaryColor: greyColor,
  brightness: Brightness.dark
  );
}