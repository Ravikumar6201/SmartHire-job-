// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_application/Common/Contant.dart';
import 'package:job_application/Core/Provider.dart';
import 'package:job_application/UI/Home/HomeScreen.dart';
import 'package:job_application/UI/JobApply/JobDetails.dart';
import 'package:job_application/UI/Notifications/notifications.dart';
import 'package:job_application/UI/Saved/Recentjob.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IndustryListScreen extends StatefulWidget {
  String industryid, Indusryname;
  @override
  IndustryListScreen({required this.industryid, required this.Indusryname});

  @override
  State<IndustryListScreen> createState() => _IndustryListScreenState();
}

class _IndustryListScreenState extends State<IndustryListScreen> {
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
      context.read<UserProvider>().fetchindustriesByID(
            userID.toString(), // User ID
            widget.industryid,
            Token.toString(),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UserProvider>();
    final IndustriryList = provider.IdustriesListByID;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.Indusryname.toString(),
          style: GoogleFonts.manrope(
            color: ColorConstant.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      HomeScreen()), // Replace with your desired screen
            );
          },
          child: Image.asset(
            'assets/images/backarrow.png',
            height: 120,
            width: 120,
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
                MaterialPageRoute(builder: (context) => NotificationScreen()),
              );
            },
            child: Padding(
              padding: EdgeInsets.only(right: 20),
              child: Image.asset(
                'assets/images/bell.png',
                height: 30,
                width: 30,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
      body: provider.isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: ColorConstant.botton,
              ),
            )
          : (IndustriryList.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.builder(
                    // Use AlwaysScrollableScrollPhysics for smooth scroll
                    physics: AlwaysScrollableScrollPhysics(),
                    itemCount: IndustriryList.length,
                    itemBuilder: (context, index) {
                      var recentlist = IndustriryList[index];
                      return Card(
                        elevation: 5,
                        color: ColorConstant.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => JobDetailsScreen(
                                      listid: recentlist['id'] ?? '',
                                      page: 'tests',
                                    ),
                                  ),
                                ).then((onValue) {
                                  // Update profile or handle necessary logic after navigation
                                  UserProfile();
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: JobCardRecent(
                                  city: recentlist['city'] ?? '',
                                  country: recentlist['country'] ?? '',
                                  companyLogo: recentlist['company_logo'] ?? '',
                                  is_saved: recentlist['is_saved'] ?? false,
                                  companyName: recentlist['company_name'] ?? '',
                                  jobTitle: recentlist['title'] ?? '',
                                  location: recentlist['job_location'] ?? '',
                                  jobType: recentlist['job_type'] ?? '',
                                  description:
                                      recentlist['short_description'] ?? '',
                                  applicants: recentlist['no_applied'] ?? 0,
                                  views: recentlist['view'] ?? 0,
                                  timestamp: recentlist['saved_at'] ?? '',
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                )
              : Center(
                  child: Text(
                    "Data Not Found",
                    style: GoogleFonts.manrope(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )),
    );
  }
}
