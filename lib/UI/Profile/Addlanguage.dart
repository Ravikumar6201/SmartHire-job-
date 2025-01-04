// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:job_application/Common/Contant.dart';
import 'package:job_application/Common/Deletepopup.dart';
import 'package:job_application/Core/Provider.dart';
import 'package:job_application/UI/Profile/EditSkill.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddLaguageScreen extends StatefulWidget {
  @override
  _AddLaguageScreenState createState() => _AddLaguageScreenState();
}

class _AddLaguageScreenState extends State<AddLaguageScreen> {
  TextEditingController skillController = TextEditingController();
  String selectedLevel = 'Intermediate';
  final List<Map<String, String>> LaguageList = [];
  String? id;

  @override
  void initState() {
    super.initState();
    selectedLevel = 'Intermediate';
    skillController = TextEditingController(text: '');
    UserProfile();
  }

  String? Token;

  String? userID;

  String truncateString(String text) {
    if (text.length > 30) {
      return text.substring(0, 30) + '..';
    }
    return text;
  }

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
      //   //get worktype
      context.read<UserProvider>().fetchLanguage(
            userID.toString(), // User ID
            Token.toString(),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UserProvider>();
    final LaguageList = provider.Languagelist;
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Language',
            style: GoogleFonts.manrope(
                fontSize: 16,
                color: ColorConstant.black,
                fontWeight: FontWeight.bold),
          ),
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
          : Container(
              color: ColorConstant.settingback,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    color: ColorConstant.white,
                    elevation: 05,
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        children: [
                          _buildInputField("Laguage", skillController),
                          const SizedBox(height: 16),
                          _buildDropdownField("Level"),
                          const SizedBox(height: 24),
                          if (id == null)
                            InkWell(
                              onTap: () async {
                                if (skillController.text != "") {
                                  Map<String, dynamic> result =
                                      await provider.addLanguage(
                                          '',
                                          userID.toString(),
                                          Token.toString(),
                                          skillController.text,
                                          selectedLevel);
                                  if (result['success']) {
                                    // Handle successful registration
                                    skillController.text = '';
                                    selectedLevel = 'Intermediate';
                                    final data = result['data'];
                                    UserProfile();
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
                                    Fluttertoast.showToast(
                                      msg: result['data']['message'],
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
                                  Fluttertoast.showToast(
                                    msg: "All field are required *",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity
                                        .TOP, // Show toast at the top
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: ColorConstant.red,
                                    textColor: ColorConstant.white,
                                    fontSize: 16.0,
                                  );
                                }

                                // Navigator.pop(context);
                              },
                              child: Container(
                                height: 60,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                        width: 01,
                                        color: ColorConstant.botton)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add,
                                      color: ColorConstant.editinfo,
                                    ),
                                    Text(
                                      " Add Laguage",
                                      style: GoogleFonts.manrope(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: ColorConstant.editinfo),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          if (id != null)
                            Card(
                              color: ColorConstant.white,
                              elevation: 05,
                              child: InkWell(
                                onTap: () async {
                                  Map<String, dynamic> result =
                                      await provider.addLanguage(
                                          id.toString(),
                                          userID.toString(),
                                          Token.toString(),
                                          skillController.text,
                                          selectedLevel);
                                  if (result['success']) {
                                    // Handle successful registration
                                    final data = result['data'];
                                    setState(() {
                                      id = null;
                                      selectedLevel = 'Intermediate';
                                      skillController =
                                          TextEditingController(text: '');
                                    });
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
                                    Fluttertoast.showToast(
                                      msg: result['data']['message'],
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity
                                          .TOP, // Show toast at the top
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: ColorConstant.green,
                                      textColor: ColorConstant.white,
                                      fontSize: 16.0,
                                    );
                                  }
                                  // Navigator.pop(context);
                                },
                                child: Container(
                                  height: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    // border: Border.all(
                                    //     width: 01,
                                    //     color: ColorConstant.botton)
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // Icon(
                                      //   Icons.add,
                                      //   color: ColorConstant.editinfo,
                                      // ),
                                      Text(
                                        " Update Laguage",
                                        style: GoogleFonts.manrope(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: ColorConstant.editinfo),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Expanded(
                    child: Card(
                      color: ColorConstant.white,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0)),
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: ListView.builder(
                            itemCount: LaguageList.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final education = LaguageList[index];
                              return InkWell(
                                onTap: () async {
                                  Map<String, dynamic> result =
                                      await provider.fetchLanguageById(
                                    userID.toString(),
                                    Token.toString(),
                                    education['id'],
                                  );
                                  // if (result['success']==200) {
                                  final level = result['level'];
                                  final skill = result['lang'];
                                  final getid = result['id'];

                                  // getData();
                                  setState(() {
                                    id = getid.toString();
                                    selectedLevel = level.toString();
                                    skillController =
                                        TextEditingController(text: skill);
                                  });
                                  Fluttertoast.showToast(
                                    msg: result['message'],
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity
                                        .TOP, // Show toast at the top
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: ColorConstant.green,
                                    textColor: ColorConstant.white,
                                    fontSize: 16.0,
                                  );
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) =>
                                  //           ApplyJobSecussScreen()), // Replace `NewPage` with the page you want to navigate to
                                  // );
                                  // } else {
                                  //   Fluttertoast.showToast(
                                  //     msg: result['data']['message'],
                                  //     toastLength: Toast.LENGTH_SHORT,
                                  //     gravity: ToastGravity
                                  //         .TOP, // Show toast at the top
                                  //     timeInSecForIosWeb: 1,
                                  //     backgroundColor: ColorConstant.green,
                                  //     textColor: ColorConstant.white,
                                  //     fontSize: 16.0,
                                  //   );
                                  // }
                                },
                                child: Column(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              truncateString(
                                                  education["lang"] ?? ''),
                                              // LaguageList[index]['skill']!,
                                              style: GoogleFonts.manrope(
                                                  fontSize: 14,
                                                  color: ColorConstant.black,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            InkWell(
                                              onTap: () => _showDeleteDialog(
                                                  context,
                                                  index,
                                                  education['id']!),
                                              child: Image.asset(
                                                'assets/images/delete.png',
                                                height: 20,
                                                width: 20,
                                                color: ColorConstant.lightblack,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          education["level"]!,
                                          style: GoogleFonts.manrope(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w300,
                                              color: ColorConstant.lightblack),
                                        ),
                                      ],
                                    ),
                                    Divider(
                                      height: 20,
                                      thickness: 1,
                                      color: ColorConstant.bordercolor,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildInputField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.manrope(
              fontSize: 14,
              color: ColorConstant.lightblack,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          style: GoogleFonts.manrope(
              fontSize: 14,
              color: ColorConstant.black,
              fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            hintText: 'Laguage',
            hintStyle: GoogleFonts.manrope(
                color: ColorConstant.black,
                fontSize: 14,
                fontWeight: FontWeight.bold),
            // Conditionally show the icon or set it to null
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

  Widget _buildDropdownField(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.manrope(
              fontSize: 14,
              color: ColorConstant.lightblack,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          dropdownColor: ColorConstant.white,
          value: selectedLevel,
          items: ['Intermediate', 'Beginner', 'Expert']
              .map((level) => DropdownMenuItem(
                    value: level,
                    child: Text(
                      level,
                      style: GoogleFonts.manrope(
                          fontSize: 14,
                          color: ColorConstant.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ))
              .toList(),
          onChanged: (value) {
            setState(() {
              selectedLevel = value!;
            });
          },
          style: GoogleFonts.manrope(
              fontSize: 14,
              color: ColorConstant.black,
              fontWeight: FontWeight.bold),
          decoration: InputDecoration(
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
            // border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          ),
        ),
      ],
    );
  }

  //delete popup
  void _showDeleteDialog(BuildContext context, int index, String id) {
    DialogUtils.showDeleteConfirmationDialog(
      context: context,
      content: 'Laguage',
      onDelete: () {
        // removeSkill(index); // Call delete logic
        WidgetsBinding.instance.addPostFrameCallback((_) {
          context
              .read<UserProvider>()
              .DeteleLanguage(
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
