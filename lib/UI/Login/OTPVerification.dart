// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_catch_stack, unused_field, avoid_unnecessary_containers, avoid_print, non_constant_identifier_names, sized_box_for_whitespace, use_key_in_widget_constructors, library_private_types_in_public_api, must_call_super, must_be_immutable
import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_application/Common/Contant.dart';
import 'package:job_application/Core/Provider.dart';
import 'package:job_application/UI/Home/HomeScreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPValidationPage extends StatefulWidget {
  String email, otp, userid, deviceId;
  @override
  OTPValidationPage(
      {required this.email,
      required this.otp,
      required this.userid,
      required this.deviceId});
  @override
  _OTPValidationPageState createState() => _OTPValidationPageState();
}

class _OTPValidationPageState extends State<OTPValidationPage> {
  String enteredOTP = '';
  final _formKey = GlobalKey<FormState>();
  var OTPController = TextEditingController();
  bool ischeck = true;
  Duration? remaining;
  bool timeout = false;
  String email = '';
  String otp = '';
  String userid = '';
  dynamic _deviceId;

  @override
  void initState() {
    setState(() {
      otp = widget.otp;
      email = widget.email;
      userid = widget.userid;
    });
    startCountdown();
  }

  // Function to fetch the device ID
  Future<void> fetchDeviceId() async {
    try {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

      if (Platform.isAndroid) {
        // Get Android-specific device information
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        setState(() {
          _deviceId = androidInfo.id; // Device-specific ID
        });
      } else if (Platform.isIOS) {
        // Get iOS-specific device information
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        setState(() {
          _deviceId = iosInfo.identifierForVendor; // Unique ID for the device
        });
      } else {
        _deviceId = 'Unsupported Platform';
      }
    } catch (e) {
      _deviceId = 'Error fetching device ID: $e';
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final Size screenSize = MediaQuery.of(context).size;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    double fontSizeTitle =
        screenWidth * 0.07; // Adjust title font size based on screen width
    double fontSizeBody =
        screenWidth * 0.045; // Adjust body font size based on screen width
    double buttonPadding = screenWidth * 0.04;
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('OTP Validation'),
      // ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(left: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 150, // Set the desired height
                        width: 150, // Set the desired width
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/login.png"),
                              alignment: Alignment
                                  .topRight, // Position the image in the top-right corner
                              fit: BoxFit.fill, // Adjust the image fit
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: EdgeInsets.only(right: 24),
                    child: Row(
                      children: [
                        Text(
                          'Check your Email',
                          style: GoogleFonts.manrope(
                              fontSize: 24,
                              color: ColorConstant.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  Padding(
                    padding: EdgeInsets.only(right: 24),
                    child: Row(
                      children: [
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              style: GoogleFonts.manrope(
                                fontSize: 16,
                                color: ColorConstant.lightblack,
                              ),
                              children: [
                                TextSpan(
                                  text:
                                      'Please type the verification code sent to your given email ID: ',
                                ),
                                TextSpan(
                                  text: widget.email,
                                  style: GoogleFonts.manrope(
                                    fontWeight: FontWeight
                                        .bold, // Make the email bold or apply desired style
                                    color: ColorConstant
                                        .botton, // Optional: Use a different color for emphasis
                                  ),
                                ),
                              ],
                            ),
                            softWrap:
                                true, // Ensures text wraps within width limits
                          ),
                          // Text(
                          //   'Please type the verification code sent to your given email ID : '
                          //       widget.email,
                          //   style: GoogleFonts.manrope(
                          //       fontSize: 16, color: ColorConstant.lightblack),
                          //   softWrap:
                          //       true, // Ensures text wraps when reaching width limit
                          // ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.only(right: 24),
                    child: Container(
                      height: 72,
                      child: PinCodeTextField(
                        controller: OTPController,
                        length: 4,
                        keyboardType: TextInputType.number,
                        // inputFormatters: [FilteringTextInputFormatter.digitsOnly]
                        cursorColor: ColorConstant.botton, // Cursor color
                        onChanged: (value) {
                          print(value); // Print OTP value on change
                        },
                        onCompleted: (value) {
                          print("Completed OTP: $value"); // OTP completed
                        },
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,

                          borderRadius: BorderRadius.circular(12),
                          fieldHeight: 56,
                          fieldWidth: 56,
                          activeFillColor:
                              Colors.black, // Fill color for active fields
                          inactiveFillColor:
                              Colors.black, // Fill color for inactive fields
                          selectedFillColor: ColorConstant
                              .bordercolor, // Selected field background color
                          inactiveColor: ColorConstant
                              .bordercolor, // Border color when inactive (light gray)
                          activeColor: ColorConstant
                              .bordercolor, // Border color when active
                          selectedColor: ColorConstant
                              .bordercolor, // Border color when selected
                        ),
                        appContext: context,
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  userProvider.isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                          color: ColorConstant.botton,
                        ))
                      : Padding(
                          padding: EdgeInsets.only(right: 24),
                          child: ElevatedButton(
                            onPressed: () async {
                              print(
                                  "Current Otp Is ====================================" +
                                      otp);
                              if (otp == OTPController.text) {
                                String deviceId = _deviceId.toString();
                                setState(() {
                                  userid;
                                });

                                // Call login function
                                Map<String, dynamic> result =
                                    await userProvider.loginUser(
                                  otp: otp,
                                  userId: userid,
                                  deviceId: widget.deviceId,
                                );

                                if (result['success']) {
                                  final data = result['data'];
                                  final token = data['token'];
                                  final name = data['name'];
                                  final phone = data['phone'];
                                  final email = data['email'];
                                  SharedPreferences preferences =
                                      await SharedPreferences.getInstance();
                                  preferences.clear();
                                  preferences.setString(
                                      'token', token.toString());
                                  preferences.setString(
                                      'name', name.toString());
                                  preferences.setString(
                                      'phone', phone.toString());
                                  preferences.setString(
                                      'email', email.toString());
                                  preferences.setString(
                                      'userid', userid.toString());

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            HomeScreen()), // Replace `NewPage` with the page you want to navigate to
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text('Login Successful!')),
                                  );
                                } else {
                                  // Show error message
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Error: ${result['error'] ?? 'Unknown Error'}',
                                      ),
                                    ),
                                  );
                                }
                              } else {
                                Fluttertoast.showToast(
                                  msg: 'OTP not matched',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity:
                                      ToastGravity.TOP, // Show toast at the top
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: ColorConstant.red,
                                  textColor: ColorConstant.white,
                                  fontSize: 16.0,
                                );
                              }

                              // _signUpProcess(context);
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  // vertical: buttonPadding,
                                  ),
                              backgroundColor: ColorConstant
                                  .botton, // Responsive vertical padding for button
                              minimumSize: Size(double.infinity,
                                  56), // Responsive button height
                            ),
                            child: Text(
                              'Countnue',
                              style: GoogleFonts.manrope(
                                  color: ColorConstant.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                  SizedBox(height: 24),
                  Padding(
                    padding: EdgeInsets.only(right: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Send code again ',
                          style: GoogleFonts.manrope(fontSize: 16),
                        ),
                        Text(
                          '${remaining!.inMinutes}:${(remaining!.inSeconds % 60).toString().padLeft(2, '0')}',
                          style: TextStyle(
                              fontSize: 18, color: ColorConstant.lightblack),
                        ),
                        if (timeout == true)
                          InkWell(
                              onTap: () async {
                                if (email != null) {
                                  var result =
                                      await userProvider.resendOtpForOldUser(
                                          email: email.toString(),
                                          userType: 'olduser');
                                  if (result['success']) {
                                    print('Login Success: ${result['data']}');
                                    final data = result['data'];
                                    // Extract fields from the map
                                    final reuserid = data['userid'];
                                    final reotp = data['otp'];
                                    final reemail = data['email'];
                                    Fluttertoast.showToast(
                                      msg: data['message'],
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity
                                          .TOP, // Show toast at the top
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: ColorConstant.green,
                                      textColor: ColorConstant.white,
                                      fontSize: 16.0,
                                    );
                                    setState(() {
                                      userid = reuserid;
                                      otp = reotp;
                                      _deviceId;
                                      email = reemail;
                                      timeout = false;
                                    });
                                    startCountdown();
                                  } else {
                                    print('Login Failed: ${result['message']}');
                                    Fluttertoast.showToast(
                                      msg: result['message'],
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity
                                          .TOP, // Show toast at the top
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: ColorConstant.red,
                                      textColor: ColorConstant.white,
                                      fontSize: 16.0,
                                    );
                                    // ScaffoldMessenger.of(context).showSnackBar(
                                    //   SnackBar(
                                    //       content: Text(result['message'])),
                                    // );
                                  }
                                }
                              },
                              child: Text(
                                "   Resend OTP",
                                style: GoogleFonts.manrope(
                                    fontSize: 16, color: ColorConstant.botton),
                              ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void startCountdown() {
    // Duration of the countdown
    const duration = Duration(minutes: 2);

    // Initialize the countdown value

    remaining = duration;
    // Function to update the countdown timer
    void updateCountdown(Timer timer) {
      if (remaining!.inSeconds > 0) {
        remaining = remaining! - Duration(seconds: 1);
        setState(() {
          remaining;

          print(
              '${remaining!.inMinutes}:${(remaining!.inSeconds % 60).toString().padLeft(2, '0')}');
        });
      } else {
        print('Countdown finished');
        setState(() {
          timeout = true;
        });
        timer.cancel(); // Stop the timer when countdown is done
      }
    }

    // Start a timer that ticks every second
    Timer.periodic(Duration(seconds: 1), updateCountdown);
  }
}
