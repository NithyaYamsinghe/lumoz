import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/user.dart';

class UserTile extends StatelessWidget {
  final User? user;
  UserTile(this.user);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
      const EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.blueGrey,
          borderRadius: BorderRadius.circular(16),
          // color: Colors.green
        ),
        child: Row(children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user?.userName??"",
                  style: GoogleFonts.raleway(
                    textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  user?.email??"",
                  style: GoogleFonts.raleway(
                    textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  user?.firstName??"",
                  style: GoogleFonts.raleway(
                    textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  user?.lastName??"",
                  style: GoogleFonts.raleway(
                    textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  user?.age == 0? "": user?.age.toString()??"",
                  style: GoogleFonts.raleway(
                    textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  user?.mobile??"",
                  style: GoogleFonts.raleway(
                    textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),),
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
          const RotatedBox(
            quarterTurns: 3,
          ),
        ]),
      ),
    );
  }
}