// ignore_for_file: prefer_const_literals_to_create_immutables, sized_box_for_whitespace, unused_element, use_key_in_widget_constructors, avoid_print, non_constant_identifier_names, avoid_single_cascade_in_expression_statements, unnecessary_string_interpolations, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_application/Common/Contant.dart';
import 'package:job_application/Common/Deletepopup.dart';
import 'package:job_application/Common/Url.dart';
import 'package:job_application/Core/Provider.dart';
import 'package:job_application/UI/Profile/EditInfo.dart';
import 'package:job_application/UI/Profile/ProfileEdit.dart';
// import 'package:job_application/UI/Profile/SkillList.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class PersonalinformationScreen extends StatefulWidget {
  @override
  State<PersonalinformationScreen> createState() =>
      _PersonalinformationScreenState();
}

class _PersonalinformationScreenState extends State<PersonalinformationScreen> {
  int? selectedResumeIndex;
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
      //get resume
      context.read<UserProvider>().fetchResume(
            userID.toString(), // User ID
            Token.toString(),
          );
      //get Exprience
      context.read<UserProvider>().fetchExprience(
            userID.toString(), // User ID
            Token.toString(),
          );
      //get education
      context.read<UserProvider>().fetchEducation(
            userID.toString(), // User ID
            Token.toString(),
          );
    });
    //get skill
    context.read<UserProvider>().fetchSkill(
          userID.toString(), // User ID
          Token.toString(),
        );
    //get language
    context.read<UserProvider>().fetchLanguage(
          userID.toString(), // User ID
          Token.toString(),
        );
  }

  // Select resume and navigate to submit application page
  void _selectResume(int index) {
    setState(() {
      selectedResumeIndex = index;
    });
    // Navigate to submit application page and pass the selected resume data
  }

  String truncateString(String text) {
    if (text.length > 22) {
      return text.substring(0, 22) + '...';
    }
    return text;
  }

  String truncateStringabout(String text) {
    if (text.length > 100) {
      return text.substring(0, 100) + '...';
    }
    return text;
  }

  String dateconverter(String date) {
    // Parse the input date
    DateTime parsedDate = DateFormat("dd-MM-yyyy HH:mm").parse(date);

    // Format the parsed date to the desired output format
    String formattedDate = DateFormat("d MMM yyyy").format(parsedDate);
    return formattedDate;

    // Print the result
    print(formattedDate); // Output: 20 Dec 2024
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UserProvider>();
    final userProfile = provider.userProfile;
    final Resumelist = provider.Resumelist;
    final Expriencelist = provider.Expriencelist;
    final Educationlist = provider.Educationlist;
    final skillList = provider.Skilllist;
    final laguagelist = provider.Languagelist;
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600; // Determine if it's a tablet

    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Profile',
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
      body: provider.isLoading
          ? Center(
              child: CircularProgressIndicator(
              color: ColorConstant.botton,
            ))
          : SingleChildScrollView(
              // padding: EdgeInsets.all(16.0),
              child: Container(
                // height: double.infinity,
                // width: double.infinity,
                color: ColorConstant.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SizedBox(height: 4),
                    // Profile Section
                    Card(
                      color: ColorConstant.white,
                      elevation: 05,
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                            color: ColorConstant.white,
                            borderRadius:
                                BorderRadius.circular(0), // Rounded corners
                            boxShadow: [
                              BoxShadow(
                                color:
                                    ColorConstant.bordercolor.withOpacity(0.1),
                                blurRadius: 10,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: Stack(
                                  children: [
                                    // Main Container
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        // Profile Picture
                                        Container(
                                          height: 64,
                                          width: 64,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              if (userProfile['profileimg'] !=
                                                  null)
                                                CircleAvatar(
                                                  radius: 30,
                                                  backgroundImage: NetworkImage(
                                                      "${ApiConstants.baseUrl}"
                                                      "${userProfile['profileimg']}"),
                                                  //   backgroundImage: NetworkImage(
                                                  //       'https://cdn.pixabay.com/photo/2015/03/03/18/58/girl-657753_1280.jpg'),
                                                ),
                                              if (userProfile['profileimg'] ==
                                                  null)
                                                CircleAvatar(
                                                  radius: 30,
                                                  backgroundImage: AssetImage(
                                                      "assets/images/settingimg/user-profile.jpg"),
                                                  //   backgroundImage: NetworkImage(
                                                  //       'https://cdn.pixabay.com/photo/2015/03/03/18/58/girl-657753_1280.jpg'),
                                                ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 20),
                                        // Name
                                        Text(
                                          '${truncateString(userProfile['name'] ?? '')}',
                                          style: GoogleFonts.manrope(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              color: ColorConstant.black),
                                        ),
                                        SizedBox(height: 4),
                                        // Designation
                                        Text(
                                          '${truncateString(userProfile['jobtitle'] ?? '')}',
                                          style: GoogleFonts.manrope(
                                            fontSize: 14,
                                            color: ColorConstant.lightblack,
                                          ),
                                        ),
                                        SizedBox(height: 16),
                                        // About Section
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'About',
                                            style: GoogleFonts.manrope(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            '${truncateStringabout(userProfile['about'] ?? '')}',
                                            style: GoogleFonts.manrope(
                                              fontSize: 14,
                                              color: ColorConstant.lightblack,
                                              // height: 1.5,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    // Edit Icon Positioned at Top-Right
                                    Positioned(
                                      top:
                                          0, // Position relative to the container
                                      right: 0,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    EditProfile(
                                                      image: userProfile[
                                                              'profileimg'] ??
                                                          '',
                                                      name:
                                                          userProfile['name'] ??
                                                              '',
                                                      about: userProfile[
                                                              'about'] ??
                                                          '',
                                                      jobtitle: userProfile[
                                                              'jobtitle'] ??
                                                          '',
                                                    )), // Replace `NewPage` with the page you want to navigate to
                                          ).then((_) {
                                            UserProfile(); // Call reload after deleting the resume
                                          }).catchError((error) {
                                            // Handle error if needed
                                            print("Error: $error");
                                          });
                                        },
                                        child: Image.asset(
                                          'assets/images/Edit.png',
                                          height: 20,
                                          width: 20,
                                          color: ColorConstant.lightblack,
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

                    // SizedBox(height: 8),

                    // Info Section
                    Card(
                      elevation: 05,
                      color: ColorConstant.white,
                      child: Container(
                        decoration: BoxDecoration(
                            color: ColorConstant.white,
                            borderRadius: BorderRadius.circular(0)),
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  _buildSectionTitle('Info', isTablet),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => EditInfo(
                                                email:
                                                    userProfile['email'] ?? '',
                                                phone:
                                                    userProfile['phone'] ?? '',
                                                locationn:
                                                    userProfile['location'] ??
                                                        '',
                                                website: userProfile[
                                                        'website'] ??
                                                    '')), // Replace `NewPage` with the page you want to navigate to
                                      );
                                    },
                                    child: Image.asset(
                                      'assets/images/Edit.png',
                                      height: 20,
                                      width: 20,
                                      color: ColorConstant.lightblack,
                                    ),
                                  ),
                                ],
                              ),
                              _buildInfoRow('assets/images/email.png', 'Email',
                                  '${userProfile['email'] ?? ''}', isTablet),
                              // SizedBox(
                              //   height: 05,
                              // ),
                              Divider(
                                color: ColorConstant.bordercolor,
                              ),
                              _buildInfoRow(
                                  'assets/images/call-02.png',
                                  'Phone',
                                  '${userProfile['phone'] ?? ''}',
                                  isTablet),
                              // SizedBox(
                              //   height: 05,
                              // ),
                              Divider(
                                color: ColorConstant.bordercolor,
                              ),
                              _buildInfoRow(
                                  'assets/images/global.png',
                                  'Portfolio Site',
                                  '${userProfile['website'] ?? ''}',
                                  isTablet),
                              // SizedBox(
                              //   height: 05,
                              // ),
                              Divider(
                                color: ColorConstant.bordercolor,
                              ),
                              _buildInfoRow(
                                  'assets/images/map-pin.png',
                                  'Location',
                                  '${userProfile['location'] ?? ''}',
                                  isTablet),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildSectionTitle(String title, bool isTablet) {
    return Text(
      truncateString(title),
      style: GoogleFonts.manrope(
        fontSize: isTablet ? 20 : 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildInfoRow(String icon, String title, String value, bool isTablet) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            icon,
            height: 24,
            width: 24,
            fit: BoxFit.contain,
            color: ColorConstant.lightblack,
          ),
          // Icon(icon, color: ColorConstant.lightblack),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                truncateString(title),
                style: GoogleFonts.manrope(
                  fontSize: isTablet ? 16 : 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                truncateString(value),
                style: GoogleFonts.manrope(
                  fontSize: isTablet ? 14 : 12,
                  color: ColorConstant.lightblack,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEducation(String icon, String title, String value,
      String session, bool isTablet, int index) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                icon,
                height: 32,
                width: 32,
                fit: BoxFit.contain,
                // color: ColorConstant.lightblack,
              ),
              // Icon(icon, color: ColorConstant.lightblack),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    truncateString(title),
                    style: GoogleFonts.manrope(
                      fontSize: isTablet ? 16 : 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    truncateString(value),
                    style: GoogleFonts.manrope(
                      fontSize: isTablet ? 14 : 12,
                      color: ColorConstant.lightblack,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    truncateString(session),
                    style: GoogleFonts.manrope(
                      fontSize: isTablet ? 14 : 12,
                      color: ColorConstant.lightblack,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        // SizedBox(
        //   height: 05,
        // ),
        if (index != 1)
          Divider(
            color: ColorConstant.bordercolor,
          ),
      ],
    );
  }

  Widget _buildExperienceRow(String companyprofile, String company, String role,
      String location, String duration, bool isTablet, int index) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                companyprofile,
                height: 36,
                width: 36,
                fit: BoxFit.contain,
                // color: ColorConstant.transparent,
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    truncateString(company),
                    style: GoogleFonts.manrope(
                        fontSize: isTablet ? 16 : 14,
                        fontWeight: FontWeight.bold,
                        color: ColorConstant.black),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Text(
                        truncateString(role),
                        style: GoogleFonts.manrope(
                            fontSize: isTablet ? 14 : 12,
                            color: ColorConstant.lightblack),
                        // textScaleFactor: 0,
                      ),
                      Text(
                        " ● " + truncateString(location),
                        style: GoogleFonts.manrope(
                            fontSize: isTablet ? 14 : 12,
                            color: ColorConstant.botton),
                        // textScaleFactor: 0,
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    duration,
                    style: GoogleFonts.manrope(
                        fontSize: isTablet ? 14 : 12,
                        color: ColorConstant.lightblack),
                    // textScaleFactor: 0,
                  ),
                ],
              ),
            ],
          ),
        ),
        // SizedBox(
        //   height: 05,
        // ),
        if (index != 1)
          Divider(
            color: ColorConstant.bordercolor,
          ),
      ],
    );
  }

  final List<String> laguage = ["English", "Hindi", "Spanish", "French"];

  // final List<String> Skill = [
  //   "UI Designer",
  //   "Graphic",
  //   "UX ",
  //   "PHP",
  // ];

  Widget _buildTag(String title) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: 12, vertical: 4), // Adjust padding for Hug dimensions
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.blue, // Border color
          width: 1, // Border width
        ),
        borderRadius: BorderRadius.circular(24), // Rounded corners
      ),
      child: Center(
        child: Text(
          truncateString(title),
          style: GoogleFonts.manrope(
            fontSize: 12, // Font size for text
            fontWeight: FontWeight.w600,
            color: Colors.blue, // Text color
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  //delete popup
  void _showDeleteDialog(BuildContext context, int index, String id) {
    DialogUtils.showDeleteConfirmationDialog(
      context: context,
      content: 'Resume',
      onDelete: () {
        // removeSkill(index); // Call delete logic
        WidgetsBinding.instance.addPostFrameCallback((_) {
          context.read<UserProvider>().DeteleResume(
              userID.toString(), // User ID
              Token.toString(),
              id.toString());
          //     .then((_) {
          //   //get resume
          //   context.read<UserProvider>().fetchResume(
          //         userID.toString(), // User ID
          //         Token.toString(),
          //       );
          // }).catchError((error) {
          //   // Handle error if needed
          //   print("Error: $error");
          // });
        });
      },
    );
  }
}
