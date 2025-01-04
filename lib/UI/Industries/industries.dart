// ignore_for_file: sized_box_for_whitespace, non_constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_application/Common/Contant.dart';
import 'package:job_application/Common/Url.dart';
import 'package:job_application/Core/Provider.dart';
import 'package:job_application/UI/Home/HomeScreen.dart';
import 'package:job_application/UI/Industries/IndustryListScreen.dart';
import 'package:job_application/UI/Notifications/notifications.dart';
import 'package:job_application/UI/Saved/Allpostedjob.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IndustriesScreen extends StatefulWidget {
  const IndustriesScreen({super.key});

  @override
  State<IndustriesScreen> createState() => _IndustriesScreenState();
}

class _IndustriesScreenState extends State<IndustriesScreen> {
  // final List<Map<String, String>> categories = [
  //   {"image": "assets/images/Design.png", "label": "Design"},
  //   {"image": "assets/images/Coding.png", "label": "Developer"},
  //   {"image": "assets/images/Internet.png", "label": "Network"},
  //   {"image": "assets/images/Task.png", "label": "Quality"},
  //   {"image": "assets/images/Sounding.png", "label": "Marketing"},
  //   {"image": "assets/images/Contract.png", "label": "Secretary"},
  //   {"image": "assets/images/Research.png", "label": "Analysis"},
  //   {"image": "assets/images/Menu.png", "label": "More"},
  // ];

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
      //get recent job
      context.read<UserProvider>().fetchindustries(
            userID.toString(), // User ID
            Token.toString(),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UserProvider>();
    final Industrieslist = provider.IdustriesList;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double boxsized = screenHeight * 0.02;
    return Scaffold(
      appBar: AppBar(
        title: Text('Industries',
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
          : Container(
              color: ColorConstant.white,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Align content to the left
                  children: [
                    SizedBox(height: boxsized),
                    Container(
                        width: double.infinity,
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics:
                              AlwaysScrollableScrollPhysics(), // Prevent scrolling within the grid
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3, // Number of columns
                            crossAxisSpacing: 12.0, // Horizontal spacing
                            mainAxisSpacing: 12.0, // Vertical spacing
                          ),
                          itemCount: Industrieslist.length,
                          itemBuilder: (context, index) {
                            final category = Industrieslist[index];
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => IndustryListScreen(
                                            industryid:
                                                category["id"].toString(),
                                            Indusryname:
                                                category["title"].toString(),
                                          )), // Replace `NewPage` with the page you want to navigate to
                                );
                              },
                              child: _buildCategory(
                                category["icon"] ?? '',
                                category["title"] ?? '',
                              ),
                            );
                          },
                        ))
                    // Container(
                    //   width: double.infinity,
                    //   child: Column(
                    //     children: [
                    //       // First row of categories
                    //       Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           _buildCategory("assets/images/Design.png", "Design"),
                    //           _buildCategory("assets/images/Coding.png", "Developer"),
                    //           _buildCategory("assets/images/Internet.png", "Network"),
                    //           _buildCategory("assets/images/Task.png", "Quality"),
                    //         ],
                    //       ),
                    //       SizedBox(height: boxsized),
                    //       // Second row of categories
                    //       Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         children: [
                    //           _buildCategory("assets/images/Sounding.png", "Marketing"),
                    //           _buildCategory("assets/images/Contract.png", "Secretary"),
                    //           _buildCategory("assets/images/Research.png", "Analysis"),
                    //           _buildCategory("assets/images/Menu.png", "More"),
                    //         ],
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
    );
  }

  //category
  Widget _buildCategory(String image, String name) {
    return Card(
      color: ColorConstant.white,
      // elevation: 05,
      child: Container(
        height: 70,
        width: 70,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 12,
            ),
            if (image != '')
              Center(
                child: Image.network(
                  "${ApiConstants.baseUrl}" + image,
                  height: 30,
                  width: 30,
                ),
              ),
            if (image == '')
              Center(
                child: Image.asset(
                  "assets/images/Task.png",
                  height: 30,
                  width: 30,
                ),
              ),
            SizedBox(
              height: 4,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  name,
                  textAlign: TextAlign.center, // Center-align the text
                  softWrap: true, // Allow wrapping to the next line
                  maxLines: 2, // Limit to two lines
                  overflow: TextOverflow
                      .ellipsis, // Truncate with ellipsis if text exceeds
                  style: GoogleFonts.manrope(
                    color: ColorConstant.category,
                    fontSize: 11,
                  ),
                ),
              ),
            ),

            // Center(
            //   child: Text(
            //     name,
            //     style: GoogleFonts.manrope(
            //       color: ColorConstant.category,
            //       // fontWeight: FontWeight.bold,
            //       fontSize: 11,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
