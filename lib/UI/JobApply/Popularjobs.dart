import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_application/Common/Contant.dart';

class JobCard extends StatelessWidget {
  final String companyLogo;
  final String jobTitle;
  final String companyName;
  final String location;
  final VoidCallback onMorePressed;

  JobCard({
    required this.companyLogo,
    required this.jobTitle,
    required this.companyName,
    required this.location,
    required this.onMorePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      // padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorConstant.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          // BoxShadow(
          //   color: ColorConstant.lightblack,
          //   blurRadius: 2,
          //   offset: Offset(0, 0),
          // ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              width: 50, // Adjust width as needed
              height: 50, // Adjust height as needed
              decoration: BoxDecoration(
                color: ColorConstant.botton,
                borderRadius:
                    BorderRadius.circular(12), // Optional: rounded corners
              ),
              child: Image.asset(companyLogo)),
          // CircleAvatar(
          //   backgroundColor: ColorConstant.accentColor,
          //   radius: 25,
          //   child: Icon(companyLogo, color: Colors.white, size: 28),
          // ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  jobTitle,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      companyName,
                      style: GoogleFonts.manrope(
                        fontSize: 12,
                        color: ColorConstant.lightblack,
                      ),
                    ),
                    SizedBox(width: 5),
                    Text(
                      " • " + location,
                      style: GoogleFonts.manrope(
                        fontSize: 12,
                        color: ColorConstant.lightblack,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.more_vert,
              color: ColorConstant.lightblack,
            ),
            onPressed: onMorePressed,
          ),
        ],
      ),
    );
  }
}
