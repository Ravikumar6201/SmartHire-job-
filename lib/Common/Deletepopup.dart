// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_application/Common/Contant.dart';

class DialogUtils {
  static void showDeleteConfirmationDialog({
    required BuildContext context,
    required VoidCallback onDelete,
    String title = 'Confirm Deletion',
    required String content,
    Color? backgroundColor,
    TextStyle? titleStyle,
    TextStyle? contentStyle,
    TextStyle? cancelStyle,
    TextStyle? deleteStyle,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16), // Rounded corners
          ),
          backgroundColor:
              backgroundColor ?? ColorConstant.white, // Default white
          child: Container(
            height: 330,
            // width: 330,
            decoration: BoxDecoration(
                color: ColorConstant.white,
                border: Border.all(width: 1, color: ColorConstant.bordercolor),
                borderRadius: BorderRadius.circular(20)),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Delete " + content + "?",
                            style: titleStyle ??
                                GoogleFonts.manrope(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: ColorConstant.black,
                                ),
                          ),
                          InkWell(
                            onTap: () => Navigator.pop(context),
                            child: Icon(
                              Icons.close,
                              size: 24,
                              color: ColorConstant.bootombar,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Image.asset(
                        'assets/images/delete.png',
                        height: 88,
                        width: 88,
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          // text: "Do you really want to delete this skill? ",
                          // style: TextStyle(
                          //   fontSize: 14,
                          //   color: Colors.black,
                          //   fontWeight: FontWeight.w500,
                          // ),
                          children: [
                            // TextSpan(
                            //   text: "The data will be permanently deleted.",
                            //   style: TextStyle(
                            //     fontSize: 14,
                            //     color: Colors.grey,
                            //     fontWeight: FontWeight.normal,
                            //   ),
                            // ),
                            TextSpan(
                              text: "Do you really want to delete this ",
                              style: GoogleFonts.manrope(
                                fontSize: 16,
                                color: ColorConstant.black,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            TextSpan(
                              text: content + '?',
                              style: GoogleFonts.manrope(
                                fontSize: 16,
                                color: ColorConstant.black,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            // TextSpan(
                            //   text: "The data will be permanently deleted.",
                            //   style: GoogleFonts.manrope(
                            //     fontSize: 12,
                            //     color: ColorConstant.bootombar,
                            //     fontWeight: FontWeight.normal,
                            //   ),
                            // ),
                            // TextSpan(
                            //   text: "The data will be permanently deleted.",
                            //   style: TextStyle(
                            //     fontSize: 14,
                            //     color: Colors.grey,
                            //     fontWeight: FontWeight.normal,
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      Text(
                        "The data will be permanently deleted.",
                        style: GoogleFonts.manrope(
                          fontSize: 12,
                          color: ColorConstant.bootombar,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      // Buttons
                      SizedBox(
                        height: 24,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                                'Cancel',
                                style: cancelStyle ??
                                    GoogleFonts.manrope(
                                      color: ColorConstant.lightblack,
                                      fontSize: 14,
                                    ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                                onDelete(); // Execute delete logic
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorConstant.botton,
                                padding: EdgeInsets.symmetric(vertical: 16),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset('assets/images/trash.png'),
                                  Text(
                                    'Delete',
                                    style: deleteStyle ??
                                        GoogleFonts.manrope(
                                          color: ColorConstant.white,
                                          fontSize: 14,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Text(
          //   content,
          //   style: contentStyle ??
          //       GoogleFonts.manrope(
          //         fontSize: 16,
          //         color: ColorConstant.lightblack,
          //       ),
          // ),
        );
      },
    );
  }
}

void showDeleteSkillPopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        titlePadding: EdgeInsets.only(top: 20, left: 20, right: 20),
        contentPadding: EdgeInsets.symmetric(horizontal: 20),
        title: Center(
          child: Column(
            children: [
              Icon(
                Icons.delete_forever,
                size: 50,
                color: Colors.orange,
              ),
              SizedBox(height: 16),
              Text(
                "Delete skill?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        content: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: "Do you really want to delete this skill? ",
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
            children: [
              TextSpan(
                text: "The data will be permanently deleted.",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
        actionsPadding: EdgeInsets.symmetric(horizontal: 20),
        actions: [
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: BorderSide(color: Colors.grey.shade300),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "Cancel",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // Perform delete action
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text("Delete"),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}
