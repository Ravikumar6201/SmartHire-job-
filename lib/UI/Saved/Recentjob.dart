// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_application/Common/Contant.dart';
import 'package:job_application/Common/Url.dart';

class JobCardRecent extends StatelessWidget {
  final String companyLogo;
  // final IconData icon;
  // final Color iconcolor;
  final String companyName;
  final String jobTitle;
  final bool is_saved;
  final String location;
  final String jobType;
  final String description;
  final String city;
  final String country;
  final int applicants;
  final int views;
  final String timestamp;

  JobCardRecent({
    required this.companyLogo,
    // required this.icon,
    // required this.iconcolor,
    required this.companyName,
    required this.jobTitle,
    required this.is_saved,
    required this.location,
    required this.jobType,
    required this.description,
    required this.city,
    required this.country,
    required this.applicants,
    required this.views,
    required this.timestamp,
  });

  String truncateString(String text) {
    if (text.length > 80) {
      return text.substring(0, 80) + '...';
    }
    return text;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorConstant.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          // BoxShadow(
          //   color: ColorConstant.white12,
          //   blurRadius: 6,
          //   offset: Offset(0, 3),
          // ),
        ],
      ),
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
                    "${ApiConstants.baseUrl}" + companyLogo,
                    height: 30, // Adjust to match the diameter (radius * 2)
                    width: 30,
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
              //   backgroundColor: ColorConstant.transparent,
              //   radius: 20,
              //   child: Image.network(
              //     "${ApiConstants.baseUrl}" + companyLogo,
              //     height: 25,
              //     width: 25,
              //     fit: BoxFit.contain,
              //   ),
              // ),
              SizedBox(width: 8),
              Text(
                companyName,
                style: GoogleFonts.manrope(
                  color: ColorConstant.black,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              if (is_saved == true)
                Icon(Icons.bookmark, color: ColorConstant.botton),
              if (is_saved == false)
                Icon(Icons.bookmark_outline, color: ColorConstant.lightblack),
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
                if (location == "Remote")
                  TextSpan(
                    text: "$location • ",
                    style: GoogleFonts.manrope(
                        color: ColorConstant.lightblack, fontSize: 11),
                  ),
                if (location != "Remote")
                  TextSpan(
                    text: "$city , $country • ",
                    style: GoogleFonts.manrope(
                        color: ColorConstant.lightblack, fontSize: 11),
                  ),
                TextSpan(
                  text: jobType,
                  style: GoogleFonts.manrope(
                      color: jobType == "Full-time"
                          ? ColorConstant.accentColor
                          : ColorConstant.primaryColor,
                      fontSize: 11),
                ),
              ],
            ),
          ),
          SizedBox(height: 12),
          Text(
            truncateString(description),
            style: TextStyle(
              fontSize: 12,
              color: ColorConstant.black,
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Row(
                children: [
                  Icon(Icons.group, color: ColorConstant.botton, size: 16),
                  SizedBox(width: 4),
                  Text(applicants.toString(),
                      style: GoogleFonts.manrope(fontSize: 11)),
                ],
              ),
              SizedBox(width: 16),
              Row(
                children: [
                  Icon(Icons.visibility,
                      color: ColorConstant.primaryColor, size: 16),
                  SizedBox(width: 4),
                  Text(views.toString(),
                      style: GoogleFonts.manrope(fontSize: 11)),
                ],
              ),
              Spacer(),
              Text(
                timestamp,
                style: GoogleFonts.manrope(
                  fontSize: 10,
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
