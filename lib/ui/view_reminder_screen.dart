import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lumoz/ui/theme.dart';
class ViewReminderScreen extends StatefulWidget {
  final String? label;
  const ViewReminderScreen({Key? key, required this.label}) : super(key: key);

  @override
  State<ViewReminderScreen> createState() => _ViewReminderScreenState();
}

class _ViewReminderScreenState extends State<ViewReminderScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
      const EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      height: 10,
      margin: const EdgeInsets.only(bottom: 12),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          //  width: SizeConfig.screenWidth * 0.78,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: _getBGClr(int. parse(widget.label.toString().split("|")[6])),
          ),
          child: Row
            (children: [

            Expanded(

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text( widget.label.toString().split("|")[0],
                      style: GoogleFonts.raleway(
                        textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        color: Colors.grey[200],
                        size: 18,
                      ),
                      const SizedBox(width: 4),
                      Center(
                        child: Text(
                          widget.label.toString().split("|")[3],
                          style: GoogleFonts.raleway(
                            textStyle:
                            TextStyle(fontSize: 13, color: Colors.grey[100]),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Center(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Icon(
                            Icons.access_time_rounded,
                            color: Colors.grey[200],
                            size: 18,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Center(
                          child: Text(
                            "${widget.label.toString().split("|")[5]} - ${widget.label.toString().split("|")[4]}",
                            style: GoogleFonts.raleway(
                              textStyle:
                              TextStyle(fontSize: 13, color: Colors.grey[100]),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                   Text(
                      widget.label.toString().split("|")[1],
                      style: GoogleFonts.raleway(
                        textStyle: TextStyle(fontSize: 15, color: Colors.grey[100]),
                      ),
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
            RotatedBox(
              quarterTurns: 3,
              child: Text(
                widget.label.toString().split("|")[2] == 1 ? "COMPLETED" : "REMINDER",
                style: GoogleFonts.raleway(
                  textStyle: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  _getBGClr(int no) {
    switch (no) {
      case 0:
        return blueColor;
      case 1:
        return pinkColor;
      case 2:
        return yellowColor;
      default:
        return blueColor;
    }
  }
}
