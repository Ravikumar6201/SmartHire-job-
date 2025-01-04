// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:job_application/Common/Contant.dart';

class GoogleLoginScreen extends StatefulWidget {
  String name, email, image, plateform;
  @override
  GoogleLoginScreen(
      {required this.name,
      required this.email,
      required this.image,
      required this.plateform});

  @override
  State<GoogleLoginScreen> createState() => _GoogleLoginScreenState();
}

class _GoogleLoginScreenState extends State<GoogleLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            if (widget.plateform == 'gmail')
              Text('Loged with Gmail',
                  style: GoogleFonts.manrope(
                      color: ColorConstant.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
            if (widget.plateform != 'gmail')
              Text('Loged with Linkedlin',
                  style: GoogleFonts.manrope(
                      color: ColorConstant.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
          ],
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //       builder: (context) =>
            //           HomeScreen()), // Replace `NewPage` with the page you want to navigate to
            // );
          },
          child: Image.asset(
            'assets/images/backarrow.png',
            height: 100,
            width: 100,
            fit: BoxFit.contain,
          ),
        ),
        backgroundColor: ColorConstant.white,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (widget.image != null)
              ClipOval(
                child: Image.network(
                  widget.image,
                  width: 100, // Set the desired width
                  height: 100, // Set the desired height
                  fit: BoxFit
                      .cover, // Ensures the image scales to cover the area
                ),
              ),
            SizedBox(
              height: 12,
            ),
            Text(widget.name),
            SizedBox(
              height: 12,
            ),
            Text(widget.email),
            SizedBox(
              height: 24,
            ),
            if (widget.plateform == 'gmail')
              ElevatedButton(
                  onPressed: () {
                    GoogleSignIn().signOut();
                    Navigator.pop(context);
                  },
                  child: Text("Log Out")),
            if (widget.plateform != 'gmail')
              ElevatedButton(
                  onPressed: () {
                    // GoogleSignIn().signOut();
                    Navigator.pop(context);
                  },
                  child: Text("Log Out"))
          ],
        ),
      ),
    );
  }
}
