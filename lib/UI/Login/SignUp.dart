// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:job_application/Common/Contant.dart';
import 'package:job_application/Core/GoogleLoginScreen.dart';
import 'package:job_application/Core/Provider.dart';
import 'package:job_application/Core/Provider_DeviceID.dart';
import 'package:job_application/Model/LinkedlinSignUp.dart';
import 'package:job_application/UI/Login/RegistationVerification.dart';
import 'package:provider/provider.dart';
import 'package:signin_with_linkedin/signin_with_linkedin.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();

  final NotificationHandler notificationHandler = NotificationHandler();

  _handleSign() async {
    try {
      // Attempt to sign in the user
      final GoogleSignInAccount? googleUser = await GoogleSignIn(
        scopes: ['email', 'profile'],
        hostedDomain: '',
      ).signIn();

      GoogleSignInAccount? user = await googleUser;
      if (user != null) {
        // Successfully signed in
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => GoogleLoginScreen(
                  name: user.displayName.toString(),
                  email: user.email.toString(),
                  image: user.photoUrl.toString(),
                  plateform:
                      'gmail')), // Replace `NewPage` with the page you want to navigate to
        );

        print('User signed in: ${user.displayName}');
        print('User signed in: ${user.email}');
        print('User signed in: ${user.photoUrl}');
        return user;
      } else {
        // User canceled the sign-in process
        print('Sign-in process canceled.');
        return null;
      }
    } catch (error) {
      // Handle sign-in errors
      // ignore: avoid_print
      print('Sign-in error: $error');
      return null;
    }
  }

  _signInwithLinkedlin() async {
    try {
      SignInWithLinkedIn.signIn(
        context,
        config: _linkedInConfig,
        onGetAuthToken: (data) {
          fetchLinkedInUserInfo(data.accessToken.toString());
          print('Auth token data: ${data.toJson()}');
          print("access token" + data.accessToken.toString());
        },
      );
    } catch (error) {
      print('Sign-in error: $error');
      return null;
    }
  }

  final _linkedInConfig = LinkedInConfig(
    clientId: '78lrg4eubozl2c',
    clientSecret: 'WPL_AP1.D5rZnovzW0KPe7uL.cw8JZA==',
    redirectUrl: 'https://www.linkedin.com/developers/tools/oauth/redirect',
    scope: ['openid', 'profile', 'email'],
  );

  Future<void> fetchLinkedInUserInfo(String accessToken) async {
    final url = Uri.parse('https://api.linkedin.com/v2/userinfo');

    try {
      // Making the HTTP GET request
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // Parsing the response body
        final Map<String, dynamic> data = json.decode(response.body);
        LinkedlinModel userInfo = LinkedlinModel.fromJson(data);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => GoogleLoginScreen(
                  name: userInfo.name.toString(),
                  email: userInfo.email.toString(),
                  image: null.toString(),
                  plateform:
                      'linkedlin')), // Replace `NewPage` with the page you want to navigate to
        );
        print('User Info:');
        print('Name: ${userInfo.name}');
        print('Email: ${userInfo.email}');
      } else {
        print('Error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('An error occurred: $e');
    }
  }

  @override
  void initState() {
    setupNotificationServices();
  }

  String _deviceToken = '';
