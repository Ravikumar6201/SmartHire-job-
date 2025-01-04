// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_application/Common/Contant.dart';
import 'package:job_application/UI/JobApply/JobDetails.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  int _counter = 0;

  // Function to reload the page (simulating a page reload)
  void reloadPage() {
    setState(() {
      // Reset state or change data to simulate reload
      _counter = 0; // Reset the counter for example
      // You can add other reset actions here
    });
  }

  String truncateText(
    String text,
  ) {
    int length = 60;
    if (text.length <= length) return text;
    return text.substring(0, length) + '';
  }

  final List<Map<String, String>> notifications = [
    {
      'title':
          'Crypto.com partners with Australian football league to reach millions of Australians',
      // 'description':
      //     'Crypto.com partners with Australian football league to reach millions of Australians...',
      'date': '10 OCT,2024',
      'time': '12:00 PM',
      'icon': 'assets/images/logo (6).png', // Replace with actual asset path
    },
    {
      'title':
          'The company\'s wait for electric vans keeps getting longer. Here whats behind delays',
      // 'description':
      //     'The company\'s wait for electric vans keeps getting longer. Here\'s what\'s behind delays...',
      'date': '10 OCT,2024',
      'time': '11:00 AM',
      'icon': 'assets/images/logo (7).png', // Replace with actual asset path
    },
    {
      'title':
          'Cardano is looking for: Haskell Plutus Developers. Check out these and 4 other jobs',
      'date': '10 OCT,2024',
      // 'description':
      //     'Cardano is looking for: Haskell / Plutus Developers. Check out these and 4 other jobs...',
      'time': '09:00 AM',
      'icon': 'assets/images/logo (7).png', // Replace with actual asset path
    },
    // Add more notifications as needed
    {
      'title':
          'Crypto.com partners with Australian football league to reach millions of Australians',
      // 'description':
      //     'Crypto.com partners with Australian football league to reach millions of Australians...',
      'date': '10 OCT,2024',
      'time': '12:00 PM',
      'icon': 'assets/images/logo (6).png', // Replace with actual asset path
    },
    {
      'title':
          'The company\'s wait for electric vans keeps getting longer. Here whats behind delays',
      // 'description':
      //     'The company\'s wait for electric vans keeps getting longer. Here\'s what\'s behind delays...',
      'date': '10 OCT,2024',
      'time': '11:00 AM',
      'icon': 'assets/images/logo (7).png', // Replace with actual asset path
    },
    {
      'title':
          'Cardano is looking for: Haskell Plutus Developers. Check out these and 4 other jobs',
      'date': '10 OCT,2024',
      // 'description':
      //     'Cardano is looking for: Haskell / Plutus Developers. Check out these and 4 other jobs...',
      'time': '09:00 AM',
      'icon': 'assets/images/logo (7).png', // Replace with actual asset path
    },
    // Add more notifications as needed
    {
      'title':
          'Crypto.com partners with Australian football league to reach millions of Australians',
      // 'description':
      //     'Crypto.com partners with Australian football league to reach millions of Australians...',
      'date': '10 OCT,2024',
      'time': '12:00 PM',
      'icon': 'assets/images/logo (6).png', // Replace with actual asset path
    },
    {
      'title':
          'The company\'s wait for electric vans keeps getting longer. Here whats behind delays',
      // 'description':
      //     'The company\'s wait for electric vans keeps getting longer. Here\'s what\'s behind delays...',
      'date': '10 OCT,2024',
      'time': '11:00 AM',
      'icon': 'assets/images/logo (7).png', // Replace with actual asset path
    },
    {
      'title':
          'Cardano is looking for: Haskell Plutus Developers. Check out these and 4 other jobs',
      'date': '10 OCT,2024',
      // 'description':
      //     'Cardano is looking for: Haskell / Plutus Developers. Check out these and 4 other jobs...',
      'time': '09:00 AM',
      'icon': 'assets/images/logo (7).png', // Replace with actual asset path
    },
    // Add more notifications as needed
  ];

  Future<void> openNotificationSettings() async {
    try {
      final status = await Permission.notification.status;

      if (status.isGranted) {
        print("Notification permission is already granted.");
      } else if (status.isDenied || status.isPermanentlyDenied) {
        // Request permission
        final result = await Permission.notification.request();
        if (result.isGranted) {
          print("Notification permission granted.");
        } else {
          print("Notification permission denied.");
        }
      }
    } catch (e) {
      print("Error checking notification permission: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications',
            style: GoogleFonts.manrope(
                color: ColorConstant.black,
                fontSize: 16,
                fontWeight: FontWeight.bold)),
        backgroundColor: ColorConstant.white,
        elevation: 0,
        iconTheme: IconThemeData(color: ColorConstant.black),
        actions: [
          PopupMenuButton<String>(
            color: ColorConstant.white,
            onSelected: (value) {
              if (value == 'Clear all') {
                // setState(() {
                showClearNotificationsPopup(context);
                // Navigator.of(context).pop();
                // if (selectedTab == 'Company') {
                //   notifications.clear();
                // } else {
                //   jobAlerts.clear();
                // }
                // });
              } else if (value == 'Turn off notifications') {
                // Implement turn off notifications functionality here
                openNotificationSettings();
              } else {
                Fluttertoast.showToast(
                  msg: "Marked as real all notification",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.TOP, // Show toast at the top
                  timeInSecForIosWeb: 1,
                  backgroundColor: ColorConstant.green,
                  textColor: ColorConstant.white,
                  fontSize: 16.0,
                );
              }
            },
            itemBuilder: (BuildContext context) {
              return {'Mark as read', 'Turn off notifications', 'Clear all'}
                  .map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
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
        ),
      ),
      body: Container(
        color: ColorConstant.white,
        child: ListView.builder(
          // padding: const EdgeInsets.symmetric(vertical: 2),
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              child: InkWell(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => JobDetailsScreen(
                  //       listid: '',
                  //       page: '',
                  //     ),
                  //   ),
                  // );
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: ColorConstant.white,
                    borderRadius: BorderRadius.circular(12),
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: ColorConstant.black,
                    //     blurRadius: 4,
                    //     offset: Offset(0, 2),
                    //   ),
                    // ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 04,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Icon Section
                            CircleAvatar(
                              radius: 20,
                              backgroundImage: AssetImage(
                                notifications[index]['icon']!,
                              ),
                              //   backgroundImage: NetworkImage(
                              //       'https://cdn.pixabay.com/photo/2015/03/03/18/58/girl-657753_1280.jpg'),
                            ),
                            // Container(
                            //   width: 40,
                            //   height: 40,
                            //   decoration: BoxDecoration(
                            //     color: ColorConstant.lightblack,
                            //     borderRadius: BorderRadius.circular(50),
                            //   ),
                            //   child: Image.asset(
                            //     notifications[index]['icon']!,
                            //     fit: BoxFit.cover,
                            //   ),
                            // ),
                            const SizedBox(width: 12),
                            // Text Section
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    truncateText(
                                      notifications[index]['title']!,
                                    ),
                                    style: GoogleFonts.manrope(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: ColorConstant.black),
                                  ),
                                  // const SizedBox(height: 4),
                                  // Description Text
                                  // Text(
                                  //   truncateText(
                                  //     notifications[index]['description']!,
                                  //   ),
                                  //   style: GoogleFonts.manrope(
                                  //       fontSize: 12,
                                  //       color: ColorConstant.lightblack),
                                  // ),
                                  SizedBox(
                                    height: 04,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        notifications[index]['date']!,
                                        style: GoogleFonts.manrope(
                                          fontSize: 12,
                                          color: ColorConstant.lightblack,
                                        ),
                                      ),
                                      Text(
                                        notifications[index]['time']!,
                                        style: GoogleFonts.manrope(
                                          fontSize: 12,
                                          color: ColorConstant.lightblack,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          width: double.infinity,
                          height: 1.5,
                          color: ColorConstant.bordercolor,
                        )
                        // Divider()
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ), // Column(
      //   children: [
      //     Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: [
      //           _buildTabButton('Company'),
      //           SizedBox(width: 8),
      //           _buildTabButton('Alert Jobs'),
      //         ],
      //       ),
      //     ),
      //     Expanded(
      //       child: selectedTab == 'Company'
      //           ? _buildNotificationList(companyNotifications,
      //               isJobAlert: false)
      //           : _buildNotificationList(jobAlerts, isJobAlert: true),
      //     ),
      //   ],
      // ),
    );
  }

  void showClearNotificationsPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          // backgroundColor: ColorConstant.transparent,
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
                        "Are you sure you want to clear all notifications?",
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
                                // Perform clear notifications action
                                notifications.clear();
                                reloadPage();
                                Navigator.of(context).pop();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorConstant.botton,
                                padding: EdgeInsets.symmetric(vertical: 16),
                              ),
                              child: Text(
                                "Yes",
                                style: GoogleFonts.manrope(
                                    color: ColorConstant.white, fontSize: 14),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
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
                                "Cancel",
                                style: GoogleFonts.manrope(
                                    color: ColorConstant.black, fontSize: 14),
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
}
