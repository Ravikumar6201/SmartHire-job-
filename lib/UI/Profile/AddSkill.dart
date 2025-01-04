// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_application/Common/Contant.dart';
import 'package:job_application/Common/Deletepopup.dart';
import 'package:job_application/Core/Provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddSkillScreen extends StatefulWidget {
  @override
  _AddSkillScreenState createState() => _AddSkillScreenState();
}

class _AddSkillScreenState extends State<AddSkillScreen> {
  String selectedLevel = 'Intermediate';
  final List<Map<String, String>> skillList = [];
  String? id;

  @override
  void initState() {
    super.initState();
    selectedLevel = 'Intermediate';
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
      context.read<UserProvider>().fetchSkill(
            userID.toString(), // User ID
            Token.toString(),
          );
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //   //get worktype
      context.read<UserProvider>().fetchSkillMaster(
            userID.toString(), // User ID
            Token.toString(),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UserProvider>();
    final skillList = provider.Skilllist;
    final skillListmaster = provider.SkilllistMaster;
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Skills',
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
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        children: [
                          _buildInputField("Skill", skillListmaster),
                          const SizedBox(height: 16),
                          _buildDropdownField("Level"),
                          const SizedBox(height: 24),
                          if (id == null)
                            InkWell(
                              onTap: () async {
                                if (selectedSkillId != null) {
                                  Map<String, dynamic> result =
                                      await provider.addSkill(
                                          '',
                                          userID.toString(),
                                          Token.toString(),
                                          selectedSkillId.toString(),
                                          selectedLevel);
                                  if (result['success']) {
                                    // Handle successful registration
                                    selectedSkillId = null;
                                    selectedSkill = "PHP";
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
                                      backgroundColor: ColorConstant.green,
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
                                      " Add Skill",
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
                            InkWell(
                              onTap: () async {
                                if (selectedSkillId != null) {
                                  Map<String, dynamic> result =
                                      await provider.addSkill(
                                          id.toString(),
                                          userID.toString(),
                                          Token.toString(),
                                          selectedSkillId.toString(),
                                          selectedLevel.toString());
                                  if (result['success']) {
                                    // Handle successful registration
                                    final data = result['data'];
                                    setState(() {
                                      id = null;
                                      selectedLevel = 'Intermediate';
                                      selectedSkillId = null;
                                      selectedSkill = "PHP";
                                      // selectedSkill =;
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
                                    // Icon(
                                    //   Icons.add,
                                    //   color: ColorConstant.editinfo,
                                    // ),
                                    Text(
                                      " Update Skill",
                                      style: GoogleFonts.manrope(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: ColorConstant.editinfo),
                                    ),
                                  ],
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
                            itemCount: skillList.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final education = skillList[index];
                              return InkWell(
                                onTap: () async {
                                  Map<String, dynamic> result =
                                      await provider.fetchSkillById(
                                    userID.toString(),
                                    Token.toString(),
                                    education['id'],
                                  );
                                  // if (result['success']==200) {
                                  final level = result['level'];
                                  final idlist = result['skillid'];
                                  final skill = result['skilltitle'];
                                  final getid = result['id'];

                                  // getData();
                                  setState(() {
                                    id = getid.toString();
                                    selectedLevel = level.toString();
                                    selectedSkillId = idlist;
                                    selectedSkill = skill;
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
                                                  education["skill"] ?? ''),
                                              // skillList[index]['skill']!,
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

  String selectedSkill = "PHP";
  String? selectedSkillId;
  void _showSkillDropdown(List<dynamic> skillListmaster) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: 350, // Fixed height of 350 pixels
          child: ListView(
            children: skillListmaster.map((skill) {
              return ListTile(
                title: Text(
                  skill['title']!,
                  style: GoogleFonts.manrope(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  setState(() {
                    selectedSkill = skill['title'];
                  });
                  Navigator.pop(context); // Close the dropdown after selection
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  Widget _buildInputField(String label, List<dynamic> skillListmaster) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Skill",
          style: GoogleFonts.manrope(
            fontSize: 14,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        // GestureDetector(
        //   onTap: () {
        //     _showSkillDropdown(skillListmaster);
        //   },
        //   child: InputDecorator(
        //     decoration: InputDecoration(
        //       contentPadding:
        //           const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        //       border: OutlineInputBorder(
        //         borderRadius: BorderRadius.circular(16.0),
        //       ),
        //       hintText: "Select a Skill",
        //       hintStyle: GoogleFonts.manrope(
        //         fontSize: 14,
        //         color: Colors.grey,
        //         fontWeight: FontWeight.bold,
        //       ),
        //     ),
        //     child: Text(
        //       selectedSkill ?? "Select a Skill",
        //       style: GoogleFonts.manrope(
        //         fontSize: 14,
        //         color: selectedSkill == null ? Colors.grey : Colors.black,
        //         fontWeight: FontWeight.bold,
        //       ),
        //     ),
        //   ),
        // ),

        DropdownButtonFormField<String>(
          dropdownColor: ColorConstant.white,
          items: skillListmaster.map<DropdownMenuItem<String>>((dynamic skill) {
            // Assuming skill is a map with "id" and "title" keys
            final String skillTitle = skill['title'] as String;
            return DropdownMenuItem<String>(
              value: skillTitle,
              child: Text(
                skillTitle,
                style: GoogleFonts.manrope(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }).toList(),
          value: selectedSkill,
          onChanged: (String? newValue) {
            setState(() {
              selectedSkill = newValue!;
              // Find the selected skill from the list to get the corresponding ID
              final selectedSkillItem = skillListmaster.firstWhere(
                (skill) => skill['title'] == newValue,
                orElse: () => {},
              );
              selectedSkillId = selectedSkillItem['id'];
            });
            print('Selected Skill: $selectedSkill, ID: $selectedSkillId');
          },
          style: GoogleFonts.manrope(
            fontSize: 14,
            color: ColorConstant.black,
            fontWeight: FontWeight.bold,
          ),
          decoration: InputDecoration(
            hintText: "Select a Skill",
            hintStyle: GoogleFonts.manrope(
              color: ColorConstant.black,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            // Center the hint text
            alignLabelWithHint: true,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
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
      content: 'Skill',
      onDelete: () {
        // removeSkill(index); // Call delete logic
        WidgetsBinding.instance.addPostFrameCallback((_) {
          context
              .read<UserProvider>()
              .DeteleSkill(
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
