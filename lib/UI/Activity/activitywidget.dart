// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_application/Common/Contant.dart';
import 'package:job_application/Common/Url.dart';

class ActivityCard extends StatelessWidget {
  final IconData companyLogo;
  final String icon;
  final Color iconcolor;
  final Color buttoncolor;
  final Color buttonTextcolor;
  final String companyName;
  final String jobTitle;
  final String jobcity;
  final String location;
  final String jobType;
  final String description;
  final String applicants;
  final String views;
  final String timestamp;

  ActivityCard({
    required this.companyLogo,
    required this.icon,
    required this.iconcolor,
    required this.buttoncolor,
    required this.buttonTextcolor,
    required this.companyName,
    required this.jobTitle,
    required this.jobcity,
    required this.location,
    required this.jobType,
    required this.description,
    required this.applicants,
    required this.views,
    required this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: ColorConstant.transparent,
                radius: 16, // Set the desired radius
                child: ClipOval(
                  child: Image.network(
                    "${ApiConstants.baseUrl}" + icon,
                    height: 60, // Adjust to match the diameter (radius * 2)
                    width: 60,
                    fit: BoxFit
                        .cover, // Ensures the image covers the circular area
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.error,
                          size: 50, color: Colors.grey); // Default error icon
                    },
                  ),
                ),
              ),
              // CircleAvatar(
              //     backgroundColor: ColorConstant.accentColor,
              //     radius: 16,
              //   fit: BoxFit.contain,
              //     child: Image.network("${ApiConstants.baseUrl}" + icon)
              //     // Icon(companyLogo, color: ColorConstant.white, size: 20),
              //     ),
              SizedBox(width: 12),
              Text(
                companyName,
                style: GoogleFonts.manrope(
                  color: ColorConstant.black,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              // Image.asset(
              //   icon,
              //   height: 20,
              //   width: 20,
              //   fit: BoxFit.contain,
              // )
              // Icon(icon, color: iconcolor),
            ],
          ),
          SizedBox(height: 8),
          Text(
            jobTitle,
            style: GoogleFonts.manrope(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: ColorConstant.black,
            ),
          ),
          RichText(
            text: TextSpan(
              style: GoogleFonts.manrope(
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
              children: [
                if (jobcity != '')
                  TextSpan(
                    text: "$jobcity • ",
                    style: GoogleFonts.manrope(
                        color: ColorConstant.lightblack, fontSize: 11),
                  ),
                if (jobcity == '')
                  TextSpan(
                    text: "$location • ",
                    style: GoogleFonts.manrope(
                        color: ColorConstant.lightblack, fontSize: 11),
                  ),
                TextSpan(
                  text: jobType,
                  style: GoogleFonts.manrope(
                      color: jobType == "Fulltime"
                          ? ColorConstant.accentColor
                          : ColorConstant.primaryColor,
                      fontSize: 11),
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(
              fontSize: 12,
              color: ColorConstant.lightblack,
            ),
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Container(
                height: 24,
                // width: 65,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: buttonTextcolor),
                    borderRadius: BorderRadius.circular(16),
                    color: buttoncolor),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Center(
                      child: Text(
                    applicants.toUpperCase(),
                    style: GoogleFonts.manrope(
                        fontSize: 10, color: buttonTextcolor),
                  )),
                ),
              ),
              // Row(
              //   children: [
              //     Icon(Icons.group, color: ColorConstant.botton, size: 16),
              //     SizedBox(width: 4),
              //     Text(applicants, style: GoogleFonts.manrope(fontSize: 12)),
              //   ],
              // ),
              // SizedBox(width: 16),
              // Row(
              //   children: [
              //     Icon(Icons.visibility,
              //         color: ColorConstant.primaryColor, size: 16),
              //     SizedBox(width: 4),
              //     Text(views, style: GoogleFonts.manrope(fontSize: 12)),
              //   ],
              // ),
              Spacer(),
              Text(
                timestamp,
                style: GoogleFonts.manrope(
                  fontSize: 12,
                  color: ColorConstant.lightblack,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
