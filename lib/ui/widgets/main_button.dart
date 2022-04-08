import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lumoz/ui/theme.dart';

class MainButton extends StatelessWidget {
  final String label;
  final Function()? onTap;

  const MainButton({Key? key, required this.label, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
         width: 150,
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: primaryClr,
        ),
        child: Text(
          label,
          style: GoogleFonts.raleway(textStyle: const TextStyle(
            color: Colors.white,
          ),)
        ),
      ),
    );
  }
}
