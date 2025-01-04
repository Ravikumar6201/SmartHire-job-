// ignore_for_file: prefer_const_literals_to_create_immutables, use_key_in_widget_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:job_application/Common/Contant.dart';
import 'package:job_application/Core/Provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditInfo extends StatefulWidget {
  String email, phone, locationn, website;
  @override
  EditInfo(
      {required this.email,
      required this.phone,
      required this.locationn,
      required this.website});

  @override
  State<EditInfo> createState() => _EditInfoState();
}

class _EditInfoState extends State<EditInfo> {
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController domicileController;
  late TextEditingController potfolioController;
  String? Token;
  String? userID;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController(text: widget.email);
    phoneController = TextEditingController(text: widget.phone);
    domicileController = TextEditingController(text: widget.locationn);
    potfolioController = TextEditingController(text: widget.website);
    getData();
  }

  getData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Token = preferences.getString('token');
    userID = preferences.getString('userid');
    setState(() {
      Token;
      userID;
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UserProvider>();
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Edit Info',
            style: GoogleFonts.manrope(
                fontSize: 16,
                color: ColorConstant.black,
                fontWeight: FontWeight.bold),
          ),
          centerTitle: false,
          actions: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
                // Navigator.pushAndRemoveUntil(
                //   context,
                //   MaterialPageRoute(builder: (context) => SettingScreen()),
                //   (Route<dynamic> route) => false,
                // );
              },
              child: Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Image.asset(
                    'assets/images/settingimg/settings.png',
                    height: 25,
                    width: 25,
                    fit: BoxFit.contain,
                  )),
            )
          ],
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset(
              'assets/images/backarrow.png',
              height: 100,
              width: 100,
              fit: BoxFit.contain,
            ),
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInputField(
                  label: "Email",
                  icon: 'assets/images/smallmail.png',
                  controller: emailController,
                  showPrefixIcon: true,
                  readonly: true),
              SizedBox(height: 16),
              _buildInputField(
                  label: "Phone number",
                  icon: 'assets/images/smallcall.png',
                  controller: phoneController,
                  showPrefixIcon: true,
                  readonly: true),
              SizedBox(height: 16),
              _buildInputField(
                  label: "Location",
                  icon: 'assets/images/smallloacation.png',
                  controller: domicileController,
                  showPrefixIcon: true,
                  readonly: false),
              SizedBox(height: 16),
              _buildInputField(
                  label: "Portfolio site",
                  icon: 'assets/images/smallglobe.png',
                  controller: potfolioController,
                  showPrefixIcon: true,
                  readonly: false),
              /* SizedBox(height: 16),
              Container(
                height: 56,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(width: 01, color: ColorConstant.botton)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add,
                      color: ColorConstant.editinfo,
                    ),
                    Text(
                      " Add New Portfolio Site",
                      style: GoogleFonts.manrope(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: ColorConstant.editinfo),
                    ),
                  ],
                ),
              ),
             */
              SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        side: BorderSide(color: ColorConstant.lightblack),
                      ),
                      child: Text("Cancel",
                          style: GoogleFonts.manrope(
                              color: ColorConstant.lightblack, fontSize: 14)),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        if (matcheted == true) {
                          Map<String, dynamic> result =
                              await provider.ProfileInfoupdate(
                            userID.toString(),
                            Token.toString(),
                            emailController.text,
                            phoneController.text,
                            domicileController.text,
                            potfolioController.text,
                          );
                          if (result['success']) {
                            // Handle successful registration
                            final data = result['data'];
                            Fluttertoast.showToast(
                              msg: data['message'],
                              toastLength: Toast.LENGTH_SHORT,
                              gravity:
                                  ToastGravity.TOP, // Show toast at the top
                              timeInSecForIosWeb: 1,
                              backgroundColor: ColorConstant.green,
                              textColor: ColorConstant.white,
                              fontSize: 16.0,
                            );
                          } else {
                            Fluttertoast.showToast(
                              msg: result['data']['message'],
                              toastLength: Toast.LENGTH_SHORT,
                              gravity:
                                  ToastGravity.TOP, // Show toast at the top
                              timeInSecForIosWeb: 1,
                              backgroundColor: ColorConstant.green,
                              textColor: ColorConstant.white,
                              fontSize: 16.0,
                            );
                          }

                          Navigator.pop(context);
                        } else {
                          Fluttertoast.showToast(
                            msg: "Please Enter a valied url",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.TOP, // Show toast at the top
                            timeInSecForIosWeb: 1,
                            backgroundColor: ColorConstant.red,
                            textColor: ColorConstant.white,
                            fontSize: 16.0,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstant.botton,
                        padding: EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text("Save",
                          style: GoogleFonts.manrope(
                            fontSize: 14,
                            color: ColorConstant.white,
                          )),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  final regex = RegExp(
    r"^(https?:\/\/)?(www\.)?[a-zA-Z0-9.-]+\.(com|in|org|net|edu|gov|co|io|info|biz|uk|us|de|jp|fr|au|ca|cn|it|es|nl|ru|ch|se|no|dk|be|br|ar|za|kr|mx)$",
  );
  bool matcheted = true;
  Widget _buildInputField({
    required String label,
    required String icon,
    required TextEditingController controller,
    required bool
        showPrefixIcon, // Add a new parameter to control the visibility
    required bool readonly,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: GoogleFonts.manrope(
                fontSize: 14, color: ColorConstant.lightblack)),
        SizedBox(height: 8),
        if (label == "Portfolio site")
          TextField(
            controller: controller,
            readOnly: readonly,
            style: GoogleFonts.manrope(
                fontSize: 14,
                color:
                    readonly ? ColorConstant.lightblack : ColorConstant.black),
            maxLines: maxLines,
            onChanged: (value) {
              // Regular expression to validate a URL with proper domain extensions

              if (!regex.hasMatch(value)) {
                Fluttertoast.showToast(
                  msg:
                      "Please enter a valid URL with proper domain extensions.",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                );
                setState(() {
                  matcheted = false;
                  // potfolioController.text = '';
                });
              } else {
                setState(() {
                  matcheted = true;
                  // potfolioController.text = '';
                });
              }
            },
            decoration: InputDecoration(
              hintStyle: GoogleFonts.manrope(
                  color: ColorConstant.lightblack, fontSize: 14),
              prefixIcon: showPrefixIcon
                  ? Image.asset(
                      icon,
                      color: ColorConstant.editinfo,
                    )
                  : null, // Conditionally show the icon or set it to null
              prefixStyle: GoogleFonts.manrope(
                color: ColorConstant.lightblack,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
                borderSide: BorderSide(
                  color: ColorConstant.bordercolor,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide(
                  color: ColorConstant.bordercolor,
                  width: 1,
                ),
              ),
              filled: true,
              fillColor: ColorConstant.transparent,
            ),
          ),
        if (label != "Portfolio site")
          TextField(
            controller: controller,
            readOnly: readonly,
            style: GoogleFonts.manrope(
                fontSize: 14,
                color:
                    readonly ? ColorConstant.lightblack : ColorConstant.black),
            maxLines: maxLines,
            decoration: InputDecoration(
              hintStyle: GoogleFonts.manrope(
                  color: ColorConstant.lightblack, fontSize: 14),
              prefixIcon: showPrefixIcon
                  ? Image.asset(
                      icon,
                      // height: 18,
                      // width: 18,
                      // fit: BoxFit.contain,
                      color: ColorConstant.editinfo,
                    )
                  : null, // Conditionally show the icon or set it to null
              prefixStyle: GoogleFonts.manrope(
                color: ColorConstant.lightblack,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
                borderSide: BorderSide(
                  color: ColorConstant.bordercolor,
                  width: 1,
                ),
              ),

              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide(
                  color: ColorConstant.bordercolor,
                  width: 1,
                ),
              ),
              filled: true,
              fillColor: ColorConstant.transparent,
            ),
          ),
      ],
    );
  }
}
