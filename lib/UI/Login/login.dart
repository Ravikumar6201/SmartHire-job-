// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings, avoid_unnecessary_containers, non_constant_identifier_names, avoid_print, use_build_context_synchronously, unused_element

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:job_application/Common/Contant.dart';
import 'package:job_application/Core/Provider.dart';
import 'package:job_application/Core/GoogleLoginScreen.dart';
import 'package:job_application/Core/Provider_DeviceID.dart';
import 'package:job_application/Core/loginwithlink.dart';
import 'package:job_application/Model/LinkedlinSignUp.dart';
import 'package:job_application/UI/Login/OTPVerification.dart';
import 'package:job_application/UI/Login/SignUp.dart';
import 'package:provider/provider.dart';
import 'package:signin_with_linkedin/signin_with_linkedin.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController MobileController = TextEditingController();
  final LinkedInAuth linkedInAuth = LinkedInAuth();
  final _emailController = TextEditingController();
  bool isload = true;
  final _formKey = GlobalKey<FormState>();
  final NotificationHandler notificationHandler = NotificationHandler();
  String? _deviceToken;
  @override
  void initState() {
    super.initState();
    setupNotificationServices();
    _setupPushNotifications();
  }

  Future<void> setupNotificationServices() async {
    // Request notification permission
    await notificationHandler.requestNotificationPermission();

    // Retrieve FCM token
  }

  void _setupPushNotifications() async {
    try {
      var _deviceToken = await FirebaseMessaging.instance.getToken();
      // final fcm = FirebaseMessaging.instance;
      // final settings = await fcm.requestPermission();
      // print(settings.authorizationStatus);
      // final token = await fcm.getToken();
      print('token is: $_deviceToken');
    } catch (e, stackTrace) {
      print('Error setting up push notifications: $e');
      print(stackTrace);
    }
  }

  // String? atoken;
  // void getToken() async {
  //   await FirebaseMessaging.instance.deleteToken();
  //   String? token = await FirebaseMessaging.instance.getToken();
  //   print("New Token: $token");
  //   await FirebaseMessaging.instance.getToken().then((token) {
  //     setState(() {
  //       atoken = token;
  //       print("Token is: $atoken");
  //     });
  //   }).catchError((error) {
  //     print("Error fetching token: $error");
  //   });
  // }

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

  // Email validation
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    }
    final emailRegex =
        RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
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
                      Padding(
                        padding: EdgeInsets.only(right: 24),
                        child: Row(
                          children: [
                            Text(
                              "Welcome Back!",
                              style: GoogleFonts.manrope(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: ColorConstant.black),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8),
                      Padding(
                        padding: EdgeInsets.only(right: 24),
                        child: Row(
                          children: [
                            Text(
                              "Sign in to your account",
                              style: GoogleFonts.manrope(
                                  fontSize: 16,
                                  color: ColorConstant.lightblack),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 24), // Responsive spacing
                      // Email Field
                      Padding(
                        padding: const EdgeInsets.only(right: 24.0),
                        child: TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: 'Email',
                            hintStyle: GoogleFonts.manrope(
                              color: ColorConstant.lightblack,
                              fontSize: 15,
                            ),
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              size: 30,
                              color: ColorConstant.lightblack,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
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
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 18, horizontal: 16),
                          ),
                          validator: _validateEmail,
                        ),
                      ),
                      /* Padding(
                        padding: const EdgeInsets.only(right: 24),
                        child: Center(
                          child: Container(
                            height: 56,
                            padding: EdgeInsets.symmetric(horizontal: 2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: ColorConstant.bordercolor,
                                width: 1.0,
                              ),
                            ),
                            child: Row(
                              children: [
                                CountryCodePicker(
                                  onChanged: (countryCode) {
                                    print("New Country selected: ${countryCode.code}");
                                  },
                                  initialSelection: 'IN', // Set default country code
                                  favorite: ['IN'], // Add frequently used country codes
                                  showFlag: true,
                                  showDropDownButton: true,
                                  padding: EdgeInsets.zero,
                                  hideMainText: false,
                                  textStyle: TextStyle(
                                    color: Colors.transparent,
                                    fontSize: 0,
                                  ),
                                ),
                                // Container(
                                //   width: 2,
                                //   height: 30,
                                //   color: ColorConstant.bordercolor,
                                // ),
                                // Icon(Icons.arrow_downward_outlined),
                                // VerticalDivider(
                                //   color: ColorConstant.black,
                                //   width: 1.0,
                                //   thickness: 1.0,
                                // ),
                                Expanded(
                                  child: TextFormField(
                                    // controller: mobileController,
                                    keyboardType: TextInputType.phone,
                                    decoration: InputDecoration(
                                      hintText: 'Phone number',
                                      hintStyle: GoogleFonts.manrope(
                                          color: ColorConstant.lightblack,
                                          fontSize: 15),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),*/
                      SizedBox(height: 24), // Responsive spacing
                      userProvider.isLoading
                          ? Center(
                              child: CircularProgressIndicator(
                              color: ColorConstant.botton,
                            ))
                          : Padding(
                              padding: EdgeInsets.only(right: 24.0),
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    String email = _emailController.text.trim();

                                    if (email.isNotEmpty) {
                                      var result =
                                          await userProvider.userLogin(email);

                                      if (result['success']) {
                                        // Handle success
                                        final data = result['data'];

                                        if (data['userid'] != null) {
                                          print(
                                              'Login Success: ${result['data']}');
                                          final data = result[
                                              'data']; // Assuming 'data' is a Map containing the required fields

                                          // Extract fields from the map
                                          final email = data['email'];
                                          final otp = data['otp'];
                                          final userid = data['userid'];
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    OTPValidationPage(
                                                      email: email.toString(),
                                                      otp: otp.toString(),
                                                      userid: userid.toString(),
                                                      deviceId: _deviceToken
                                                          .toString(),
                                                    )), // Replace `NewPage` with the page you want to navigate to
                                          );
                                        } else {
                                          Fluttertoast.showToast(
                                            msg: data['message'],
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity
                                                .TOP, // Show toast at the top
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: ColorConstant.red,
                                            textColor: ColorConstant.white,
                                            fontSize: 16.0,
                                          );
                                        }
                                      } else {
                                        // Handle failure
                                        print(
                                            'Login Failed: ${result['message']}');
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                              content: Text(result['message'])),
                                        );
                                      }
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Please enter your email')),
                                      );
                                    }

                                    // If the form is valid, show a success message
                                    // ScaffoldMessenger.of(context).showSnackBar(
                                    //     SnackBar(
                                    //         content: Text('Form is valid')));
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                      // vertical: screenHeight * 0.02,
                                      ),
                                  backgroundColor: ColorConstant
                                      .botton, // Responsive vertical padding for button
                                  minimumSize: Size(double.infinity,
                                      56), // Responsive button height
                                ),
                                // style: ElevatedButton.styleFrom(
                                //   shape: const StadiumBorder(),
                                //   padding: EdgeInsets.symmetric(
                                //       vertical: screenSize.height * 0.01,
                                //       horizontal: screenSize.width * 0.3),
                                //   backgroundColor: ColorConstant.botton,
                                // ),
                                child: Text(
                                  "Continue",
                                  style: GoogleFonts.manrope(
                                      fontSize: 16, // Responsive font size
                                      color: ColorConstant.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),

                      SizedBox(height: 48), // Responsive spacing
                      // Padding(
                      //   padding: EdgeInsets.only(right: 24.0),
                      //   child: ElevatedButton.icon(
                      //     onPressed: () async {

                      //     },
                      //     icon: Icon(Icons.account_circle),
                      //     label: Text('Sign in with Google'),
                      //   ),
                      // ),
                      // SizedBox(height: 32), // Responsive spacing
                      // Padding(
                      //   padding: EdgeInsets.only(right: 24.0),
                      //   child: ElevatedButton.icon(
                      //     onPressed: () async {

                      //     },
                      //     icon: Icon(Icons.account_circle),
                      //     label: Text('Sign in with Linkedlin'),
                      //   ),
                      // ),
                      SizedBox(height: 48), // Responsive spacing
                      /*   Padding(
                        padding: const EdgeInsets.only(right: 16, top: 48),
                        child: Column(
                          children: [
                            Text(
                              "Or continue with social account",
                              style: GoogleFonts.manrope(
                                fontSize: 16,
                                color: ColorConstant.lightblack,
                              ),
                            ),
                            SizedBox(height: 16), // Add some spacing
                           
                            
                            //this google and linklin
                            
                            
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                        ),
                      )*/

                      /* Padding(
                        padding: EdgeInsets.only(right: 24.0),
                        child: _user == null
                            ? ElevatedButton.icon(
                                onPressed: () {},
                                icon: Icon(Icons.account_circle),
                                label: Text('Sign in with Google'),
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(_user!.photoURL ?? ''),
                                    radius: 50,
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    _user!.displayName ?? 'No Name',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  SizedBox(height: 5),
                                  Text(_user!.email ?? ''),
                                  SizedBox(height: 20),
                                  ElevatedButton.icon(
                                    onPressed: _handleSignOut,
                                    icon: Icon(Icons.logout),
                                    label: Text('Sign Out'),
                                  ),
                                ],
                              ),
                  
                        // ElevatedButton(
                        //   onPressed: () {
                        //     Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (context) =>
                        //               SignInScreen()), // Replace `NewPage` with the page you want to navigate to
                        //     );
                        //     // Provider.of<GoggleSignInController>(context, listen: false);
                        //   },
                        //   style: ElevatedButton.styleFrom(
                        //     padding: EdgeInsets.symmetric(
                        //         // vertical: screenHeight * 0.02,
                        //         ),
                        //     backgroundColor: ColorConstant
                        //         .white, // Responsive vertical padding for button
                        //     minimumSize:
                        //         Size(double.infinity, 56), // Responsive button height
                        //   ),
                        //   child: Row(
                        //     children: [
                        //       Padding(
                        //         padding: const EdgeInsets.only(left: 16.0, right: 16),
                        //         child: Image.asset(
                        //           "assets/images/google.png",
                        //           height: 40,
                        //           width: 40,
                        //         ),
                        //       ),
                        //       Text(
                        //         "login with google",
                        //         style: GoogleFonts.manrope(
                        //             fontSize: 16, // Responsive font size
                        //             color: ColorConstant.black,
                        //             fontWeight: FontWeight.bold),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          linkedInAuth.loginWithLinkedIn();
                        },
                        child: Text("Login with LinkedIn"),
                      ),
                  */
                      // Spacer(), // Adds flexible space above the buttons
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don’t have an account? ",
                    style: GoogleFonts.manrope(
                      fontSize: 16,
                      color: ColorConstant.lightblack,
                    )),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SignUpScreen()), // Replace `NewPage` with the page you want to navigate to
                    );
                  },
                  child: Text("Sign Up",
                      style: GoogleFonts.manrope(
                        fontSize: 16,
                        color: ColorConstant.botton,
                      )),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
        ],
      )),
    );
  }

  // Helper function to determine max length of phone number by country
  int _getPhoneNumberLength(country) {
    // Define custom lengths for countries, e.g., US (10), UK (10), India (10)
    Map<String, int> phoneLengths = {
      "US": 11,
      "IN": 10,
      "UK": 10,
      "CA": 9,
      // Add other countries here if needed
    };
    return phoneLengths[country.countryCode] ??
        10; // Default to 10 if not specified
  }
}
