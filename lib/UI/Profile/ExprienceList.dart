// ignore_for_file: use_key_in_widget_constructors, non_constant_identifier_names, file_names, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_application/Common/Contant.dart';
import 'package:job_application/Common/Deletepopup.dart';
import 'package:job_application/Core/Provider.dart';
import 'package:job_application/UI/Profile/ExprienceEdit.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExprienceListScreen extends StatefulWidget {
  @override
  State<ExprienceListScreen> createState() => _ExprienceListScreenState();
}

class _ExprienceListScreenState extends State<ExprienceListScreen> {
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
      //get Exprience
      context.read<UserProvider>().fetchExprience(
            userID.toString(), // User ID
            Token.toString(),
          );
    });
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
    final Expriencelist = provider.Expriencelist;
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Edit Exprience',
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
      body: provider.isLoading
          ? Center(
              child: CircularProgressIndicator(
              color: ColorConstant.botton,
            ))
          : Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: Expriencelist.length,
                      itemBuilder: (context, index) {
                        final education = Expriencelist[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  'assets/images/exprience.png',
                                  height: 36,
                                  width: 36,
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
                                            education["companyname"]!),
                                        style: GoogleFonts.manrope(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: ColorConstant.black),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            TruncetString(
                                                education["designation"]!),
                                            style: GoogleFonts.manrope(
                                              fontSize: 12,
                                              color: ColorConstant.lightblack,
                                            ),
                                          ),
                                          Text(
                                            " ● " +
                                                TruncetString(education[
                                                    "worktype_name"]!),
                                            style: GoogleFonts.manrope(
                                              fontSize: 12,
                                              color: ColorConstant.botton,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        education["start_month"]! +
                                            " " +
                                            education["start_year"]! +
                                            " - " +
                                            education["end_month"]! +
                                            " " +
                                            education["end_year"]!,
                                        style: GoogleFonts.manrope(
                                          fontSize: 12,
                                          color: ColorConstant.lightblack,
                                        ),
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
                                                  ExprienceEdit(
                                                    id: education["id"]!,
                                                    designation: education[
                                                        "designation"]!,
                                                    worktype:
                                                        education["work_type"]!,
                                                    companyname: education[
                                                        "companyname"]!,
                                                    start_month: education[
                                                        "start_month"]!,
                                                    start_year: education[
                                                        "start_year"]!,
                                                    end_month:
                                                        education["end_month"]!,
                                                    end_years:
                                                        education["end_year"]!,
                                                    rolenresponssibility: education[
                                                        "role_responsibility"]!,
                                                    worktypename: education[
                                                        "worktype_name"]!,
                                                  )), // Replace `NewPage` with the page you want to navigate to
                                        ).then((_) {
                                          // UserProfile();
                                          context
                                              .read<UserProvider>()
                                              .fetchExprience(
                                                userID.toString(), // User ID
                                                Token.toString(),
                                              );
                                        }).catchError((error) {
                                          // Handle error if needed
                                          print("Error: $error");
                                        });
                                      },
                                      child: Image.asset(
                                        'assets/images/Edit.png',
                                        height: 20,
                                        width: 20,
                                        fit: BoxFit.contain,
                                        color: ColorConstant.lightblack,
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
                              education["role_responsibility"]!,
                              style: GoogleFonts.manrope(
                                  fontSize: 14, color: ColorConstant.category),
                            ),
                            Divider(
                              color: ColorConstant.bordercolor,
                            )
                          ],
                        );
                      },
                    ),
                  ),
                  /* SizedBox(height: 8),
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
                    " Add Experience",
                    style: GoogleFonts.manrope(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: ColorConstant.editinfo),
                  ),
                ],
              ),
            ),
          */
                ],
              ),
            ),
    );
  }

  //delete popup
  void _showDeleteDialog(BuildContext context, int index, String id) {
    DialogUtils.showDeleteConfirmationDialog(
      context: context,
      content: 'Exprience',
      onDelete: () {
        // removeSkill(index); // Call delete logic
        WidgetsBinding.instance.addPostFrameCallback((_) {
          context
              .read<UserProvider>()
              .DeteleExprience(
                  userID.toString(), // User ID
                  Token.toString(),
                  id.toString())
              .then((_) {
            UserProfile(); // Call reload after deleting the resume
          }).catchError((error) {
            // Handle error if needed
            print("Error: $error");
          });
        });
      },
    );
  }
}
