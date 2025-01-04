// ignore_for_file: prefer_const_literals_to_create_immutables, sized_box_for_whitespace, unused_element, use_key_in_widget_constructors, avoid_print, non_constant_identifier_names, avoid_single_cascade_in_expression_statements, unnecessary_string_interpolations, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_application/Common/Contant.dart';
import 'package:job_application/Common/Deletepopup.dart';
import 'package:job_application/Core/Provider.dart';
import 'package:job_application/UI/Profile/AddEducation.dart';
import 'package:job_application/UI/Profile/EditEducation.dart';
import 'package:job_application/UI/Profile/EducationList.dart';
// import 'package:job_application/UI/Profile/SkillList.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class EducationScreen extends StatefulWidget {
  @override
  State<EducationScreen> createState() => _EducationScreenState();
}

class _EducationScreenState extends State<EducationScreen> {
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
      //get education
      context.read<UserProvider>().fetchEducation(
            userID.toString(), // User ID
            Token.toString(),
          );
    });
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

  String TruncetString(String text) {
    if (text.length > 22) {
      return text.substring(0, 22) + '...';
    }
    return text;
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UserProvider>();
    final Educationlist = provider.Educationlist;
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600; // Determine if it's a tablet

    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Education',
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

                    SizedBox(
                      height: 2,
                    ),
                    Card(
                      color: ColorConstant.white,
                      elevation: 05,
                      child: Container(
                        color: ColorConstant.white,
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  _buildSectionTitle('Education', isTablet),
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AddEducationScreen()), // Replace `NewPage` with the page you want to navigate to
                                          );
                                        },
                                        child: Image.asset(
                                          'assets/images/add-circle.png',
                                          height: 20,
                                          width: 20,
                                          color: ColorConstant.lightblack,
                                        ),
                                      ),
                                      // SizedBox(
                                      //   width: 8,
                                      // ),
                                      // InkWell(
                                      //   onTap: () {
                                      //     Navigator.push(
                                      //       context,
                                      //       MaterialPageRoute(
                                      //           builder: (context) =>
                                      // EducationListScreen()), // Replace `NewPage` with the page you want to navigate to
                                      //     );
                                      //   },
                                      //   child: Image.asset(
                                      //     'assets/images/Edit.png',
                                      //     height: 20,
                                      //     width: 20,
                                      //     color: ColorConstant.lightblack,
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 16),
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: Educationlist.length,
                                itemBuilder: (context, index) {
                                  final education = Educationlist[index];
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Image.asset(
                                            'assets/images/education.png',
                                            height: 35,
                                            width: 35,
                                            fit: BoxFit.contain,
                                            // color: ColorConstant.transparent,
                                          ),
                                          // CircleAvatar(
                                          //   radius: 20,
                                          //   backgroundColor: Colors.blue,
                                          //   child: Icon(Icons.school, color: Colors.white),
                                          // ),
                                          SizedBox(width: 12),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  TruncetString(
                                                      education["univercity"]!),
                                                  style: GoogleFonts.manrope(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          ColorConstant.black),
                                                ),
                                                Text(
                                                  TruncetString(
                                                      education["course"]!),
                                                  style: GoogleFonts.manrope(
                                                    fontSize: 12,
                                                    color: ColorConstant
                                                        .lightblack,
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      education["start_year"]!,
                                                      style:
                                                          GoogleFonts.manrope(
                                                        fontSize: 12,
                                                        color: ColorConstant
                                                            .lightblack,
                                                      ),
                                                    ),
                                                    Text(" - "),
                                                    Text(
                                                      education["end_year"]!,
                                                      style:
                                                          GoogleFonts.manrope(
                                                        fontSize: 12,
                                                        color: ColorConstant
                                                            .lightblack,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            EditEducationScreen(
                                                              id: education[
                                                                  "id"]!,
                                                              school: education[
                                                                  "univercity"]!,
                                                              study: education[
                                                                  "course"]!,
                                                              start_month:
                                                                  education[
                                                                      "start_month"]!,
                                                              start_year: education[
                                                                  "start_year"]!,
                                                              end_month: education[
                                                                  "end_month"]!,
                                                              end_years: education[
                                                                  "end_year"]!,
                                                              rolenresponssibility:
                                                                  education[
                                                                      "description"]!,
                                                            )),
                                                  );
                                                },
                                                child: Image.asset(
                                                  'assets/images/Edit.png',
                                                  height: 18,
                                                  width: 18,
                                                  fit: BoxFit.contain,
                                                  color:
                                                      ColorConstant.lightblack,
                                                ),
                                              ),
                                              // SizedBox(
                                              //   width: 10,
                                              // ),
                                              // InkWell(
                                              //   onTap: () => _showDeleteDialog(
                                              //       context, index, education['id']!),
                                              //   child: Image.asset(
                                              //     'assets/images/trash.png',
                                              //     height: 20,
                                              //     width: 20,
                                              //     color: ColorConstant.red,
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        education["description"]!,
                                        style: GoogleFonts.manrope(
                                            fontSize: 14,
                                            color: ColorConstant.category),
                                      ),
                                      Divider(
                                        color: ColorConstant.bordercolor,
                                      )
                                    ],
                                  );
                                },
                              ),

                              // ListView.builder(
                              //   physics: AlwaysScrollableScrollPhysics(),
                              //   shrinkWrap: true,
                              //   itemCount: Educationlist.length,
                              //   // experienceList is your list of experience data
                              //   itemBuilder: (context, index) {
                              //     var experience = Educationlist[
                              //         index]; // Get experience at the current index

                              //     return Container(
                              //       child: _buildEducation(
                              //           'assets/images/education.png',
                              //           // experience[
                              //           //     'companyLogo'], // e.g.,
                              //           experience[
                              //               'univercity'], // e.g., 'Facebook'
                              //           experience[
                              //               'course'], // e.g., 'UI Designer'
                              //           experience['start_year'] +
                              //               " - " +
                              //               experience[
                              //                   'end_year'], // e.g., 'Mumbai'
                              //           // e.g., 'June 2020 - Dec 2020'
                              //           isTablet,
                              //           index),
                              //     );
                              //   },
                              // ),

                              // _buildEducation(
                              //     'assets/images/education.png',
                              //     'BMC Cordelia Bangsa',
                              //     'Bachelor of Science',
                              //     '2017 - 2021',
                              //     isTablet),
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
        // if (index != 1)
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
