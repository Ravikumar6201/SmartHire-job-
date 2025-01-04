// // ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:job_application/Common/Contant.dart';
// import 'package:job_application/Core/Provider.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class EditSkillScreen extends StatefulWidget {
//   String id, skillname, level;
//   @override
//   EditSkillScreen(
//       {required this.id, required this.skillname, required this.level});
//   @override
//   _EditSkillScreenState createState() => _EditSkillScreenState();
// }

// class _EditSkillScreenState extends State<EditSkillScreen> {
//   late TextEditingController skillController;

//   String selectedLevel = '';
//   final List<Map<String, String>> skillList = [];

//   @override
//   void initState() {
//     super.initState();
//     skillController = TextEditingController(text: widget.skillname);

//     UserProfile();
//     setState(() {
//       selectedLevel = widget.level;
//     });
//   }

//   String? Token;
//   String? userID;
//   UserProfile() async {
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     Token = preferences.getString('token');
//     userID = preferences.getString('userid');
//     setState(() {
//       Token;
//       userID;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final provider = context.watch<UserProvider>();
//     return Scaffold(
//       appBar: AppBar(
//           title: Text(
//             'Edit Skill',
//             style: GoogleFonts.manrope(
//                 fontSize: 16,
//                 color: ColorConstant.black,
//                 fontWeight: FontWeight.bold),
//           ),
//           leading: InkWell(
//             onTap: () {
//               Navigator.pop(context);
//             },
//             child: Image.asset(
//               'assets/images/backarrow.png',
//               height: 100,
//               width: 100,
//               fit: BoxFit.contain,
//             ),
//           )),
//       body: Padding(
//         padding: const EdgeInsets.all(24.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildInputField("Skill", skillController),
//             const SizedBox(height: 16),
//             _buildDropdownField("Level"),
//             const SizedBox(height: 16),
//             InkWell(
//               onTap: () async {
//                 Map<String, dynamic> result = await provider.addSkill(
//                     widget.id,
//                     userID.toString(),
//                     Token.toString(),
//                     skillController.text,
//                     selectedLevel);
//                 if (result['success']) {
//                   // Handle successful registration
//                   final data = result['data'];
//                   Fluttertoast.showToast(
//                     msg: data['message'],
//                     toastLength: Toast.LENGTH_SHORT,
//                     gravity: ToastGravity.TOP, // Show toast at the top
//                     timeInSecForIosWeb: 1,
//                     backgroundColor: ColorConstant.green,
//                     textColor: ColorConstant.white,
//                     fontSize: 16.0,
//                   );
//                 } else {
//                   Fluttertoast.showToast(
//                     msg: result['data']['message'],
//                     toastLength: Toast.LENGTH_SHORT,
//                     gravity: ToastGravity.TOP, // Show toast at the top
//                     timeInSecForIosWeb: 1,
//                     backgroundColor: ColorConstant.green,
//                     textColor: ColorConstant.white,
//                     fontSize: 16.0,
//                   );
//                 }
//                 Navigator.pop(context);
//               },
//               child: Container(
//                 height: 56,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(16),
//                     border: Border.all(width: 01, color: ColorConstant.botton)),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     // Icon(
//                     //   Icons.add,
//                     //   color: ColorConstant.editinfo,
//                     // ),
//                     Text(
//                       " Edit Skill",
//                       style: GoogleFonts.manrope(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                           color: ColorConstant.editinfo),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Divider(
//               height: 40,
//               thickness: 5,
//               color: ColorConstant.bordercolor,
//             ),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: skillList.length,
//                 itemBuilder: (context, index) {
//                   return Column(
//                     children: [
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 skillList[index]['skill']!,
//                                 style: GoogleFonts.manrope(
//                                     fontSize: 16,
//                                     color: ColorConstant.black,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                               InkWell(
//                                   onTap: () {
//                                     // _showDeleteDialog(context, index);
//                                   },
//                                   child: Icon(
//                                     Icons.delete_outline,
//                                     color: ColorConstant.lightblack,
//                                   )),
//                               // IconButton(
//                               //   icon: Icon(Icons.delete_outline,
//                               //       color: Colors.red),
//                               //   onPressed: () => removeSkill(index),
//                               // ),
//                             ],
//                           ),
//                           Text(skillList[index]['level']!),
//                         ],
//                       ),
//                       Divider(
//                         height: 20,
//                         thickness: 1,
//                         color: ColorConstant.bordercolor,
//                       ),
//                     ],
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildInputField(String label, TextEditingController controller) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: GoogleFonts.manrope(
//               fontSize: 14,
//               color: ColorConstant.lightblack,
//               fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 8),
//         TextFormField(
//           controller: controller,
//           style: GoogleFonts.manrope(
//               fontSize: 14,
//               color: ColorConstant.black,
//               fontWeight: FontWeight.bold),
//           decoration: InputDecoration(
//             hintText: 'Skill',
//             hintStyle: GoogleFonts.manrope(
//                 color: ColorConstant.black,
//                 fontSize: 14,
//                 fontWeight: FontWeight.bold),
//             // Conditionally show the icon or set it to null
//             prefixStyle: GoogleFonts.manrope(
//               color: ColorConstant.lightblack,
//             ),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(16.0),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(16.0),
//               borderSide: BorderSide(
//                 color: ColorConstant.bordercolor,
//                 width: 1,
//               ),
//             ),

//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(20.0),
//               borderSide: BorderSide(
//                 color: ColorConstant.bordercolor,
//                 width: 1,
//               ),
//             ),
//             filled: true,
//             fillColor: ColorConstant.transparent,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildDropdownField(String label) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: GoogleFonts.manrope(
//               fontSize: 14,
//               color: ColorConstant.lightblack,
//               fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 8),
//         DropdownButtonFormField<String>(
//           dropdownColor: ColorConstant.white,
//           value: selectedLevel,
//           items: ['Beginner', 'Intermediate', 'Expert']
//               .map((level) => DropdownMenuItem(
//                     value: level,
//                     child: Text(
//                       level,
//                       style: GoogleFonts.manrope(
//                           fontSize: 14,
//                           color: ColorConstant.black,
//                           fontWeight: FontWeight.bold),
//                     ),
//                   ))
//               .toList(),
//           onChanged: (value) {
//             setState(() {
//               selectedLevel = value!;
//             });
//           },
//           style: GoogleFonts.manrope(
//               fontSize: 14,
//               color: ColorConstant.black,
//               fontWeight: FontWeight.bold),
//           decoration: InputDecoration(
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(16.0),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(16.0),
//               borderSide: BorderSide(
//                 color: ColorConstant.bordercolor,
//                 width: 1,
//               ),
//             ),

//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(20.0),
//               borderSide: BorderSide(
//                 color: ColorConstant.bordercolor,
//                 width: 1,
//               ),
//             ),
//             // border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
//             contentPadding:
//                 const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
//           ),
//         ),
//       ],
//     );
//   }
// }
