// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:job_application/Common/Contant.dart';

class SplashScreen extends StatelessWidget {
  void initState() {
    //super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
            decoration: BoxDecoration(
              color: ColorConstant.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Center(
                child: Image.asset("assets/images/flashimage.png"),
              ),
            )),
      ),
    );
  }
}
