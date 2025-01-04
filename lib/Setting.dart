// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_element, use_build_context_synchronously, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_application/Common/Contant.dart';
import 'package:job_application/Common/Deletepopup.dart';
import 'package:job_application/Common/Url.dart';
import 'package:job_application/Core/Provider.dart';
import 'package:job_application/UI/FAQ/FAQs.dart';
import 'package:job_application/UI/AboutUs/AboutUs.dart';
import 'package:job_application/UI/ContactUs/ContactUs.dart';
import 'package:job_application/UI/Home/HomeScreen.dart';
import 'package:job_application/UI/Login/login.dart';
import 'package:job_application/UI/Notifications/notifications.dart';
import 'package:job_application/UI/PrivecyPolice/PrivecyPolice.dart';
import 'package:job_application/UI/Profile/AddSkill.dart';
import 'package:job_application/UI/Profile/Addlanguage.dart';
import 'package:job_application/UI/Profile/EducationScreen.dart';
import 'package:job_application/UI/Profile/ExprienceScreen.dart';
import 'package:job_application/UI/Profile/Personalinformation.dart';
import 'package:job_application/UI/Profile/Profile.dart';
import 'package:job_application/UI/Profile/ResumeScreen.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final List<Map<String, String>> educationList = [
    {
      "name": "Profile",
      "image": "assets/images/usericon.png",
    },
    {
      "name": "About",
      "image": "assets/images/abouticon.png",
    },
    {
      "name": "Help",
      "image": "assets/images/helpicon.png",
    },
    {
      "name": "Share App",
      "image": "assets/images/shareicon.png",
    },
    {
      "name": "Log Out",
      "image": "assets/images/logouticon.png",
    },
  ];

  @override
  void initState() {
    super.initState();
    UserProfile();
  }

  String? Token;
  String? userID;
  UserProfile() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Token = preferences.getString('token');
    userID = preferences.getString('userid');
    setState(() {
      Token;
      userID;
    });
    print(Token);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //get profile
      context.read<UserProvider>().fetchUserProfile(
            userID.toString(), // User ID
            Token.toString(),
          );
    });
  }

  String truncateString(String text) {
    if (text.length > 22) {
      return text.substring(0, 22) + '...';
    }
    return text;
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UserProvider>();
    final userProfile = provider.userProfile;
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings',
            style: GoogleFonts.manrope(
                color: ColorConstant.black,
                fontSize: 16,
                fontWeight: FontWeight.bold)),
        leading: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      HomeScreen()), // Replace `NewPage` with the page you want to navigate to
            );
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
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        NotificationScreen()), // Replace `NewPage` with the page you want to navigate to
              );
            },
            child: Padding(
                padding: EdgeInsets.only(right: 20),
                child: Image.asset(
                  'assets/images/bell.png',
                  height: 30,
                  width: 30,
                  fit: BoxFit.contain,
                )),
          )
        ],
      ),
      body: provider.isLoading
          ? Center(
              child: CircularProgressIndicator(
              color: ColorConstant.botton,
            ))
          : SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Container(
                    decoration: BoxDecoration(
                      color: ColorConstant.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          Card(
                            elevation: 02,
                            color: ColorConstant.white,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    color: ColorConstant.white,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        if (userProfile['profileimg'] != null)
                                          CircleAvatar(
                                            radius: 25,
                                            backgroundImage: NetworkImage(
                                                "${ApiConstants.baseUrl}"
                                                "${userProfile['profileimg']}"),
                                            //   backgroundImage: NetworkImage(
                                            //       'https://cdn.pixabay.com/photo/2015/03/03/18/58/girl-657753_1280.jpg'),
                                          ),
                                        if (userProfile['profileimg'] == null)
                                          CircleAvatar(
                                            radius: 25,
                                            backgroundImage: AssetImage(
                                                "assets/images/settingimg/user-profile.jpg"),
                                            //   backgroundImage: NetworkImage(
                                            //       'https://cdn.pixabay.com/photo/2015/03/03/18/58/girl-657753_1280.jpg'),
                                          ),
                                      ],
                                    ),
                                  ),
                                  // Image.asset(
                                  //   'assets/images/usericon.png',
                                  //   height: 50,
                                  //   width: 50,
                                  //   fit: BoxFit.contain,
                                  // ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${truncateString(userProfile['name'] ?? '')}',
                                        style: GoogleFonts.manrope(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: ColorConstant.black,
                                        ),
                                      ),
                                      Text(
                                        truncateString(
                                            userProfile['jobtitle'] ?? ''),
                                        style: GoogleFonts.manrope(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w300,
                                          color: ColorConstant.lightblack,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Card(
                            elevation: 02,
                            color: ColorConstant.white,
                            child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        // if (index == 0) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                PersonalinformationScreen(),
                                          ),
                                        );
                                      },
                                      child: Row(children: [
                                        // SizedBox(width: 12),
                                        Container(
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 1,
                                                  color: ColorConstant
                                                      .bordercolor),
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color: ColorConstant.bordercolor),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Center(
                                              child: Image.asset(
                                                "assets/images/usericon.png",
                                                // education["image"]!,
                                                height: 25,
                                                width: 25,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 16),
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Personal information",
                                                style: GoogleFonts.manrope(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: ColorConstant.black,
                                                ),
                                              ),
                                              Icon(
                                                Icons
                                                    .arrow_forward_ios_outlined,
                                                size: 14,
                                                color: ColorConstant.arrow,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ]),
                                    ),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        // if (index == 0) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                EducationScreen(),
                                          ),
                                        );
                                      },
                                      child: Row(children: [
                                        // SizedBox(width: 12),
                                        Container(
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 1,
                                                  color: ColorConstant
                                                      .bordercolor),
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color: ColorConstant.bordercolor),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Center(
                                              child: Image.asset(
                                                "assets/images/settingimg/document-validation.png",
                                                // education["image"]!,
                                                height: 25,
                                                width: 25,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 16),
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Education",
                                                style: GoogleFonts.manrope(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: ColorConstant.black,
                                                ),
                                              ),
                                              Icon(
                                                Icons
                                                    .arrow_forward_ios_outlined,
                                                size: 14,
                                                color: ColorConstant.arrow,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ]),
                                    ),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        // if (index == 0) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ExprienceScreen(),
                                          ),
                                        );
                                      },
                                      child: Row(children: [
                                        // SizedBox(width: 12),
                                        Container(
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 1,
                                                  color: ColorConstant
                                                      .bordercolor),
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color: ColorConstant.bordercolor),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Center(
                                              child: Image.asset(
                                                "assets/images/settingimg/briefcase-03.png",
                                                // education["image"]!,
                                                height: 25,
                                                width: 25,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 16),
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Experience",
                                                style: GoogleFonts.manrope(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: ColorConstant.black,
                                                ),
                                              ),
                                              Icon(
                                                Icons
                                                    .arrow_forward_ios_outlined,
                                                size: 14,
                                                color: ColorConstant.arrow,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ]),
                                    ),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        // if (index == 0) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ResumeScreen(),
                                          ),
                                        );
                                      },
                                      child: Row(children: [
                                        // SizedBox(width: 12),
                                        Container(
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 1,
                                                  color: ColorConstant
                                                      .bordercolor),
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color: ColorConstant.bordercolor),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Center(
                                              child: Image.asset(
                                                "assets/images/settingimg/credit-card.png",
                                                // education["image"]!,
                                                height: 25,
                                                width: 25,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 16),
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Resume",
                                                style: GoogleFonts.manrope(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: ColorConstant.black,
                                                ),
                                              ),
                                              Icon(
                                                Icons
                                                    .arrow_forward_ios_outlined,
                                                size: 14,
                                                color: ColorConstant.arrow,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ]),
                                    ),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        // if (index == 0) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                AddSkillScreen(),
                                          ),
                                        );
                                      },
                                      child: Row(children: [
                                        // SizedBox(width: 12),
                                        Container(
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 1,
                                                  color: ColorConstant
                                                      .bordercolor),
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color: ColorConstant.bordercolor),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Center(
                                              child: Image.asset(
                                                "assets/images/settingimg/document-attachment.png",
                                                // education["image"]!,
                                                height: 25,
                                                width: 25,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 16),
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Skills",
                                                style: GoogleFonts.manrope(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: ColorConstant.black,
                                                ),
                                              ),
                                              Icon(
                                                Icons
                                                    .arrow_forward_ios_outlined,
                                                size: 14,
                                                color: ColorConstant.arrow,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ]),
                                    ),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        // if (index == 0) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                AddLaguageScreen(),
                                          ),
                                        );
                                      },
                                      child: Row(children: [
                                        // SizedBox(width: 12),
                                        Container(
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 1,
                                                  color: ColorConstant
                                                      .bordercolor),
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color: ColorConstant.bordercolor),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Center(
                                              child: Image.asset(
                                                "assets/images/settingimg/document-attachment.png",
                                                // education["image"]!,
                                                height: 25,
                                                width: 25,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 16),
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Language",
                                                style: GoogleFonts.manrope(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: ColorConstant.black,
                                                ),
                                              ),
                                              Icon(
                                                Icons
                                                    .arrow_forward_ios_outlined,
                                                size: 14,
                                                color: ColorConstant.arrow,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ]),
                                    ),
                                  ],
                                )),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          // Card(
                          //   color: ColorConstant.white,
                          //   child: Padding(
                          //       padding: const EdgeInsets.all(16.0),
                          //       child: Column(
                          //         children: [
                          //           Row(children: [
                          //             // SizedBox(width: 12),
                          //             Container(
                          //               height: 30,
                          //               width: 30,
                          //               decoration: BoxDecoration(
                          //                   border: Border.all(
                          //                       width: 1,
                          //                       color: ColorConstant.iconbg),
                          //                   borderRadius: BorderRadius.circular(50),
                          //                   color: ColorConstant.bordercolor),
                          //               child: Padding(
                          //                 padding: const EdgeInsets.all(5.0),
                          //                 child: Center(
                          //                   child: Image.asset(
                          //                     "assets/images/settingimg/contact-02.png",
                          //                     // education["image"]!,
                          //                     height: 18,
                          //                     width: 18,
                          //                     fit: BoxFit.contain,
                          //                   ),
                          //                 ),
                          //               ),
                          //             ),
                          //             SizedBox(width: 16),
                          //             Expanded(
                          //               child: Row(
                          //                 mainAxisAlignment:
                          //                     MainAxisAlignment.spaceBetween,
                          //                 children: [
                          //                   Text(
                          //                     "Emergency Contact",
                          //                     style: GoogleFonts.manrope(
                          //                       fontSize: 14,
                          //                       fontWeight: FontWeight.w500,
                          //                       color: ColorConstant.black,
                          //                     ),
                          //                   ),
                          //                   InkWell(
                          //                     onTap: () {
                          //                       // if (index == 0) {
                          //                       Navigator.push(
                          //                         context,
                          //                         MaterialPageRoute(
                          //                           builder: (context) =>
                          //                               ProfileScreen(),
                          //                         ),
                          //                       );
                          //                     },
                          //                     child: Icon(
                          //                       Icons.arrow_forward_ios_outlined,
                          //                       size: 14,
                          //                       color: ColorConstant.arrow,
                          //                     ),
                          //                   ),
                          //                 ],
                          //               ),
                          //             ),
                          //           ]),
                          //           SizedBox(
                          //             height: 16,
                          //           ),
                          //           Row(children: [
                          //             // SizedBox(width: 12),
                          //             Container(
                          //               height: 30,
                          //               width: 30,
                          //               decoration: BoxDecoration(
                          //                   border: Border.all(
                          //                       width: 1,
                          //                       color: ColorConstant.iconbg),
                          //                   borderRadius: BorderRadius.circular(50),
                          //                   color: ColorConstant.bordercolor),
                          //               child: Padding(
                          //                 padding: const EdgeInsets.all(5.0),
                          //                 child: Center(
                          //                   child: Image.asset(
                          //                     "assets/images/settingimg/credit-card.png",
                          //                     // education["image"]!,
                          //                     height: 25,
                          //                     width: 25,
                          //                     fit: BoxFit.contain,
                          //                   ),
                          //                 ),
                          //               ),
                          //             ),
                          //             SizedBox(width: 16),
                          //             Expanded(
                          //               child: Row(
                          //                 mainAxisAlignment:
                          //                     MainAxisAlignment.spaceBetween,
                          //                 children: [
                          //                   Text(
                          //                     "Bank Details (Optional)",
                          //                     style: GoogleFonts.manrope(
                          //                       fontSize: 14,
                          //                       fontWeight: FontWeight.w500,
                          //                       color: ColorConstant.black,
                          //                     ),
                          //                   ),
                          //                   InkWell(
                          //                     onTap: () {
                          //                       // if (index == 0) {
                          //                       Navigator.push(
                          //                         context,
                          //                         MaterialPageRoute(
                          //                           builder: (context) =>
                          //                               ProfileScreen(),
                          //                         ),
                          //                       );
                          //                     },
                          //                     child: Icon(
                          //                       Icons.arrow_forward_ios_outlined,
                          //                       size: 14,
                          //                       color: ColorConstant.arrow,
                          //                     ),
                          //                   ),
                          //                 ],
                          //               ),
                          //             ),
                          //           ]),
                          //           SizedBox(
                          //             height: 16,
                          //           ),
                          //           Row(children: [
                          //             // SizedBox(width: 12),
                          //             Container(
                          //               height: 30,
                          //               width: 30,
                          //               decoration: BoxDecoration(
                          //                   border: Border.all(
                          //                       width: 1,
                          //                       color: ColorConstant.iconbg),
                          //                   borderRadius: BorderRadius.circular(50),
                          //                   color: ColorConstant.bordercolor),
                          //               child: Padding(
                          //                 padding: const EdgeInsets.all(5.0),
                          //                 child: Center(
                          //                   child: Image.asset(
                          //                     "assets/images/settingimg/document-validation.png",
                          //                     // education["image"]!,
                          //                     height: 25,
                          //                     width: 25,
                          //                     fit: BoxFit.contain,
                          //                   ),
                          //                 ),
                          //               ),
                          //             ),
                          //             SizedBox(width: 16),
                          //             Expanded(
                          //               child: Row(
                          //                 mainAxisAlignment:
                          //                     MainAxisAlignment.spaceBetween,
                          //                 children: [
                          //                   Text(
                          //                     "Documents",
                          //                     style: GoogleFonts.manrope(
                          //                       fontSize: 14,
                          //                       fontWeight: FontWeight.w500,
                          //                       color: ColorConstant.black,
                          //                     ),
                          //                   ),
                          //                   InkWell(
                          //                     onTap: () {
                          //                       // if (index == 0) {
                          //                       Navigator.push(
                          //                         context,
                          //                         MaterialPageRoute(
                          //                           builder: (context) =>
                          //                               ProfileScreen(),
                          //                         ),
                          //                       );
                          //                     },
                          //                     child: Icon(
                          //                       Icons.arrow_forward_ios_outlined,
                          //                       size: 14,
                          //                       color: ColorConstant.arrow,
                          //                     ),
                          //                   ),
                          //                 ],
                          //               ),
                          //             ),
                          //           ]),
                          //           SizedBox(
                          //             height: 16,
                          //           ),
                          //           Row(children: [
                          //             // SizedBox(width: 12),
                          //             Container(
                          //               height: 30,
                          //               width: 30,
                          //               decoration: BoxDecoration(
                          //                   border: Border.all(
                          //                       width: 1,
                          //                       color: ColorConstant.iconbg),
                          //                   borderRadius: BorderRadius.circular(50),
                          //                   color: ColorConstant.bordercolor),
                          //               child: Padding(
                          //                 padding: const EdgeInsets.all(5.0),
                          //                 child: Center(
                          //                   child: Image.asset(
                          //                     "assets/images/settingimg/document-attachment.png",
                          //                     // education["image"]!,
                          //                     height: 25,
                          //                     width: 25,
                          //                     fit: BoxFit.contain,
                          //                   ),
                          //                 ),
                          //               ),
                          //             ),
                          //             SizedBox(width: 16),
                          //             Expanded(
                          //               child: Row(
                          //                 mainAxisAlignment:
                          //                     MainAxisAlignment.spaceBetween,
                          //                 children: [
                          //                   Text(
                          //                     "Skills & Language",
                          //                     style: GoogleFonts.manrope(
                          //                       fontSize: 14,
                          //                       fontWeight: FontWeight.w500,
                          //                       color: ColorConstant.black,
                          //                     ),
                          //                   ),
                          //                   InkWell(
                          //                     onTap: () {
                          //                       // if (index == 0) {
                          //                       Navigator.push(
                          //                         context,
                          //                         MaterialPageRoute(
                          //                           builder: (context) =>
                          //                               ProfileScreen(),
                          //                         ),
                          //                       );
                          //                     },
                          //                     child: Icon(
                          //                       Icons.arrow_forward_ios_outlined,
                          //                       size: 14,
                          //                       color: ColorConstant.arrow,
                          //                     ),
                          //                   ),
                          //                 ],
                          //               ),
                          //             ),
                          //           ]),
                          //         ],
                          //       )),
                          // ),
                          // SizedBox(
                          //   height: 12,
                          // ),
                          Card(
                            elevation: 02,
                            color: ColorConstant.white,
                            child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        // if (index == 0) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                PrivecyPoliceScreen(),
                                          ),
                                        );
                                      },
                                      child: Row(children: [
                                        // SizedBox(width: 12),
                                        Container(
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 1,
                                                  color: ColorConstant.iconbg),
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color: ColorConstant.bordercolor),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Center(
                                              child: Image.asset(
                                                "assets/images/settingimg/help-circle.png",
                                                // education["image"]!,
                                                height: 25,
                                                width: 25,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 16),
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Privecy Policy",
                                                style: GoogleFonts.manrope(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: ColorConstant.black,
                                                ),
                                              ),
                                              Icon(
                                                Icons
                                                    .arrow_forward_ios_outlined,
                                                size: 14,
                                                color: ColorConstant.arrow,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ]),
                                    ),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    InkWell(
                                      onTap: () =>
                                          showClearNotificationsPopup(context),
                                      child: Row(children: [
                                        // SizedBox(width: 12),
                                        Container(
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 1,
                                                  color: ColorConstant
                                                      .bordercolor),
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color: ColorConstant.bordercolor),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Center(
                                              child: Image.asset(
                                                "assets/images/settingimg/logout-05.png",
                                                // education["image"]!,
                                                height: 25,
                                                width: 25,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 16),
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Log Out",
                                                style: GoogleFonts.manrope(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: ColorConstant.red,
                                                ),
                                              ),
                                              Icon(
                                                Icons
                                                    .arrow_forward_ios_outlined,
                                                size: 14,
                                                color: ColorConstant.arrow,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ]),
                                    ),
                                  ],
                                )),
                          ),

                          // Expanded(
                          //   child: Column(
                          //     children: [
                          //       Column(
                          //         mainAxisAlignment: MainAxisAlignment.start,
                          //         crossAxisAlignment: CrossAxisAlignment.start,
                          //         children: [
                          //           Container(
                          //             width: double.infinity,
                          //             decoration: BoxDecoration(
                          //                 border: Border.all(
                          //                     color: ColorConstant.bordercolor),
                          //                 borderRadius: BorderRadius.circular(12)),
                          //             child: Column(
                          //               crossAxisAlignment: CrossAxisAlignment.center,
                          //               children: [
                          //                 SizedBox(height: 12),
                          //                 Row(
                          //                   children: [
                          //                     SizedBox(width: 12),
                          //                     Container(
                          //                       height: 35,
                          //                       width: 35,
                          //                       decoration: BoxDecoration(
                          //                           border: Border.all(
                          //                               width: 2,
                          //                               color:
                          //                                   ColorConstant.bordercolor),
                          //                           borderRadius:
                          //                               BorderRadius.circular(50),
                          //                           color: ColorConstant.bordercolor),
                          //                       child: Center(
                          //                         child: Image.asset(
                          //                           "assets/images/usericon.png",
                          //                           // education["image"]!,
                          //                           height: 25,
                          //                           width: 25,
                          //                           fit: BoxFit.contain,
                          //                         ),
                          //                       ),
                          //                     ),
                          //                     SizedBox(width: 18),
                          //                     Expanded(
                          //                       child: Row(
                          //                         mainAxisAlignment:
                          //                             MainAxisAlignment.spaceBetween,
                          //                         children: [
                          //                           Text(
                          //                             "Profile",
                          //                             style: GoogleFonts.manrope(
                          //                               fontSize: 15,
                          //                               fontWeight: FontWeight.bold,
                          //                               color: ColorConstant.black,
                          //                             ),
                          //                           ),
                          //                           Padding(
                          //                             padding: const EdgeInsets.only(
                          //                                 right: 12.0),
                          //                             child: InkWell(
                          //                               onTap: () {
                          //                                 // if (index == 0) {
                          //                                 Navigator.push(
                          //                                   context,
                          //                                   MaterialPageRoute(
                          //                                     builder: (context) =>
                          //                                         ProfileScreen(),
                          //                                   ),
                          //                                 );
                          //                               },
                          //                               child: Icon(
                          //                                 Icons
                          //                                     .arrow_forward_ios_outlined,
                          //                                 size: 20,
                          //                                 color: ColorConstant.arrow,
                          //                               ),
                          //                             ),
                          //                           ),
                          //                         ],
                          //                       ),
                          //                     ),
                          //                   ],
                          //                 ),
                          //                 SizedBox(height: 12),
                          //               ],
                          //             ),
                          //           ),
                          //           SizedBox(height: 12),
                          //           Container(
                          //             width: double.infinity,
                          //             decoration: BoxDecoration(
                          //                 border: Border.all(
                          //                     color: ColorConstant.bordercolor),
                          //                 borderRadius: BorderRadius.circular(12)),
                          //             child: Column(
                          //               crossAxisAlignment: CrossAxisAlignment.center,
                          //               children: [
                          //                 SizedBox(height: 12),
                          //                 Row(
                          //                   children: [
                          //                     SizedBox(width: 12),
                          //                     Container(
                          //                       height: 35,
                          //                       width: 35,
                          //                       decoration: BoxDecoration(
                          //                           border: Border.all(
                          //                               width: 2,
                          //                               color:
                          //                                   ColorConstant.bordercolor),
                          //                           borderRadius:
                          //                               BorderRadius.circular(50),
                          //                           color: ColorConstant.bordercolor),
                          //                       child: Center(
                          //                         child: Image.asset(
                          //                           "assets/images/abouticon.png",
                          //                           // education["image"]!,
                          //                           height: 25,
                          //                           width: 25,
                          //                           fit: BoxFit.contain,
                          //                         ),
                          //                       ),
                          //                     ),
                          //                     SizedBox(width: 18),
                          //                     Expanded(
                          //                       child: Row(
                          //                         mainAxisAlignment:
                          //                             MainAxisAlignment.spaceBetween,
                          //                         children: [
                          //                           Text(
                          //                             "About",
                          //                             style: GoogleFonts.manrope(
                          //                               fontSize: 14,
                          //                               fontWeight: FontWeight.bold,
                          //                               color: ColorConstant.black,
                          //                             ),
                          //                           ),
                          //                           Padding(
                          //                             padding: const EdgeInsets.only(
                          //                                 right: 12.0),
                          //                             child: InkWell(
                          //                               onTap: () {
                          //                                 // if (index == 0) {
                          //                                 Navigator.push(
                          //                                   context,
                          //                                   MaterialPageRoute(
                          //                                     builder: (context) =>
                          //                                         AboutUsScreen(),
                          //                                   ),
                          //                                 );
                          //                               },
                          //                               child: Icon(
                          //                                 Icons
                          //                                     .arrow_forward_ios_outlined,
                          //                                 size: 20,
                          //                                 color: ColorConstant.arrow,
                          //                               ),
                          //                             ),
                          //                           ),
                          //                         ],
                          //                       ),
                          //                     ),
                          //                   ],
                          //                 ),
                          //                 SizedBox(height: 12),
                          //               ],
                          //             ),
                          //           ),
                          //           SizedBox(height: 12),
                          //           Container(
                          //             width: double.infinity,
                          //             decoration: BoxDecoration(
                          //                 border: Border.all(
                          //                     color: ColorConstant.bordercolor),
                          //                 borderRadius: BorderRadius.circular(12)),
                          //             child: Column(
                          //               crossAxisAlignment: CrossAxisAlignment.center,
                          //               children: [
                          //                 SizedBox(height: 12),
                          //                 //faq
                          //                 Row(
                          //                   children: [
                          //                     SizedBox(width: 12),
                          //                     Container(
                          //                       height: 35,
                          //                       width: 35,
                          //                       decoration: BoxDecoration(
                          //                           border: Border.all(
                          //                               width: 2,
                          //                               color:
                          //                                   ColorConstant.bordercolor),
                          //                           borderRadius:
                          //                               BorderRadius.circular(50),
                          //                           color: ColorConstant.bordercolor),
                          //                       child: Center(
                          //                         child: Image.asset(
                          //                           "assets/images/helpicon.png",
                          //                           // education["image"]!,
                          //                           height: 25,
                          //                           width: 25,
                          //                           fit: BoxFit.contain,
                          //                         ),
                          //                       ),
                          //                     ),
                          //                     SizedBox(width: 18),
                          //                     Expanded(
                          //                       child: Row(
                          //                         mainAxisAlignment:
                          //                             MainAxisAlignment.spaceBetween,
                          //                         children: [
                          //                           Text(
                          //                             "Help",
                          //                             style: GoogleFonts.manrope(
                          //                               fontSize: 15,
                          //                               fontWeight: FontWeight.bold,
                          //                               color: ColorConstant.black,
                          //                             ),
                          //                           ),
                          //                           Padding(
                          //                             padding: const EdgeInsets.only(
                          //                                 right: 12.0),
                          //                             child: InkWell(
                          //                               onTap: () {
                          //                                 // if (index == 0) {
                          //                                 Navigator.push(
                          //                                   context,
                          //                                   MaterialPageRoute(
                          //                                     builder: (context) =>
                          //                                         FAQsScreen(),
                          //                                   ),
                          //                                 );
                          //                               },
                          //                               child: Icon(
                          //                                 Icons
                          //                                     .arrow_forward_ios_outlined,
                          //                                 size: 20,
                          //                                 color: ColorConstant.arrow,
                          //                               ),
                          //                             ),
                          //                           ),
                          //                         ],
                          //                       ),
                          //                     ),
                          //                   ],
                          //                 ),
                          //                 SizedBox(height: 12),
                          //               ],
                          //             ),
                          //           ),
                          //           SizedBox(height: 12),
                          //           Container(
                          //             width: double.infinity,
                          //             decoration: BoxDecoration(
                          //                 border: Border.all(
                          //                     color: ColorConstant.bordercolor),
                          //                 borderRadius: BorderRadius.circular(12)),
                          //             child: Column(
                          //               crossAxisAlignment: CrossAxisAlignment.center,
                          //               children: [
                          //                 SizedBox(height: 12),
                          //                 Row(
                          //                   children: [
                          //                     SizedBox(width: 12),
                          //                     Container(
                          //                       height: 35,
                          //                       width: 35,
                          //                       decoration: BoxDecoration(
                          //                           border: Border.all(
                          //                               width: 2,
                          //                               color:
                          //                                   ColorConstant.bordercolor),
                          //                           borderRadius:
                          //                               BorderRadius.circular(50),
                          //                           color: ColorConstant.bordercolor),
                          //                       child: Center(
                          //                         child: Image.asset(
                          //                           "assets/images/usericon.png",
                          //                           // education["image"]!,
                          //                           height: 25,
                          //                           width: 25,
                          //                           fit: BoxFit.contain,
                          //                         ),
                          //                       ),
                          //                     ),
                          //                     SizedBox(width: 18),
                          //                     Expanded(
                          //                       child: Row(
                          //                         mainAxisAlignment:
                          //                             MainAxisAlignment.spaceBetween,
                          //                         children: [
                          //                           Text(
                          //                             "Profile",
                          //                             style: GoogleFonts.manrope(
                          //                               fontSize: 15,
                          //                               fontWeight: FontWeight.bold,
                          //                               color: ColorConstant.black,
                          //                             ),
                          //                           ),
                          //                           Padding(
                          //                             padding: const EdgeInsets.only(
                          //                                 right: 12.0),
                          //                             child: InkWell(
                          //                               onTap: () {
                          //                                 // if (index == 0) {
                          //                                 Navigator.push(
                          //                                   context,
                          //                                   MaterialPageRoute(
                          //                                     builder: (context) =>
                          //                                         ProfileScreen(),
                          //                                   ),
                          //                                 );
                          //                               },
                          //                               child: Icon(
                          //                                 Icons
                          //                                     .arrow_forward_ios_outlined,
                          //                                 size: 20,
                          //                                 color: ColorConstant.arrow,
                          //                               ),
                          //                             ),
                          //                           ),
                          //                         ],
                          //                       ),
                          //                     ),
                          //                   ],
                          //                 ),
                          //                 SizedBox(height: 12),
                          //               ],
                          //             ),
                          //           ),
                          //           SizedBox(height: 12),
                          //           Container(
                          //             width: double.infinity,
                          //             decoration: BoxDecoration(
                          //                 border: Border.all(
                          //                     color: ColorConstant.bordercolor),
                          //                 borderRadius: BorderRadius.circular(12)),
                          //             child: Column(
                          //               crossAxisAlignment: CrossAxisAlignment.center,
                          //               children: [
                          //                 SizedBox(height: 12),
                          //                 //share
                          //                 Row(
                          //                   children: [
                          //                     SizedBox(width: 12),
                          //                     Container(
                          //                       height: 35,
                          //                       width: 35,
                          //                       decoration: BoxDecoration(
                          //                           border: Border.all(
                          //                               width: 2,
                          //                               color:
                          //                                   ColorConstant.bordercolor),
                          //                           borderRadius:
                          //                               BorderRadius.circular(50),
                          //                           color: ColorConstant.bordercolor),
                          //                       child: Center(
                          //                         child: Image.asset(
                          //                           "assets/images/shareicon.png",
                          //                           // education["image"]!,
                          //                           height: 25,
                          //                           width: 25,
                          //                           fit: BoxFit.contain,
                          //                         ),
                          //                       ),
                          //                     ),
                          //                     SizedBox(width: 18),
                          //                     Expanded(
                          //                       child: Row(
                          //                         mainAxisAlignment:
                          //                             MainAxisAlignment.spaceBetween,
                          //                         children: [
                          //                           Text(
                          //                             "Share",
                          //                             style: GoogleFonts.manrope(
                          //                               fontSize: 15,
                          //                               fontWeight: FontWeight.bold,
                          //                               color: ColorConstant.black,
                          //                             ),
                          //                           ),
                          //                           Padding(
                          //                             padding: const EdgeInsets.only(
                          //                                 right: 12.0),
                          //                             child: InkWell(
                          //                               onTap: () {
                          //                                 shareAppLink();
                          //                               },
                          //                               child: Icon(
                          //                                 Icons
                          //                                     .arrow_forward_ios_outlined,
                          //                                 size: 20,
                          //                                 color: ColorConstant.arrow,
                          //                               ),
                          //                             ),
                          //                           ),
                          //                         ],
                          //                       ),
                          //                     ),
                          //                   ],
                          //                 ),
                          //                 SizedBox(height: 12),
                          //               ],
                          //             ),
                          //           ),
                          //           SizedBox(height: 12),
                          //           Container(
                          //             width: double.infinity,
                          //             decoration: BoxDecoration(
                          //                 border: Border.all(
                          //                     color: ColorConstant.bordercolor),
                          //                 borderRadius: BorderRadius.circular(12)),
                          //             child: Column(
                          //               crossAxisAlignment: CrossAxisAlignment.center,
                          //               children: [
                          //                 SizedBox(height: 12),
                          //                 //logout
                          //                 Row(
                          //                   children: [
                          //                     SizedBox(width: 12),
                          //                     Container(
                          //                       height: 35,
                          //                       width: 35,
                          //                       decoration: BoxDecoration(
                          //                           border: Border.all(
                          //                               width: 2,
                          //                               color:
                          //                                   ColorConstant.bordercolor),
                          //                           borderRadius:
                          //                               BorderRadius.circular(50),
                          //                           color: ColorConstant.bordercolor),
                          //                       child: Center(
                          //                         child: Image.asset(
                          //                           "assets/images/logouticon.png",
                          //                           // education["image"]!,
                          //                           height: 25,
                          //                           width: 25,
                          //                           fit: BoxFit.contain,
                          //                         ),
                          //                       ),
                          //                     ),
                          //                     SizedBox(width: 18),
                          //                     Expanded(
                          //                       child: Row(
                          //                         mainAxisAlignment:
                          //                             MainAxisAlignment.spaceBetween,
                          //                         children: [
                          //                           Text(
                          //                             "Log Out",
                          //                             style: GoogleFonts.manrope(
                          //                               fontSize: 15,
                          //                               fontWeight: FontWeight.bold,
                          //                               color: ColorConstant.black,
                          //                             ),
                          //                           ),
                          //                           Padding(
                          //                             padding: const EdgeInsets.only(
                          //                                 right: 12.0),
                          //                             child: InkWell(
                          //                               onTap: () =>
                          //                                   showClearNotificationsPopup(
                          //                                       context),
                          //                               child: Icon(
                          //                                 Icons
                          //                                     .arrow_forward_ios_outlined,
                          //                                 size: 20,
                          //                                 color: ColorConstant.arrow,
                          //                               ),
                          //                             ),
                          //                           ),
                          //                         ],
                          //                       ),
                          //                     ),
                          //                   ],
                          //                 ),
                          //                 SizedBox(height: 12),
                          //               ],
                          //             ),
                          //           ),
                          //         ],
                          //       ),
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  )),
            ),
    );
  }

  void showClearNotificationsPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: ColorConstant.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            height: 210,
            width: 330,
            decoration: BoxDecoration(
                color: ColorConstant.white,
                border: Border.all(width: 1, color: ColorConstant.bordercolor),
                borderRadius: BorderRadius.circular(20)),
            child: Stack(
              children: [
                // Dialog Content
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Title
                    SizedBox(
                      height: 26,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "Are you Sure To Log Out?",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.manrope(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    // Buttons
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorConstant.white,
                                padding: EdgeInsets.symmetric(vertical: 16),
                                side: BorderSide(
                                  color:
                                      ColorConstant.bordercolor, // Border color
                                  width: 1, // Border width
                                ),
                              ),
                              child: Text(
                                "No",
                                style: GoogleFonts.manrope(
                                    color: ColorConstant.black, fontSize: 14),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () async {
                                SharedPreferences preferences =
                                    await SharedPreferences.getInstance();
                                await preferences.clear();
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()),
                                  (Route<dynamic> route) => false,
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorConstant.red,
                                padding: EdgeInsets.symmetric(vertical: 16),
                              ),
                              child: Text(
                                "Yes",
                                style: GoogleFonts.manrope(
                                    color: ColorConstant.white, fontSize: 14),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
                // Close Icon
                Positioned(
                  top: 12,
                  right: 16,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: Icon(
                      Icons.close,
                      size: 24,
                      color: ColorConstant.bootombar,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void shareAppLink() {
    const String appLink =
        "https://example.com/your-app-link"; // Replace with your app's link
    String message = "Check out this amazing app: $appLink";

    Share.share(message,
        subject: "Job Application"); // Share message with subject
  }
}
