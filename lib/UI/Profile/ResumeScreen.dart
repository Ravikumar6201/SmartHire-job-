// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors, non_constant_identifier_names, unnecessary_string_interpolations, prefer_interpolation_to_compose_strings

import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_application/Common/Contant.dart';
import 'package:job_application/Common/Deletepopup.dart';
import 'package:job_application/Common/Url.dart';
import 'package:job_application/Core/Provider.dart';
import 'package:job_application/UI/JobApply/JobAppliedSecuss.dart';
import 'package:job_application/UI/JobApply/ResumeView.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResumeScreen extends StatefulWidget {
  @override
  _ResumeScreenState createState() => _ResumeScreenState();
}

class _ResumeScreenState extends State<ResumeScreen> {
  // List<Map<String, dynamic>> uploadedResumes = [];
  double uploadProgress = 0.0;
  bool isUploading = false;
  String? userID;
  String? Token;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Token = preferences.getString('token');
    userID = preferences.getString('userid');
    setState(() {
      Token;
      userID;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserProvider>().fetchResume(
            userID.toString(), // User ID
            Token.toString(),
          );
    });
  }

  bool isSelected = false;

  String truncateString(String text) {
    if (text.length > 22) {
      return text.substring(0, 22) + '...';
    }
    return text;
  }

  // Function to pick a resume and validate its size
  Future<void> _pickResume() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'], // Only allow PDF files
    );

    if (result != null) {
      PlatformFile file = result.files.first;

      // Ensure the file name includes the extension
      String fileName = file.name;
      String? fileExtension = file.name.split('.').last.toLowerCase();

      // If the file name does not include an extension, append it
      if (!fileName.contains('.')) {
        fileName = "$fileName.${fileExtension}";
      }

      // Validate the file extension
      if (fileExtension != 'pdf') {
        Fluttertoast.showToast(
          msg: "Only PDF files are allowed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        return;
      }

      // Check if the file size exceeds 5MB (5 * 1024 * 1024 bytes)
      if (file.size > 5 * 1024 * 1024) {
        Fluttertoast.showToast(
          msg: "Your file size is more than 5 MB",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else {
        // Proceed with upload
        setState(() {
          isUploading = true;
        });

        // Simulate upload
        _simulateUpload(file);

        WidgetsBinding.instance.addPostFrameCallback((_) {
          context.read<UserProvider>().uploadResume(
                userID.toString(),
                Token.toString(),
                file,
              );
        });
      }
    } else {
      // Show popup for no file selected
      Fluttertoast.showToast(
        msg: "No file selected",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  // Future<void> _pickResume() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //     type: FileType.custom,
  //     allowedExtensions: ['pdf'], // Only allow PDF files
  //   );

  //   if (result != null) {
  //     PlatformFile file = result.files.first;

  //     // Check if the file size exceeds 5MB (5 * 1024 * 1024 bytes)
  //     if (file.size > 5 * 1024 * 1024) {
  //       // Show popup if the file size exceeds 5 MB
  //       Fluttertoast.showToast(
  //         msg: "Your file size is more than 5 MB",
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.BOTTOM,
  //         timeInSecForIosWeb: 1,
  //         backgroundColor: Colors.black,
  //         textColor: Colors.white,
  //         fontSize: 16.0,
  //       );
  //     } else {
  //       // Proceed with upload
  //       setState(() {
  //         isUploading = true;
  //       });

  //       // Simulate upload
  //       _simulateUpload(file);
  //       WidgetsBinding.instance.addPostFrameCallback((_) {
  //         context
  //             .read<UserProvider>()
  //             .uploadResume(userID.toString(), Token.toString(), file);
  //       });

  //       // uploadResume(userID.toString(), Token.toString(), file);
  //     }
  //   } else {
  //     // Show popup for no file selected
  //     Fluttertoast.showToast(
  //       msg: "No file selected",
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.BOTTOM,
  //       timeInSecForIosWeb: 1,
  //       backgroundColor: Colors.black,
  //       textColor: Colors.white,
  //       fontSize: 16.0,
  //     );
  //   }
  // }

  Future<void> _simulateUpload(PlatformFile file) async {
    for (int i = 1; i <= 10; i++) {
      await Future.delayed(Duration(milliseconds: 300));
      setState(() {
        uploadProgress = i / 10;
      });
    }
    context.read<UserProvider>().fetchResume(
          userID.toString(), // User ID
          Token.toString(),
        );

    setState(() {
      // uploadedResumes.add({
      //   'name': file.name,
      //   'size': (file.size / 1024).toStringAsFixed(2) + " KB",
      // });
      isUploading = false;
      uploadProgress = 0.0;
    });
  }

  void _removeResume(int index) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserProvider>().DeteleResume(
          userID.toString(), // User ID
          Token.toString(),
          index.toString());
    });
    setState(() {
      // resumelis.removeAt(index);
    });
  }

  // Track the selected resume
  int? selectedResumeIndex;
  // Select resume and navigate to submit application page
  void _selectResume(int index) {
    if (selectedResumeIndex == index) {
      setState(() {
        isSelected = true;
      });
    } else {
      setState(() {
        selectedResumeIndex = index;
      });
    }

    // Navigate to submit application page and pass the selected resume data
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
    final resumelis = provider.Resumelist;

    return Scaffold(
      appBar: AppBar(
          title: Text('Resume',
              // Text('Apply for Job',
              style: GoogleFonts.manrope(
                  color: ColorConstant.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold)),
          // centerTitle: true,
          // actions: [
          //   IconButton(
          //     icon: Icon(Icons.more_vert),
          //     onPressed: () {},
          //   )
          // ],
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (resumelis.isNotEmpty) ...[
                    // Align(
                    //   alignment: Alignment.centerLeft,
                    //   child: Text(
                    //     "Resumes",
                    //     style: GoogleFonts.manrope(
                    //         fontSize: 16,
                    //         fontWeight: FontWeight.bold,
                    //         color: ColorConstant.black),
                    //   ),
                    // ),
                    SizedBox(height: 8),
                    Expanded(
                      child: ListView.builder(
                        physics: AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: resumelis.length,
                        itemBuilder: (context, index) {
                          isSelected =
                              selectedResumeIndex == index; // Check if selected
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: GestureDetector(
                              onTap: () =>
                                  _selectResume(index), // Select resume on tap
                              child: Container(
                                  // height: 56,
                                  decoration: BoxDecoration(
                                    color: ColorConstant
                                        .precentage, // Highlight selected
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: ColorConstant.botton,
                                        width: 1) // Border for selected item
                                    ,
                                  ),
                                  // decoration: BoxDecoration(
                                  //   color: isSelected
                                  //       ? ColorConstant.scalecolor
                                  //       : ColorConstant
                                  //           .precentage, // Highlight selected
                                  //   borderRadius: BorderRadius.circular(16),
                                  //   border: isSelected
                                  //       ? Border.all(
                                  //           color: ColorConstant.botton,
                                  //           width:
                                  //               2) // Border for selected item
                                  //       : null,
                                  // ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 12.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset(
                                              'assets/images/pdf-glyph.png',
                                              height: 24,
                                              width: 24,
                                              fit: BoxFit.contain,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  truncateString(
                                                      resumelis[index]
                                                          ['file_name']),
                                                  style: GoogleFonts.manrope(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12),
                                                ),
                                                Text(
                                                  dateconverter(resumelis[index]
                                                          ['uploaddate']
                                                      .toString()),
                                                  style: GoogleFonts.manrope(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: ColorConstant
                                                          .lightblack,
                                                      fontSize: 10),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        // subtitle: Text(uploadedResumes[index]['size']!),
                                        Row(
                                          children: [
                                            IconButton(
                                                icon: Icon(Icons.close,
                                                    color:
                                                        ColorConstant.botton),
                                                onPressed: () {
                                                  _showDeleteDialog(
                                                      context,
                                                      index,
                                                      resumelis[index]['id']!);
                                                }
                                                //  () => _removeResume(index),
                                                ),
                                            IconButton(
                                              icon: Icon(
                                                  Icons.remove_red_eye_sharp,
                                                  color: ColorConstant.botton),
                                              onPressed: () => Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        PdfPreviewPage(
                                                            pdfUrl: "${ApiConstants.baseUrl}" +
                                                                resumelis[index]
                                                                    [
                                                                    'resume']!)),
                                              ), // Replace `NewPage` with the page you want to navigate to

                                              //  _showDeleteDialog(context,
                                              //     index, resumelis[index]['id']!),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )),
                            ),
                          );
                        },
                      ),
                    ),
                    // Expanded(
                    //   child: ListView.builder(
                    //     itemCount: uploadedResumes.length,
                    //     itemBuilder: (context, index) {
                    //       return Padding(
                    //         padding: const EdgeInsets.symmetric(vertical: 4.0),
                    //         child: Container(
                    //           decoration: BoxDecoration(
                    //             color: ColorConstant.precentage,
                    //             borderRadius: BorderRadius.circular(8),
                    //           ),
                    //           child: ListTile(
                    //             leading: Icon(Icons.picture_as_pdf,
                    //                 color: ColorConstant.botton),
                    //             title: Text(
                    //               uploadedResumes[index]['name'],
                    //               style: GoogleFonts.manrope(fontWeight: FontWeight.bold),
                    //             ),
                    //             subtitle: Text(uploadedResumes[index]['size']),
                    //             trailing: IconButton(
                    //               icon:
                    //                   Icon(Icons.close, color: ColorConstant.botton),
                    //               onPressed: () => _removeResume(index),
                    //             ),
                    //           ),
                    //         ),
                    //       );
                    //     },
                    //   ),
                    // ),
                  ],
                  if (isUploading)
                    Column(
                      children: [
                        CustomPaint(
                          painter: DottedBorderPainter(),
                          child: LinearPercentIndicator(
                            lineHeight: 60.0,
                            percent: uploadProgress,
                            center: Text(
                              "Uploading " +
                                  "${(uploadProgress * 100).toInt()}%",
                              style: GoogleFonts.manrope(
                                fontSize: 12.0,
                                color: ColorConstant
                                    .botton, // Complete text in blue
                              ),
                            ),
                            linearStrokeCap: LinearStrokeCap.round,
                            backgroundColor: ColorConstant
                                .transparent, // Light blue background
                            progressColor:
                                ColorConstant.precentage, // Color for progress
                          ),
                        ),
                        // LinearPercentIndicator(
                        //   lineHeight: 60.0,
                        //   percent: uploadProgress,
                        //   center: Text(
                        //     "Uploading " + "${(uploadProgress * 100).toInt()}%",
                        //     style: GoogleFonts.manrope(
                        //         fontSize: 12.0, color: ColorConstant.botton),
                        //   ),
                        //   linearStrokeCap: LinearStrokeCap.round,
                        //   backgroundColor: ColorConstant.white,
                        //   progressColor: ColorConstant.precentage,
                        // ),
                        SizedBox(height: 16),
                        InkWell(
                          onTap: () {
                            setState(() {
                              isUploading = false;
                              uploadProgress = 0.0;
                            });
                          },
                          child: Container(
                            height: 56,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1, color: ColorConstant.bordercolor),
                                borderRadius: BorderRadius.circular(100)),
                            child: Center(
                              child: Text(
                                "Cancel",
                                style: GoogleFonts.manrope(
                                    fontSize: 16,
                                    color: ColorConstant.bordercolor),
                              ),
                            ),
                          ),
                        ),
                        // ElevatedButton(
                        //   onPressed: () {

                        //   },
                        //   style: ElevatedButton.styleFrom(
                        //     backgroundColor: ColorConstant.lightblack,
                        //   ),
                        //   child: Text("Cancel"),
                        // ),
                      ],
                    )
                  else if (resumelis.isEmpty)
                    InkWell(
                      onTap: _pickResume,
                      child: Container(
                        height: 56,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 0.5, color: ColorConstant.bordercolor),
                            borderRadius: BorderRadius.circular(16)),
                        child: Center(
                          child: Text(
                            "+ Upload Resume",
                            style: GoogleFonts.manrope(
                                fontSize: 16,
                                color: ColorConstant.botton,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )
                  else if (resumelis.isNotEmpty && resumelis.length <= 4)
                    InkWell(
                      onTap: _pickResume,
                      child: Container(
                        height: 56,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 0.5, color: ColorConstant.bordercolor),
                            borderRadius: BorderRadius.circular(16)),
                        child: Center(
                          child: Text(
                            "+ Upload Resume",
                            style: GoogleFonts.manrope(
                                fontSize: 16,
                                color: ColorConstant.botton,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),

                  // if (resumelis.isNotEmpty) SizedBox(height: 16),
                  // if (resumelis.isNotEmpty && widget.SelectRemume == "No")
                  //   ElevatedButton(
                  //     onPressed: () {
                  //       Navigator.pop(context);
                  //     },
                  //     style: ElevatedButton.styleFrom(
                  //       backgroundColor: ColorConstant.botton,
                  //       minimumSize: Size(double.infinity, 56),
                  //     ),
                  //     child: Text("Add Resume in Portfolio",
                  //         // Text("Submit Application",
                  //         style: GoogleFonts.manrope(
                  //             fontSize: 16,
                  //             color: ColorConstant.white,
                  //             fontWeight: FontWeight.bold)),
                  //   ),
                  // if (widget.SelectRemume == "Yes")
                  //   ElevatedButton(
                  //     onPressed: () {
                  //       if (selectedResumeIndex != null) {
                  //         Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //               builder: (context) =>
                  //                   ApplyJobSecussScreen()), // Replace `NewPage` with the page you want to navigate to
                  //         );
                  //       } else {
                  //         Fluttertoast.showToast(
                  //           msg: "Please Select Resume",
                  //           toastLength: Toast.LENGTH_SHORT,
                  //           gravity: ToastGravity.TOP, // Show toast at the top
                  //           timeInSecForIosWeb: 1,
                  //           backgroundColor: ColorConstant.red,
                  //           textColor: ColorConstant.white,
                  //           fontSize: 16.0,
                  //         );
                  //       }
                  //     },
                  //     style: ElevatedButton.styleFrom(
                  //       backgroundColor: ColorConstant.botton,
                  //       minimumSize: Size(double.infinity, 56),
                  //     ),
                  //     child: Text("Choose Resume",
                  //         // Text("Submit Application",
                  //         style: GoogleFonts.manrope(
                  //             fontSize: 16,
                  //             color: ColorConstant.white,
                  //             fontWeight: FontWeight.bold)),
                  //   ),
                ],
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
          context
              .read<UserProvider>()
              .DeteleResume(
                  userID.toString(), // User ID
                  Token.toString(),
                  id.toString())
              .then((_) {
            //get resume
            context.read<UserProvider>().fetchResume(
                  userID.toString(), // User ID
                  Token.toString(),
                );
          }).catchError((error) {
            // Handle error if needed
            print("Error: $error");
          });
        });
      },
    );
  }
}

class DottedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.blue // Color for the dotted border
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    double dashWidth = 6.0;
    double dashSpace = 4.0;
    double startX = 0.0;
    double startY = 0.0;

    // Draw top border
    while (startX < size.width) {
      canvas.drawLine(
          Offset(startX, startY), Offset(startX + dashWidth, startY), paint);
      startX += dashWidth + dashSpace;
    }

    startX = 0.0;
    startY = size.height;

    // Draw bottom border
    while (startX < size.width) {
      canvas.drawLine(
          Offset(startX, startY), Offset(startX + dashWidth, startY), paint);
      startX += dashWidth + dashSpace;
    }

    startX = 0.0;
    startY = 0.0;

    // Draw left border
    while (startY < size.height) {
      canvas.drawLine(
          Offset(startX, startY), Offset(startX, startY + dashWidth), paint);
      startY += dashWidth + dashSpace;
    }

    startX = size.width;
    startY = 0.0;

    // Draw right border
    while (startY < size.height) {
      canvas.drawLine(
          Offset(startX, startY), Offset(startX, startY + dashWidth), paint);
      startY += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