//get device id

  Future<void> setupNotificationServices() async {
    // Request notification permission
    await notificationHandler.requestNotificationPermission();

    // Retrieve FCM token
    String? token = await notificationHandler.getDeviceToken(
      vapidKey:
          'BOVsVElecSRuWSXP2sX-273wdMckHwqxvRJJmrEn8PherIJnW-xmb_73PjBLQaUSD6m646bamE6zQQWzYSS23eA',
    );

    if (token != null && token.isNotEmpty) {
      updateToken(token);
    } else {
      if (kDebugMode) {
        print('FCM token not available.');
      }
    }

    // Handle token refresh
    notificationHandler.handleTokenRefresh(updateToken);
  }

  void updateToken(String token) {
    setState(() {
      _deviceToken = token;
    });

    if (kDebugMode) {
      print('FCM Token: $_deviceToken');
    }

    // Optionally, send token to your server
    // sendTokenToServer(token);
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    // Calculate font sizes based on screen size
    double titleFontSize =
        screenWidth > 600 ? 32 : 24; // Larger font on larger screens
    double bodyFontSize = screenWidth > 600 ? 18 : 16;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
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
                // Padding(
                //   padding: EdgeInsets.only(left: 24),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     crossAxisAlignment: CrossAxisAlignment.end,
                //     children: [
                //       // SizedBox(
                //       //   child: Image.asset(
                //       //     'assets/images/Logo.png', // Replace with your asset path
                //       //     width: 80,
                //       //     height: 80,
                //       //     fit: BoxFit.contain,
                //       //   ),
                //       // ),
                //       SizedBox(
                //         height: 150, // Set the desired height
                //         width: 150, // Set the desired width
                //         child: Container(
                //           decoration: BoxDecoration(
                //             image: DecorationImage(
                //               image: AssetImage("assets/images/login.png"),
                //               alignment: Alignment
                //                   .topRight, // Position the image in the top-right corner
                //               fit: BoxFit.fill, // Adjust the image fit
                //             ),
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 24),
                      Text(
                        'Sign Up',
                        style: GoogleFonts.manrope(
                            fontSize: titleFontSize, // Responsive font size
                            fontWeight: FontWeight.bold,
                            color: ColorConstant.black),
                      ),
                      SizedBox(height: 10),
                      Text.rich(
                        TextSpan(
                          text:
                              'You can easily sign up, explore and share your resume with ',
                          style: GoogleFonts.manrope(
                            fontSize: bodyFontSize, // Responsive font size
                            color: ColorConstant.lightblack, // Default color
                          ),
                          children: [
                            TextSpan(
                              text:
                                  '10M', // This is the text you want to color blue
                              style: GoogleFonts.manrope(
                                  fontSize:
                                      bodyFontSize, // Keep the same font size
                                  color: ColorConstant.botton,
                                  fontWeight:
                                      FontWeight.bold // Change this to blue
                                  ),
                            ),
                            TextSpan(
                              text: ' recruiters',
                              style: GoogleFonts.manrope(
                                fontSize:
                                    bodyFontSize, // Keep the same font size
                                color:
                                    ColorConstant.lightblack, // Default color
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          // labelText: 'Full name',
                          hintText: "Full name",
                          hintStyle: GoogleFonts.manrope(
                              color: ColorConstant.lightblack),
                          prefixIcon: Icon(
                            Icons.person_outline,
                            color: ColorConstant.lightblack,
                          ),
                          prefixStyle: GoogleFonts.manrope(
                              color: ColorConstant.bordercolor),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0),
                            // borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0),
                            borderSide: BorderSide(
                              color: ColorConstant
                                  .bordercolor, // Color when not focused
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0),
                            borderSide: BorderSide(
                              color: ColorConstant
                                  .bordercolor, // Color when focused (you can change this to any color)
                              width: 1, // Border width when focused
                            ),
                          ),
                          filled: true,
                          fillColor: ColorConstant.transparent,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          // labelText: 'Email',

                          hintText: 'Email',
                          hintStyle: GoogleFonts.manrope(
                              color: ColorConstant.lightblack, fontSize: 14),
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: ColorConstant.lightblack,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            // borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0),
                            borderSide: BorderSide(
                              color: ColorConstant
                                  .bordercolor, // Color when not focused
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0),
                            borderSide: BorderSide(
                              color: ColorConstant
                                  .bordercolor, // Color when focused (you can change this to any color)
                              width: 1, // Border width when focused
                            ),
                          ),
                          filled: true,
                          fillColor: ColorConstant.transparent,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: mobileController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          // labelText: 'Phone number',
                          hintText: "Phone number",
                          hintStyle: GoogleFonts.manrope(
                              color: ColorConstant.lightblack),
                          prefixIcon: Icon(
                            Icons.phone_outlined,
                            color: ColorConstant.lightblack,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0),
                            // borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0),
                            borderSide: BorderSide(
                              color: ColorConstant
                                  .bordercolor, // Color when not focused
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0),
                            borderSide: BorderSide(
                              color: ColorConstant
                                  .bordercolor, // Color when focused (you can change this to any color)
                              width: 1, // Border width when focused
                            ),
                          ),
                          filled: true,
                          fillColor: ColorConstant.transparent,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Mobile Number';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: userProvider.isLoading
                            ? Center(
                                child: CircularProgressIndicator(
                                color: ColorConstant.botton,
                              ))
                            : ElevatedButton(
                                onPressed: () async {
                                  String name = nameController.text.trim();
                                  String email = emailController.text.trim();
                                  String phone = mobileController.text.trim();

                                  // Call the provider function
                                  Map<String, dynamic> result =
                                      await userProvider.registerUser(
                                          name, email, phone);

                                  if (result['success']) {
                                    // Handle successful registration
                                    final data = result['data'];
                                    if (data['message'] ==
                                        'Email all ready registered.!') {
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
                                    } else {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RegistationVarification(
                                                  email:
                                                      data['email'].toString(),
                                                  otp: data['otp'].toString(),
                                                  name: data['name'].toString(),
                                                  phone:
                                                      data['phone'].toString(),
                                                  deviceId:
                                                      _deviceToken.toString(),
                                                )), // Replace `NewPage` with the page you want to navigate to
                                      );
                                    }

                                    // ScaffoldMessenger.of(context).showSnackBar(
                                    //   SnackBar(
                                    //       content:
                                    //           Text('Registration Successful!')),
                                    // );

                                    // Navigate to a new page with returned data
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) => (data: result['data']),
                                    //   ),
                                    // );
                                  } else {
                                    // Handle errors
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Error: ${result['error']}')),
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                      // vertical: 24,
                                      ),
                                  backgroundColor: ColorConstant
                                      .botton, // Responsive vertical padding for button
                                  minimumSize: Size(double.infinity,
                                      56), // Responsive button height
                                ),
                                child: Text(
                                  'Sign Up',
                                  style: GoogleFonts.manrope(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: ColorConstant.white),
                                ),
                              ),
                      ),
                      SizedBox(height: 32), // Responsive spacing
                      /* Column(
                        children: [
                          Text(
                            "Or continue with social account",
                            style: GoogleFonts.manrope(
                              fontSize: 16,
                              color: ColorConstant.lightblack,
                            ),
                          ),
                          SizedBox(height: 16), // Add some spacing
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () {
                                    _handleSign();
                                  },
                                  style: OutlinedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 16), // Vertical padding
                                    side: BorderSide(
                                      color: ColorConstant
                                          .bordercolor, // Border color
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          16), // Set the border radius here
                                    ),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/images/google.png',
                                        width: 20,
                                        height: 20,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text("Google",
                                          style: GoogleFonts.manrope(
                                            color: ColorConstant.black,
                                            fontSize: 16,
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () {
                                    _signInwithLinkedlin();
                                  },
                                  style: OutlinedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 16), // Vertical padding
                                    side: BorderSide(
                                      color: ColorConstant
                                          .bordercolor, // Border color
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          16), // Set the border radius here
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/images/linkedlin.png',
                                        width: 20,
                                        height: 20,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Linkedin",
                                        style: GoogleFonts.manrope(
                                          color: ColorConstant.black,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),*/
                      SizedBox(height: 24),
                      Center(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text.rich(
                            TextSpan(
                              text: 'Already have an account? ',
                              style: GoogleFonts.manrope(
                                  color: ColorConstant.lightblack,
                                  fontSize: 16),
                              children: [
                                TextSpan(
                                  text: 'Log In',
                                  style: GoogleFonts.manrope(
                                      color: ColorConstant.botton,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
