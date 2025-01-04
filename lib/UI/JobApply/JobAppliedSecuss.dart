// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_application/Common/Contant.dart';
import 'package:job_application/UI/Home/HomeScreen.dart';
import 'package:job_application/UI/Saved/Allpostedjob.dart';

class ApplyJobSecussScreen extends StatefulWidget {
  const ApplyJobSecussScreen({super.key});

  @override
  State<ApplyJobSecussScreen> createState() => _ApplyJobSecussScreenState();
}

class _ApplyJobSecussScreenState extends State<ApplyJobSecussScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
                child: Image.asset(
              'assets/images/uploadresume.png',
              height: 160,
              width: 160,
              fit: BoxFit.contain,
            )),
            SizedBox(height: 16),
            Text(
              "Job Applied Successfully",
              style: GoogleFonts.manrope(
                  fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "We will inform you about the next information, please sit tight.",
              textAlign: TextAlign.center,
              style: GoogleFonts.manrope(
                  fontSize: 14, color: ColorConstant.lightblack),
            ),
            SizedBox(height: 24),
            // InkWell(
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) => AllpostedJob(
            //                 headername: 'All Jobs',
            //               )), // Replace `NewPage` with the page you want to navigate to
            //     );
            //   },
            //   child: Container(
            //     height: 56,
            //     width: double.infinity,
            //     decoration: BoxDecoration(
            //         border:
            //             Border.all(width: 0.5, color: ColorConstant.lightblack),
            //         borderRadius: BorderRadius.circular(100),
            //         color: ColorConstant.botton),
            //     child: Center(
            //       child: Text(
            //         "Search Other Jobs",
            //         style: GoogleFonts.manrope(
            //             fontSize: 16,
            //             color: ColorConstant.white,
            //             fontWeight: FontWeight.bold),
            //       ),
            //     ),
            //   ),
            // ),
            // SizedBox(height: 24),
            InkWell(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                  (Route<dynamic> route) => false,
                );
              },
              child: Container(
                height: 56,
                width: double.infinity,
                decoration: BoxDecoration(
                    border:
                        Border.all(width: 0.5, color: ColorConstant.lightblack),
                    borderRadius: BorderRadius.circular(100),
                    color: ColorConstant.transparent),
                child: Center(
                  child: Text(
                    "Go to Home",
                    style: GoogleFonts.manrope(
                        fontSize: 16,
                        color: ColorConstant.lightblack,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
