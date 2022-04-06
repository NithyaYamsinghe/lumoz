import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/admin_management.dart';

class AdminManagementTile extends StatelessWidget {
  final AdminManagement? adminManagement;
  AdminManagementTile(this.adminManagement);

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
          image: DecorationImage(image: NetworkImage(adminManagement?.image??""),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.9), BlendMode.dstATop)),
          borderRadius: BorderRadius.circular(16),
          // color: Colors.green
        ),
        child: Row(children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  adminManagement?.text??"",
                  style: GoogleFonts.raleway(
                    textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                const SizedBox(height: 12),
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