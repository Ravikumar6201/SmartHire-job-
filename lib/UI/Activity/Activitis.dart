// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_application/Common/Contant.dart';
import 'package:job_application/Core/Provider.dart';
import 'package:job_application/UI/Activity/activitywidget.dart';
import 'package:job_application/UI/Home/HomeScreen.dart';
import 'package:job_application/UI/JobApply/JobDetails.dart';
import 'package:job_application/UI/Notifications/notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ActivityScreen extends StatefulWidget {
  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;

  // List of tab items
  final List<String> listData = ['Applied', 'Shortlisted'];

  @override
  void initState() {
    super.initState();
    UserProfile();
  }

  String? Token;
  String? userID;
  bool finalfatchedapplied = false;
  bool finalfatchedshort = false;
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
      context
          .read<UserProvider>()
          .fetchAppliedData(
              userID.toString(), // User ID
              Token.toString(),
              'applied')
          .then((value) {
        setState(() {
          finalfatchedapplied = true;
        });
        print("Shortlist data fetched successfully");
      }).catchError((error) {
        // Handle any errors
        print("Error fetching shortlist data: $error");
      });
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Fetch recent job
      context
          .read<UserProvider>()
          .fetchShortlistData(
            userID.toString(), // User ID
            Token.toString(),
            'shortlist',
          )
          .then((value) {
        setState(() {
          finalfatchedshort = true;
        });
        print("Shortlist data fetched successfully");
      }).catchError((error) {
        // Handle any errors
        print("Error fetching shortlist data: $error");
      });
    });
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   //get recent job
    //   context.read<UserProvider>().fetchShortlistData(
    //       userID.toString(), // User ID
    //       Token.toString(),
    //       'shortlist').then(){

    //       }
    //       ;
    // });
  }

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
    print("Selected tab: ${listData[index]}");
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UserProvider>();
    final appliedlist = provider.AppliedList;
    final shortlistlist = provider.ShortlistedList;
    return Scaffold(
      appBar: AppBar(
        title: Text('Activities',
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
          : Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: List.generate(listData.length, (index) {
                      return Expanded(
                        child: GestureDetector(
                          onTap: () => _onTabSelected(index),
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 8),
                            padding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 20),
                            decoration: BoxDecoration(
                              color: _selectedIndex == index
                                  ? ColorConstant.backgroundColor
                                  : ColorConstant.white,
                              border:
                                  Border.all(color: ColorConstant.lightblack),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Center(
                              child: Text(
                                listData[index],
                                style: GoogleFonts.manrope(
                                    color: _selectedIndex == index
                                        ? ColorConstant.white
                                        : ColorConstant.lightblack,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  if (_selectedIndex == 0 && appliedlist.isNotEmpty)
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount:
                            appliedlist.length, // Adjust item count as needed
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => JobDetailsScreen(
                                        listid: appliedlist[index]['id'] ?? '',
                                        page: 'tests',
                                      ),
                                    ),
                                  ).then((onValue) {
                                    UserProfile();
                                  });
                                },
                                child: Card(
                                  elevation: 5,
                                  color: ColorConstant.white,
                                  child: ActivityCard(
                                    companyLogo: Icons.cloud,
                                    icon: appliedlist[index]['company_logo'],
                                    // 'assets/images/share-01.png',
                                    iconcolor: ColorConstant.botton,
                                    buttoncolor:
                                        ColorConstant.appliedbuttonback,
                                    buttonTextcolor:
                                        ColorConstant.appliedbuttonText,
                                    companyName: appliedlist[index]
                                        ['company_name'],
                                    jobTitle: appliedlist[index]['title'] ?? '',
                                    jobcity: appliedlist[index]['city'] ?? '',
                                    location: appliedlist[index]
                                            ['job_location'] ??
                                        '',
                                    jobType:
                                        appliedlist[index]['job_type'] ?? '',
                                    description: appliedlist[index]
                                        ['short_description'],
                                    // "We are looking for UX Designer Role, you can apply here. Good taste is a plus for this role.",
                                    applicants: 'Applied',
                                    views: '456',
                                    timestamp: "Applied at " +
                                            appliedlist[index]['applied_at'] ??
                                        '',
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  if (_selectedIndex == 0 &&
                      appliedlist.isEmpty &&
                      finalfatchedapplied == true)
                    Expanded(
                        child: Center(
                      child: Text(
                        "Data Not Found",
                        style: GoogleFonts.manrope(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )),
                  if (_selectedIndex == 1 && shortlistlist.isNotEmpty)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: shortlistlist
                              .length, // Adjust item count as needed
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => JobDetailsScreen(
                                          listid:
                                              shortlistlist[index]['id'] ?? '',
                                          page: 'tests',
                                        ),
                                      ),
                                    ).then((onValue) {
                                      UserProfile();
                                    });
                                  },
                                  child: Card(
                                    elevation: 5,
                                    color: ColorConstant.white,
                                    child: ActivityCard(
                                      companyLogo: Icons.cloud,
                                      icon: shortlistlist[index]
                                          ['company_logo'],
                                      // 'assets/images/share-01.png',
                                      iconcolor: ColorConstant.botton,
                                      buttoncolor:
                                          ColorConstant.appliedbuttonback,
                                      buttonTextcolor:
                                          ColorConstant.backcolointerviewtext,
                                      companyName: shortlistlist[index]
                                          ['company_name'],
                                      jobTitle: shortlistlist[index]['title'],
                                      jobcity: appliedlist[index]['city'] ?? '',
                                      location: appliedlist[index]
                                              ['job_location'] ??
                                          '',
                                      jobType: shortlistlist[index]['job_type'],
                                      description: shortlistlist[index]
                                          ['short_description'],
                                      // "We are looking for UX Designer Role, you can apply here. Good taste is a plus for this role.",
                                      applicants: 'Shortlisted',
                                      views: '456',
                                      timestamp: "Applied at " +
                                              shortlistlist[index]
                                                  ['applied_at'] ??
                                          '',
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  if (_selectedIndex == 1 &&
                      shortlistlist.isEmpty &&
                      finalfatchedshort == true)
                    Expanded(
                        child: Center(
                      child: Text(
                        "Data Not Found",
                        style: GoogleFonts.manrope(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ))
                ],
              ),
            ),
      // TabBarView(
      //   controller: _tabController,
      //   children: [
      //     JobListTab(status: "All Status"),
      //     JobListTab(status: "Applied"),
      //     JobListTab(status: "Reviewed"),
      //     JobListTab(status: "Interview"),
      //     JobListTab(status: "Rejected"),
      //   ],
      // ),
    );
  }
}
