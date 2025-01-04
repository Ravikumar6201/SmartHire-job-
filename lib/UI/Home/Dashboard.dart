// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, non_constant_identifier_names, avoid_print, avoid_unnecessary_containers, unused_import, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_application/Common/Contant.dart';
import 'package:job_application/Common/Url.dart';
import 'package:job_application/Core/Provider.dart';
import 'package:job_application/UI/Home/Search.dart';
import 'package:job_application/UI/Industries/IndustryListScreen.dart';
import 'package:job_application/UI/Industries/industries.dart';
import 'package:job_application/UI/JobApply/JobDetails.dart';
import 'package:job_application/UI/JobApply/jobdetailsdummy.dart';
import 'package:job_application/UI/Notifications/notifications.dart';
import 'package:job_application/UI/JobApply/Popularjobs.dart';
import 'package:job_application/UI/Saved/Allpostedjob.dart';
import 'package:job_application/UI/Saved/RecentJobsList.dart';
import 'package:job_application/UI/Saved/Recentjob.dart';
import 'package:job_application/UI/Saved/saved.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  // List of jobs (Map with three values)
  final List<Map<String, dynamic>> jobList = [
    {
      'companyLogo': 'assets/images/logo3.png', // Asset image for company logo
      'jobTitle': 'Sr. Product Designer',
      'companyName': 'Uniswap',
      'location': 'Anywhere',
    },
    {
      'companyLogo': 'assets/images/logo4.png', // Another example asset
      'jobTitle': 'Backend Engineer',
      'companyName': 'Spotify',
      'location': 'Remote',
    },
    {
      'companyLogo': 'assets/images/logo5.png', // Another example asset
      'jobTitle': 'Software Engineer',
      'companyName': 'Google',
      'location': 'Mountain View, CA',
    },
  ];

  final List<Map<String, dynamic>> recentList = [
    {
      'companyLogo': 'assets/images/Vector.png', // Icon for the company logo
      'icon': Icons.bookmark_border, // Additional icon
      'iconcolor': ColorConstant.lightblack, // Color for the icon
      'companyName': 'Dribbble',
      'jobTitle': 'UI Designer',
      'location': 'Jakarta, Indonesia',
      'jobType': 'Fulltime',
      'description':
          'We are looking for a UI Designer role. Good taste is a plus for this role.',
      'applicants': '80',
      'views': '456',
      'timestamp': '3h ago',
    },
    {
      'companyLogo': 'assets/images/Dropbox.png',
      'icon': Icons.bookmark_border,
      'iconcolor': ColorConstant.lightblack,
      'companyName': 'Spotify',
      'jobTitle': 'Backend Engineer',
      'location': 'Remote',
      'jobType': 'Part-time',
      'description': 'Backend Engineer with expertise in cloud technologies.',
      'applicants': '120',
      'views': '1,200',
      'timestamp': '5h ago',
    },
    {
      'companyLogo': 'assets/images/Spotify.png',
      'icon': Icons.bookmark_border,
      'iconcolor': ColorConstant.lightblack,
      'companyName': 'Google',
      'jobTitle': 'Software Engineer',
      'location': 'Mountain View, CA',
      'jobType': 'Fulltime',
      'description':
          'Join our team as a Software Engineer in a fast-paced environment.',
      'applicants': '220',
      'views': '2,000',
      'timestamp': '1d ago',
    },
    // Add more jobs as needed...
  ];

  final List<String> items = [
    'Apple',
    'Banana',
    'Grapes',
    'Orange',
    'Pineapple',
    'Watermelon',
    'Strawberry',
    'Mango',
    'Blueberry',
    'Raspberry',
    'Peach',
    'Cherry',
    'Lemon',
    'Lime',
    'Pomegranate',
    'Kiwi',
    'Papaya',
  ];

  List<String> suggestions = [];
  TextEditingController searchController = TextEditingController();

  void updateSuggestions(String query) {
    final List<String> newSuggestions = items
        .where((item) => item.toLowerCase().contains(query.toLowerCase()))
        .toList();

    setState(() {
      suggestions = newSuggestions;
    });
  }

  String selectedItem = 'Search...';

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
      context.read<UserProvider>().fetchrecentjob(
            userID.toString(), // User ID
            Token.toString(),
          );
    });
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
    final RecentJoblist = provider.RecentJobList;
    final Industrieslist = provider.IdustriesList;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double boxsized = screenHeight * 0.02;
    return Scaffold(
      appBar: AppBar(
        title: Text("SmartHire",
            style: GoogleFonts.manrope(
                fontSize: 16,
                color: ColorConstant.black,
                fontWeight: FontWeight.bold)),
        leading: Padding(
          padding: EdgeInsets.only(left: screenWidth * 0.02),
          child: Image.asset(
            "assets/images/Logo.png",
            height: 60,
            width: 80,
            fit: BoxFit.contain,
          ),
        ),
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
        backgroundColor: ColorConstant.white,
      ),
      body: provider.isLoading
          ? Center(
              child: CircularProgressIndicator(
              color: ColorConstant.botton,
            ))
          : Container(
              color: ColorConstant.white,
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // SizedBox(
                        //   height: boxsized,
                        // ),
                        //hide search
                        /* Card(
                          color: ColorConstant.white,
                          child: InkWell(
                            onTap: () async {
                              final result = await showSearch(
                                context: context,
                                delegate: ItemSearchDelegate(),
                              );
                              if (result != null && result.isNotEmpty) {
                                setState(() {
                                  selectedItem = result;
                                });
                              }
                            },
                            child: Container(
                              height: 56,
                              decoration: BoxDecoration(
                                  // border: Border.all(
                                  //     width: 1,
                                  //     color: ColorConstant.bordercolor),
                                  borderRadius: BorderRadius.circular(16)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 16),
                                        child: Image.asset(
                                            'assets/images/Search.png'),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 16),
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.vertical,
                                          child: Text(
                                            selectedItem,
                                            style: GoogleFonts.manrope(
                                                fontSize: 16,
                                                color:
                                                    ColorConstant.lightblack),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  InkWell(
                                    onTap: () => showFilterModal(context),
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 16),
                                      child: Image.asset(
                                        "assets/images/Filter.png",
                                        color: ColorConstant.lightblack,
                                        height: 24,
                                        width: 24,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),*/
                        /* InkWell(
                    onTap: () {},
                    child: TextField(
                      // controller: searchController,
                      // onChanged: (query) {
            
                      //   // suggestions = items;
                      //   // updateSuggestions(query);
                      // },
                      decoration: InputDecoration(
                          hintText: 'Search',
                          hintStyle: GoogleFonts.manrope(
                              color: ColorConstant.lightblack),
                          border: InputBorder.none, // Removes default border
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 14.0), // Vertical padding
            
                          // Prefix icon (search icon)
                          prefixIcon: Image.asset('assets/images/Search.png'),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0),
                            borderSide: BorderSide(
                              color: ColorConstant
                                  .lightblack, // Color when not focused
                              width: 0.1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(
                              color: ColorConstant
                                  .bordercolor, // Color when focused (you can change this to any color)
                              width: 1, // Border width when focused
                            ),
                          ),
            
                          // Suffix icon (filter icon)
                          suffixIcon: InkWell(
                            onTap: () {
                              showFilterModal(context);
                            },
                            child: Image.asset(
                              "assets/images/Filter.png",
                              // height: 5,
                              // width: 5,
                            ),
                          )),
                    ),
                  ),
                 */
                        SizedBox(
                          height: boxsized,
                        ),
                        if (suggestions.isNotEmpty)
                          SizedBox(
                            height: 400,
                            child: suggestions.isEmpty
                                ? Center(child: Text('No results found.'))
                                : ListView.builder(
                                    itemCount: suggestions.length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        title: Row(
                                          children: [
                                            Image.asset(
                                                "assets/images/Search.png"),
                                            SizedBox(
                                              width: 08,
                                            ),
                                            Text(
                                              suggestions[index],
                                              style: GoogleFonts.manrope(
                                                  fontSize: 14),
                                            ),
                                          ],
                                        ),
                                        onTap: () {
                                          searchController.text =
                                              suggestions[index];
                                          updateSuggestions('');
                                          suggestions.clear();
                                          // Navigator.pop(context);
                                        },
                                      );
                                    },
                                  ),
                          ),
                        //Recommended Jobs
                        Container(
                          // height: screenHeight * 0.4,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Recommended Jobs",
                                    style: GoogleFonts.manrope(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Card(
                                    child: Container(
                                        decoration: BoxDecoration(
                                            color: ColorConstant.white,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border: Border.all(
                                                width: 0.5,
                                                color: ColorConstant.botton)),
                                        height: 24,
                                        width: 85,
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      RecentJobsLIstScreen()), // Replace `NewPage` with the page you want to navigate to
                                            );
                                          },
                                          child: Center(
                                            child: Text(
                                              "View all",
                                              style: GoogleFonts.manrope(
                                                  color: ColorConstant.botton,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14),
                                            ),
                                          ),
                                        )),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: boxsized,
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis
                                    .horizontal, // Enable horizontal scrolling
                                child: Row(
                                  children: [
                                    Container(
                                      width: 300,
                                      height: 165,
                                      margin: EdgeInsets.only(
                                          right:
                                              16), // Spacing between containers
                                      decoration: BoxDecoration(
                                        color: ColorConstant.productdesign,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Card(
                                        color: ColorConstant.transparent,
                                        // elevation: 05,
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(08),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    CircleAvatar(
                                                        backgroundColor:
                                                            ColorConstant
                                                                .white24,
                                                        child: Image.asset(
                                                            "assets/images/Ethereum.png")),
                                                    SizedBox(width: 12),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Product Designer',
                                                          style: GoogleFonts
                                                              .manrope(
                                                            color: ColorConstant
                                                                .white,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        Text(
                                                          'Ethereum Foundation',
                                                          style: GoogleFonts
                                                              .manrope(
                                                            color: ColorConstant
                                                                .white,
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Spacer(),
                                                    Icon(
                                                      Icons.bookmark_border,
                                                      color:
                                                          ColorConstant.white,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 16),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    _buildTag('Design'),
                                                    _buildTag('Full Time'),
                                                    _buildTag('Anywhere'),
                                                  ],
                                                ),
                                                SizedBox(height: 16),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Icon(Icons.location_on,
                                                            color: ColorConstant
                                                                .white70,
                                                            size: 16),
                                                        SizedBox(width: 4),
                                                        Text(
                                                          'Anywhere',
                                                          style: GoogleFonts
                                                              .manrope(
                                                            color: ColorConstant
                                                                .white70,
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                      '\$195,000/year',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 300,
                                      height: 165,
                                      margin: EdgeInsets.only(
                                          right:
                                              16), // Spacing between containers
                                      decoration: BoxDecoration(
                                        color: ColorConstant.themeGradientStart,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Card(
                                        color: ColorConstant.transparent,
                                        // elevation: 05,
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(08),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    CircleAvatar(
                                                        backgroundColor:
                                                            ColorConstant
                                                                .white24,
                                                        child: Image.asset(
                                                            "assets/images/Ethereum.png")),
                                                    SizedBox(width: 12),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'PHP Developer',
                                                          style: GoogleFonts
                                                              .manrope(
                                                            color: ColorConstant
                                                                .white,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        Text(
                                                          'Ethereum Foundation',
                                                          style: GoogleFonts
                                                              .manrope(
                                                            color: ColorConstant
                                                                .white,
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Spacer(),
                                                    Icon(
                                                      Icons.bookmark_border,
                                                      color:
                                                          ColorConstant.white,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 16),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    _buildTag('Design'),
                                                    _buildTag('Full Time'),
                                                    _buildTag('Anywhere'),
                                                  ],
                                                ),
                                                SizedBox(height: 16),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Icon(Icons.location_on,
                                                            color: ColorConstant
                                                                .white70,
                                                            size: 16),
                                                        SizedBox(width: 4),
                                                        Text(
                                                          'Anywhere',
                                                          style: GoogleFonts
                                                              .manrope(
                                                            color: ColorConstant
                                                                .white70,
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                      '\$195,000/year',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 300,
                                      height: 165,
                                      margin: EdgeInsets.only(
                                          right:
                                              16), // Spacing between containers
                                      decoration: BoxDecoration(
                                        color:
                                            ColorConstant.backcolointerviewtext,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Card(
                                        color: ColorConstant.transparent,
                                        // elevation: 05,
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(08),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    CircleAvatar(
                                                        backgroundColor:
                                                            ColorConstant
                                                                .white24,
                                                        child: Image.asset(
                                                            "assets/images/Ethereum.png")),
                                                    SizedBox(width: 12),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'React Developer',
                                                          style: GoogleFonts
                                                              .manrope(
                                                            color: ColorConstant
                                                                .white,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        Text(
                                                          'Street Foundation',
                                                          style: GoogleFonts
                                                              .manrope(
                                                            color: ColorConstant
                                                                .white,
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Spacer(),
                                                    Icon(
                                                      Icons.bookmark_border,
                                                      color:
                                                          ColorConstant.white,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 16),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    _buildTag('Design'),
                                                    _buildTag('Full Time'),
                                                    _buildTag('Delhi'),
                                                  ],
                                                ),
                                                SizedBox(height: 16),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Icon(Icons.location_on,
                                                            color: ColorConstant
                                                                .white70,
                                                            size: 16),
                                                        SizedBox(width: 4),
                                                        Text(
                                                          'Delhi',
                                                          style: GoogleFonts
                                                              .manrope(
                                                            color: ColorConstant
                                                                .white70,
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                      '\$300,000/year',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 300,
                                      height: 165,
                                      margin: EdgeInsets.only(
                                          right:
                                              16), // Spacing between containers
                                      decoration: BoxDecoration(
                                        color: ColorConstant.botton,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Card(
                                        color: ColorConstant.transparent,
                                        // elevation: 05,
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(08),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    CircleAvatar(
                                                        backgroundColor:
                                                            ColorConstant
                                                                .white24,
                                                        child: Image.asset(
                                                            "assets/images/Ethereum.png")),
                                                    SizedBox(width: 12),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Laravel Developer',
                                                          style: GoogleFonts
                                                              .manrope(
                                                            color: ColorConstant
                                                                .white,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        Text(
                                                          'Ethereum Foundation',
                                                          style: GoogleFonts
                                                              .manrope(
                                                            color: ColorConstant
                                                                .white,
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Spacer(),
                                                    Icon(
                                                      Icons.bookmark_border,
                                                      color:
                                                          ColorConstant.white,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 16),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    _buildTag('Development'),
                                                    _buildTag('Full Time'),
                                                    _buildTag('Anywhere'),
                                                  ],
                                                ),
                                                SizedBox(height: 16),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Icon(Icons.location_on,
                                                            color: ColorConstant
                                                                .white70,
                                                            size: 16),
                                                        SizedBox(width: 4),
                                                        Text(
                                                          'Anywhere',
                                                          style: GoogleFonts
                                                              .manrope(
                                                            color: ColorConstant
                                                                .white70,
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                      '\$250,000/year',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: boxsized,
                        ),
                        //industries
                        Column(
                          crossAxisAlignment: CrossAxisAlignment
                              .start, // Align content to the left
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Industries",
                                  style: GoogleFonts.manrope(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                // Container(
                                //   decoration: BoxDecoration(
                                //     color: Colors.white,
                                //     borderRadius: BorderRadius.circular(20),
                                //     border: Border.all(
                                //         width: 0.5, color: ColorConstant.botton),
                                //   ),
                                //   height: 24,
                                //   width: 75,
                                //   child: InkWell(
                                //     onTap: () {
                                //       Navigator.push(
                                //         context,
                                //         MaterialPageRoute(
                                //             builder: (context) => AllpostedJob(
                                //                   headername: 'Industries',
                                //                 )), // Replace `NewPage` with the page you want to navigate to
                                //       );
                                //     },
                                //     child: Center(
                                //       child: Text(
                                //         "View More",
                                //         style: GoogleFonts.manrope(
                                //             color: ColorConstant.botton,
                                //             fontSize: 12),
                                //       ),
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                            SizedBox(height: boxsized),
                            Container(
                              width: double.infinity,
                              child: Column(
                                children: [
                                  // SizedBox(
                                  //   height: 8,
                                  // ),
                                  // First row of categories

                                  Container(
                                    width: double.infinity,
                                    child: GridView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          NeverScrollableScrollPhysics(), // Prevent scrolling within the grid
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 4, // Number of columns
                                        crossAxisSpacing:
                                            4.0, // Horizontal spacing
                                        mainAxisSpacing:
                                            12.0, // Vertical spacing
                                      ),
                                      itemCount: Industrieslist.length > 7
                                          ? 8
                                          : Industrieslist.length +
                                              1, // Add 1 for the "More" button
                                      itemBuilder: (context, index) {
                                        if (index < Industrieslist.length &&
                                            index < 7) {
                                          // Display industries
                                          final category =
                                              Industrieslist[index];
                                          return InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        IndustryListScreen(
                                                          industryid:
                                                              category["id"]
                                                                  .toString(),
                                                          Indusryname:
                                                              category["title"]
                                                                  .toString(),
                                                        )), // Replace `NewPage` with the page you want to navigate to
                                              );
                                            },
                                            child: _buildCategory(
                                              category["icon"]!,
                                              category["title"]!,
                                            ),
                                          );
                                        } else {
                                          // Display "More" button
                                          return InkWell(
                                            onTap: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    IndustriesScreen(),
                                              ),
                                            ),
                                            child: _buildCategorymore(
                                              "assets/images/Menu.png", // Placeholder for "More" icon
                                              "More", // Label for the "More" button
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                  )

                                  // Row(
                                  //   mainAxisAlignment:
                                  //       MainAxisAlignment.spaceBetween,
                                  //   crossAxisAlignment: CrossAxisAlignment.start,
                                  //   children: [
                                  //     _buildCategory(
                                  //         "assets/images/Design.png", "Design"),
                                  //     _buildCategory("assets/images/Coding.png",
                                  //         "Developer"),
                                  //     _buildCategory("assets/images/Internet.png",
                                  //         "Network"),
                                  //     _buildCategory(
                                  //         "assets/images/Task.png", "Quality"),
                                  //   ],
                                  // ),
                                  // SizedBox(height: boxsized),
                                  // // Second row of categories
                                  // Row(
                                  //   mainAxisAlignment:
                                  //       MainAxisAlignment.spaceBetween,
                                  //   children: [
                                  //     _buildCategory("assets/images/Sounding.png",
                                  //         "Marketing"),
                                  //     _buildCategory("assets/images/Contract.png",
                                  //         "Secretary"),
                                  //     _buildCategory("assets/images/Research.png",
                                  //         "Analysis"),
                                  //     InkWell(
                                  //       onTap: () => Navigator.push(
                                  //         context,
                                  //         MaterialPageRoute(
                                  //             builder: (context) =>
                                  //                 IndustriesScreen()), // Replace `NewPage` with the page you want to navigate to
                                  //       ),
                                  //       child: _buildCategory(
                                  //           "assets/images/Menu.png", "More"),
                                  //     ),
                                  //   ],
                                  // ),
                                  // SizedBox(
                                  //   height: 8,
                                  // ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        // Container(
                        //   // height: screenHeight * 0.4,
                        //   child: Column(
                        //     children: [
                        //       Row(
                        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //         children: [
                        //           Text(
                        //             "Categories",
                        //             style: GoogleFonts.manrope(
                        //                 fontSize: 16, fontWeight: FontWeight.bold),
                        //           ),
                        //           Container(
                        //               decoration: BoxDecoration(
                        //                   color: ColorConstant.white,
                        //                   borderRadius: BorderRadius.circular(20),
                        //                   border: Border.all(
                        //                       width: 0.5, color: ColorConstant.botton)),
                        //               height: 24,
                        //               width: 68,
                        //               child: Center(
                        //                 child: Text(
                        //                   "View More",
                        //                   style: GoogleFonts.manrope(
                        //                       color: ColorConstant.botton,
                        //                       fontSize: 13),
                        //                 ),
                        //               )),
                        //         ],
                        //       ),
                        //       SizedBox(
                        //         height: boxsized,
                        //       ),
                        //       Column(
                        //         mainAxisAlignment: MainAxisAlignment.center,
                        //         crossAxisAlignment: CrossAxisAlignment.center,
                        //         children: [
                        //           Row(
                        //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //             crossAxisAlignment: CrossAxisAlignment.center,
                        //             children: [
                        //               Container(
                        //                 height: 52,
                        //                 width: 56,
                        //                 child: _buildCategory(
                        //                     "assets/images/Design.png", "Design"),
                        //               ),
                        //               Container(
                        //                 height: 52,
                        //                 width: 56,
                        //                 child: _buildCategory(
                        //                     "assets/images/Coding.png", "Developer"),
                        //               ),
                        //               Container(
                        //                 height: 52,
                        //                 width: 56,
                        //                 child: _buildCategory(
                        //                     "assets/images/Internet.png", "Network"),
                        //               ),
                        //               Container(
                        //                 height: 52,
                        //                 width: 56,
                        //                 child: _buildCategory(
                        //                     "assets/images/Task.png", "Quality"),
                        //               ),
                        //             ],
                        //           ),
                        //           SizedBox(
                        //             height: boxsized,
                        //           ),
                        //           Row(
                        //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //             crossAxisAlignment: CrossAxisAlignment.center,
                        //             children: [
                        //               Container(
                        //                 height: 52,
                        //                 width: 56,
                        //                 child: _buildCategory(
                        //                     "assets/images/Sounding.png", "Marketing"),
                        //               ),
                        //               Container(
                        //                 height: 52,
                        //                 width: 56,
                        //                 child: _buildCategory(
                        //                     "assets/images/Contract.png", "Secretary"),
                        //               ),
                        //               Container(
                        //                 height: 52,
                        //                 width: 56,
                        //                 child: _buildCategory(
                        //                     "assets/images/Research.png", "Analysis"),
                        //               ),
                        //               Container(
                        //                   height: 52,
                        //                   width: 56,
                        //                   child: _buildCategory(
                        //                       "assets/images/Menu.png", "More")),
                        //             ],
                        //           )
                        //         ],
                        //       ),
                        //     ],
                        //   ),
                        // ),

                        SizedBox(
                          height: boxsized,
                        ),

                        //Recommended for you
                        /*  Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Recommended for you",
                                  style: GoogleFonts.manrope(
                                      fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                Container(
                                    decoration: BoxDecoration(
                                        color: ColorConstant.white,
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                            width: 0.5,
                                            color: ColorConstant.botton)),
                                    height: 24,
                                    width: 75,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => AllpostedJob(
                                                    headername:
                                                        'Recommended for you',
                                                  )), // Replace `NewPage` with the page you want to navigate to
                                        );
                                      },
                                      child: Center(
                                        child: Text(
                                          "View More",
                                          style: GoogleFonts.manrope(
                                              color: ColorConstant.botton,
                                              fontSize: 12),
                                        ),
                                      ),
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: boxsized,
                            ),
                            SizedBox(
                              height: 168,
                              child: ListView.builder(
                                scrollDirection: Axis
                                    .horizontal, // Enable horizontal scrolling
                                itemCount: 5, // Adjust item count as needed
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                JobDetailsDummyScreen(
                                                  listid: '',
                                                  page: '',
                                                )), // Replace `NewPage` with the page you want to navigate to
                                      );
                                    },
                                    child: Container(
                                      width: 172, // Width of each container
                                      margin: EdgeInsets.only(
                                          right:
                                              16), // Spacing between containers
                                      padding: EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                          color: ColorConstant.white,
                                          borderRadius: BorderRadius.circular(16),
                                          border: Border.all(
                                              width: 1,
                                              color: ColorConstant.bordercolor)
                                          // boxShadow: [
                                          //   BoxShadow(
                                          //     color: ColorConstant.lightblack
                                          //         .withOpacity(0.5),
                                          //     blurRadius: 8,
                                          //     offset: Offset(0, 4),
                                          //   ),
                                          // ],
                                          ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                backgroundColor:
                                                    ColorConstant.white,
                                                radius: 12,
                                                child: Image.asset(
                                                  'assets/images/Group.png',
                                                  width: 24,
                                                  height: 24,
                                                ),
                                              ),
                                              SizedBox(width: 8),
                                              Text(
                                                'Slack',
                                                style: GoogleFonts.manrope(
                                                  color: ColorConstant.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Spacer(),
                                              Icon(
                                                Icons.bookmark_border,
                                                color: ColorConstant.lightblack,
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 12),
                                          Text(
                                            'UI Designer',
                                            style: TextStyle(
                                              color: ColorConstant.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            'Jakarta, Indonesia',
                                            style: TextStyle(
                                              color: ColorConstant.lightblack,
                                              fontSize: 12,
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                            'Fulltime',
                                            style: GoogleFonts.manrope(
                                              color: ColorConstant.accentColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 16),
                                          Row(
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(Icons.group,
                                                      color: Colors.blue,
                                                      size: 16),
                                                  SizedBox(width: 4),
                                                  Text(
                                                    '80',
                                                    style: GoogleFonts.manrope(
                                                      color: ColorConstant.black,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(width: 16),
                                              Row(
                                                children: [
                                                  Icon(Icons.visibility,
                                                      color: ColorConstant
                                                          .primaryColor,
                                                      size: 16),
                                                  SizedBox(width: 4),
                                                  Text(
                                                    '456',
                                                    style: GoogleFonts.manrope(
                                                      color: ColorConstant.black,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
            
                        SizedBox(
                          height: boxsized,
                        ),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Popular Jobs",
                                  style: GoogleFonts.manrope(
                                      fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                Container(
                                    decoration: BoxDecoration(
                                        color: ColorConstant.white,
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                            width: 0.5,
                                            color: ColorConstant.botton)),
                                    height: 24,
                                    width: 75,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => AllpostedJob(
                                                    headername: 'Popular Jobs',
                                                  )), // Replace `NewPage` with the page you want to navigate to
                                        );
                                      },
                                      child: Center(
                                        child: Text(
                                          "View More",
                                          style: GoogleFonts.manrope(
                                              color: ColorConstant.botton,
                                              fontSize: 12),
                                        ),
                                      ),
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: boxsized,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => JobDetailsDummyScreen(
                                            listid: '',
                                            page: '',
                                          )), // Replace `NewPage` with the page you want to navigate to
                                );
                              },
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics:
                                    NeverScrollableScrollPhysics(), // Disables scrolling
                                // scrollDirection:
                                //     Axis.vertical, // Enable horizontal scrolling
                                itemCount:
                                    jobList.length, // Adjust item count as needed
                                itemBuilder: (context, index) {
                                  var job = jobList[
                                      index]; // Get the job map for the current index
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    JobDetailsDummyScreen(
                                                      listid: '',
                                                      page: '',
                                                    )), // Replace `NewPage` with the page you want to navigate to
                                          );
                                        },
                                        child: JobCard(
                                          companyLogo:
                                              job['companyLogo'].toString(),
                                          // Icons.catching_pokemon,
                                          jobTitle: job['jobTitle'].toString(),
                                          companyName:
                                              job['companyName'].toString(),
                                          location: job['location'].toString(),
                                          onMorePressed: () =>
                                              _showJobMenu(context),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
            
                        SizedBox(
                          height: boxsized,
                        ),
                       */

                        //recent job
                        Container(
                          // height: screenHeight * 0.4,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Recent",
                                    style: GoogleFonts.manrope(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Card(
                                    child: Container(
                                        decoration: BoxDecoration(
                                            color: ColorConstant.white,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border: Border.all(
                                                width: 0.5,
                                                color: ColorConstant.botton)),
                                        height: 24,
                                        width: 85,
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      RecentJobsLIstScreen()), // Replace `NewPage` with the page you want to navigate to
                                            );
                                          },
                                          child: Center(
                                            child: Text(
                                              "View All",
                                              style: GoogleFonts.manrope(
                                                  color: ColorConstant.botton,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14),
                                            ),
                                          ),
                                        )),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: boxsized,
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics:
                                    NeverScrollableScrollPhysics(), // Disables scrolling
                                itemCount: RecentJoblist.length > 3
                                    ? 3
                                    : RecentJoblist
                                        .length, // Adjust item count as needed
                                itemBuilder: (context, index) {
                                  var recentlist = RecentJoblist[index];
                                  return Card(
                                    elevation: 5,
                                    color: ColorConstant.white,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    JobDetailsScreen(
                                                  listid:
                                                      recentlist['id'] ?? '',
                                                  page: 'tests',
                                                ),
                                              ),
                                            ).then((onValue) {
                                              UserProfile();
                                            });
                                          },
                                          child: Container(
                                            // height: 200,
                                            // margin: EdgeInsets.only(bottom: 12),
                                            decoration: BoxDecoration(
                                                // border: Border.all(
                                                //     width: 0.5,
                                                //     // color: ColorConstant
                                                //     //     .bordercolor
                                                //         ),
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            child: JobCardRecent(
                                              city: recentlist['city'] ?? '',
                                              country:
                                                  recentlist['country'] ?? '',
                                              companyLogo:
                                                  recentlist['company_logo'] ??
                                                      '',
                                              is_saved: recentlist['is_saved'],
                                              // iconcolor: recentlist['iconcolor'],
                                              companyName:
                                                  recentlist['company_name'] ??
                                                      '',
                                              jobTitle:
                                                  recentlist['title'] ?? '',
                                              location:
                                                  recentlist['job_location'] ??
                                                      '',
                                              jobType: recentlist['job_type'],
                                              description: recentlist[
                                                      'short_description'] ??
                                                  '',
                                              applicants:
                                                  recentlist['no_applied'] ?? 0,
                                              views: recentlist['view'] ?? 0,
                                              timestamp:
                                                  recentlist['post_datetime'] ??
                                                      '',
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
      /* bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: ColorConstant.botton,
        unselectedItemColor: ColorConstant.lightblack,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_border),
            label: 'Saved',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Activity',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
   */
    );
  }

  //suggested field
  Widget _buildTag(String text) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      decoration: BoxDecoration(
        color: ColorConstant.white24,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: GoogleFonts.manrope(
          color: ColorConstant.white,
          fontSize: 12,
        ),
      ),
    );
  }

  //category
  Widget _buildCategory(String image, String name) {
    return Container(
      height: 90,
      width: 70,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 4,
          ),
          if (image != '')
            Image.network(
              "${ApiConstants.baseUrl}" + image,
              fit: BoxFit.contain,
              height: 28,
              width: 28,
            ),
          if (image == '')
            Image.asset(
              "assets/images/Task.png",
              fit: BoxFit.contain,
              height: 28,
              width: 28,
            ),
          SizedBox(
            height: 4,
          ),
          Center(
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
    );
  }

  Widget _buildCategorymore(String image, String name) {
    return Container(
      height: 90,
      width: 70,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 4,
          ),
          Image.asset(
            image,
            height: 28,
            width: 28,
          ),
          SizedBox(
            height: 4,
          ),
          Center(
            child: Text(
              name,
              style: GoogleFonts.manrope(
                color: ColorConstant.category,
                // fontWeight: FontWeight.bold,
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    );
  }

//make filter
  String? selectedCategory;
  String? location;
  String selectedWorkType = 'Full time';
  double minSalary = 1000;
  double maxSalary = 5000;
  // Widget _buildFilter() {
  //   return;
  // }

  Widget _buildWorkTypeButton(String workType) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedWorkType = workType;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: selectedWorkType == workType
              ? ColorConstant.backgroundColor
              : ColorConstant.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: ColorConstant.bordercolor),
        ),
        child: Text(
          workType,
          style: GoogleFonts.manrope(
            color: selectedWorkType == workType
                ? ColorConstant.white
                : ColorConstant.lightblack,
          ),
        ),
      ),
    );
  }
  // Widget _buildFilter() {
  //   return Container(
  //     padding: const EdgeInsets.all(16.0),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Text(
  //               'Filters',
  //               style: GoogleFonts.manrope(
  //                   fontSize: 18, fontWeight: FontWeight.bold),
  //             ),
  //             InkWell(
  //                 onTap: () {
  //                   Navigator.pop(context);
  //                 },
  //                 child: Image.asset('assets/images/cancel-square.png'))
  //           ],
  //         ),
  //         SizedBox(height: 16),
  //         Text('Clear all',
  //             style: GoogleFonts.manrope(color: ColorConstant.botton)),
  //         SizedBox(height: 16),
  //         // Category Dropdown
  //         Text('Category',
  //             style: GoogleFonts.manrope(
  //                 fontSize: 16, color: ColorConstant.lightblack)),
  //         SizedBox(height: 16),
  //         DropdownButtonFormField<String>(
  //           hint: Text('Select',
  //               style: GoogleFonts.manrope(
  //                 color: ColorConstant.lightblack,
  //               )),
  //           value: selectedCategory,
  //           onChanged: (String? newValue) {
  //             setState(() {
  //               selectedCategory = newValue;
  //             });
  //           },
  //           items: <String>[].map<DropdownMenuItem<String>>((String value) {
  //             return DropdownMenuItem<String>(
  //               value: value,
  //               child: Text(
  //                 value,
  //                 style: GoogleFonts.manrope(color: ColorConstant.lightblack),
  //               ),
  //             );
  //           }).toList(),
  //           decoration: InputDecoration(
  //             contentPadding: const EdgeInsets.symmetric(horizontal: 12),
  //             border: OutlineInputBorder(
  //               borderRadius: BorderRadius.circular(0.5),
  //               borderSide: BorderSide(color: ColorConstant.lightblack),
  //             ),
  //             enabledBorder: OutlineInputBorder(
  //               borderRadius: BorderRadius.circular(10),
  //               borderSide: BorderSide(color: ColorConstant.lightblack),
  //             ),
  //             focusedBorder: OutlineInputBorder(
  //               borderRadius: BorderRadius.circular(1),
  //               borderSide: BorderSide(color: ColorConstant.botton),
  //             ),
  //           ),
  //         ),
  //         //location
  //         SizedBox(height: 16),
  //         // Category Dropdown
  //         Text('Location',
  //             style: GoogleFonts.manrope(
  //                 fontSize: 16, color: ColorConstant.lightblack)),
  //         SizedBox(height: 16),
  //         DropdownButtonFormField<String>(
  //           hint: Text('Select',
  //               style: GoogleFonts.manrope(
  //                 color: ColorConstant.lightblack,
  //               )),
  //           value: selectedCategory,
  //           onChanged: (String? newValue) {
  //             setState(() {
  //               selectedCategory = newValue;
  //             });
  //           },
  //           items: <String>[].map<DropdownMenuItem<String>>((String value) {
  //             return DropdownMenuItem<String>(
  //               value: value,
  //               child: Text(
  //                 value,
  //                 style: GoogleFonts.manrope(color: ColorConstant.lightblack),
  //               ),
  //             );
  //           }).toList(),
  //           decoration: InputDecoration(
  //               contentPadding: const EdgeInsets.symmetric(horizontal: 12),
  //               border: OutlineInputBorder(
  //                 borderRadius: BorderRadius.circular(0.5),
  //                 borderSide: BorderSide(color: ColorConstant.lightblack),
  //               ),
  //               enabledBorder: OutlineInputBorder(
  //                 borderRadius: BorderRadius.circular(10),
  //                 borderSide: BorderSide(color: ColorConstant.lightblack),
  //               ),
  //               focusedBorder: OutlineInputBorder(
  //                 borderRadius: BorderRadius.circular(1),
  //                 borderSide: BorderSide(color: ColorConstant.botton),
  //               ),
  //               prefixIcon: Image.asset('assets/images/map-pin.png')),
  //         ),
  //         const SizedBox(height: 20),
  //         // Work Type ToggleButtons
  //         Text('Work type',
  //             style: GoogleFonts.manrope(
  //                 fontSize: 16, color: ColorConstant.lightblack)),
  //         const SizedBox(height: 10),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             // Using Containers and GestureDetector for custom toggle buttons
  //             GestureDetector(
  //               onTap: () {
  //                 setState(() {
  //                   selectedWorkType = 'Full time';
  //                 });
  //               },
  //               child: Container(
  //                 padding:
  //                     const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  //                 decoration: BoxDecoration(
  //                   color: selectedWorkType == 'Full time'
  //                       ? ColorConstant.lightblack
  //                       : ColorConstant.white,
  //                   borderRadius: BorderRadius.circular(14),
  //                   border: Border.all(color: ColorConstant.lightblack),
  //                 ),
  //                 child: Text(
  //                   'Full time',
  //                   style: GoogleFonts.manrope(
  //                     color: selectedWorkType == 'Full time'
  //                         ? ColorConstant.white
  //                         : ColorConstant.lightblack,
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             GestureDetector(
  //               onTap: () {
  //                 setState(() {
  //                   selectedWorkType = 'Part time';
  //                 });
  //               },
  //               child: Container(
  //                 padding:
  //                     const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  //                 decoration: BoxDecoration(
  //                   color: selectedWorkType == 'Part time'
  //                       ? ColorConstant.lightblack
  //                       : ColorConstant.white,
  //                   borderRadius: BorderRadius.circular(14),
  //                   border: Border.all(
  //                     color: ColorConstant.lightblack,
  //                   ),
  //                 ),
  //                 child: Text(
  //                   'Part time',
  //                   style: GoogleFonts.manrope(
  //                     color: selectedWorkType == 'Part time'
  //                         ? ColorConstant.white
  //                         : ColorConstant.lightblack,
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             GestureDetector(
  //               onTap: () {
  //                 setState(() {
  //                   selectedWorkType = 'Remote';
  //                 });
  //               },
  //               child: Container(
  //                 padding:
  //                     const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  //                 decoration: BoxDecoration(
  //                   color: selectedWorkType == 'Remote'
  //                       ? ColorConstant.lightblack
  //                       : ColorConstant.white,
  //                   borderRadius: BorderRadius.circular(14),
  //                   border: Border.all(
  //                     color: ColorConstant.lightblack,
  //                   ),
  //                 ),
  //                 child: Text(
  //                   'Remote',
  //                   style: GoogleFonts.manrope(
  //                     color: selectedWorkType == 'Remote'
  //                         ? ColorConstant.white
  //                         : ColorConstant.lightblack,
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //         const SizedBox(height: 20),

  //         // Salary Range Slider
  //         Text('Salary Range',
  //             style: GoogleFonts.manrope(
  //                 fontSize: 16, color: ColorConstant.lightblack)),
  //         RangeSlider(
  //           values: RangeValues(minSalary, maxSalary),
  //           min: 500,
  //           max: 10000,
  //           divisions: 20,
  //           labels:
  //               RangeLabels('\$${minSalary.toInt()}', '\$${maxSalary.toInt()}'),
  //           onChanged: (RangeValues values) {
  //             setState(() {
  //               minSalary = values.start;
  //               maxSalary = values.end;
  //             });
  //           },
  //         ),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Text('\$${minSalary.toInt()}'),
  //             Text('\$${maxSalary.toInt()}'),
  //           ],
  //         ),
  //         const SizedBox(height: 30),

  //         // Show Results Button
  //         SizedBox(
  //           width: double.infinity,
  //           child: ElevatedButton(
  //             onPressed: () {
  //               // Implement filter action here
  //             },
  //             style: ElevatedButton.styleFrom(
  //               padding: EdgeInsets.symmetric(
  //                   // vertical: 56,
  //                   ),
  //               backgroundColor: ColorConstant
  //                   .botton, // Responsive vertical padding for button
  //               minimumSize:
  //                   Size(double.infinity, 56), // Responsive button height
  //             ),
  //             child: Text('Show Results',
  //                 style: GoogleFonts.manrope(
  //                     fontSize: 18,
  //                     color: ColorConstant.white,
  //                     fontWeight: FontWeight.bold)),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  void showFilterModal(BuildContext context) {
    // Initialize your variables here
    String? selectedCategory;
    String? selectedLocation;
    double minSalary = 100;
    double maxSalary = 10000;

    // Variables for the toggle buttons
    List<bool> isSelected = [false, false, false]; // Default states for buttons
    final Set<String> _selectedOptions = {};

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.8, // Adjust the height factor as needed
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setModalState) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 66,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 1, color: ColorConstant.bordercolor),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Text(
                              'Filters',
                              style: GoogleFonts.manrope(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Image.asset(
                                  'assets/images/cancel-square.png'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Clear All Button
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16),
                      child: GestureDetector(
                        onTap: () {
                          setModalState(() {
                            selectedCategory = null;
                            selectedLocation = null;
                            minSalary = 100;
                            maxSalary = 10000;
                            isSelected = [false, false, false];
                          });
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.close,
                              size: 16,
                            ),
                            Text(
                              'Clear all',
                              style: GoogleFonts.manrope(
                                  color: ColorConstant.black, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Category Dropdown
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16),
                      child: Text(
                        'Category',
                        style: GoogleFonts.manrope(
                          fontSize: 14,
                          color: ColorConstant.lightblack,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16),
                      child: Container(
                        child: DropdownButtonFormField<String>(
                          dropdownColor: ColorConstant.white,
                          hint: Text(
                            'Select',
                            style: GoogleFonts.manrope(
                                color: ColorConstant.black, fontSize: 14),
                          ),
                          value: selectedCategory,
                          onChanged: (String? newValue) {
                            setModalState(() {
                              selectedCategory = newValue;
                            });
                          },
                          items: <String>[
                            'Category 1',
                            'Category 2',
                            'Category 3'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: GoogleFonts.manrope(
                                    color: ColorConstant.black),
                              ),
                            );
                          }).toList(),
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
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 24),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Location Dropdown
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16),
                      child: Text(
                        'Location',
                        style: GoogleFonts.manrope(
                          fontSize: 14,
                          color: ColorConstant.lightblack,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16),
                      child: DropdownButtonFormField<String>(
                        dropdownColor: ColorConstant.white,
                        hint: Text(
                          'Enter Location',
                          style: GoogleFonts.manrope(
                              color: ColorConstant.black, fontSize: 14),
                        ),
                        value: selectedLocation,
                        onChanged: (String? newValue) {
                          setModalState(() {
                            selectedLocation = newValue;
                          });
                        },
                        items: <String>[
                          'Location 1',
                          'Location 2',
                          'Location 3'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: GoogleFonts.manrope(
                                  color: ColorConstant.black, fontSize: 14),
                            ),
                          );
                        }).toList(),
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
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 24),

                          prefixIcon: Image.asset(
                            'assets/images/map-pin.png',
                            color: ColorConstant.productdesign,
                          ),
                        ),
                        style: GoogleFonts.manrope(
                            fontSize: 14,
                            color: ColorConstant.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Work Type Toggle Buttons
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16),
                      child: Text(
                        'Work type',
                        style: GoogleFonts.manrope(
                          fontSize: 14,
                          color: ColorConstant.lightblack,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16),
                        child: Container(
                          height: 48,
                          // width: double.infinity,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  // Full Time Button
                                  Expanded(
                                    child: ElevatedButton.icon(
                                      onPressed: () {
                                        setState(() {
                                          if (_selectedOptions
                                              .contains('Full Time')) {
                                            _selectedOptions
                                                .remove('Full Time');
                                          } else {
                                            _selectedOptions.add('Full Time');
                                          }
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: _selectedOptions
                                                .contains('Full Time')
                                            ? Colors.blue.shade100
                                            : Colors.white,
                                        side: BorderSide(
                                            color: Colors.grey.shade300),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        padding:
                                            EdgeInsets.symmetric(vertical: 12),
                                      ),
                                      label: Text(
                                        "Full Time",
                                        style: GoogleFonts.manrope(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                      width: 8), // Add spacing between buttons

                                  Expanded(
                                    child: ElevatedButton.icon(
                                      onPressed: () {
                                        setState(() {
                                          if (_selectedOptions
                                              .contains('Part Time')) {
                                            _selectedOptions
                                                .remove('Part Time');
                                          } else {
                                            _selectedOptions.add('Part Time');
                                          }
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: _selectedOptions
                                                .contains('Part Time')
                                            ? Colors.blue.shade100
                                            : Colors.white,
                                        side: BorderSide(
                                            color: Colors.grey.shade300),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        padding:
                                            EdgeInsets.symmetric(vertical: 12),
                                      ),
                                      label: Text(
                                        "Part Time",
                                        style: GoogleFonts.manrope(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                      width: 8), // Add spacing between buttons

                                  // Remote Button
                                  Expanded(
                                    child: ElevatedButton.icon(
                                      onPressed: () {
                                        setState(() {
                                          if (_selectedOptions
                                              .contains('Remote')) {
                                            _selectedOptions.remove('Remote');
                                          } else {
                                            _selectedOptions.add('Remote');
                                          }
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            _selectedOptions.contains('Remote')
                                                ? Colors.blue.shade100
                                                : Colors.white,
                                        side: BorderSide(
                                            color: Colors.grey.shade300),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        padding:
                                            EdgeInsets.symmetric(vertical: 12),
                                      ),
                                      label: Text(
                                        "Remote",
                                        style: GoogleFonts.manrope(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )),

                    //     child: ToggleButtons(
                    //       isSelected: isSelected,
                    //       onPressed: (int index) {
                    //         setModalState(() {
                    //           isSelected[index] = !isSelected[index];
                    //         });
                    //       },
                    //       borderRadius: BorderRadius.circular(16),
                    //       selectedBorderColor: ColorConstant.backgroundColor,
                    //       selectedColor: ColorConstant.white,
                    //       fillColor: ColorConstant.backgroundColor,
                    //       borderWidth: 1,
                    //       constraints: BoxConstraints.expand(
                    //           width:
                    //               (MediaQuery.of(context).size.width - 45) / 7),
                    //       children: [
                    //         Row(
                    //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //           children: [
                    //             Text(
                    //               'Full time',
                    //               style: GoogleFonts.manrope(
                    //                 fontSize: 14,
                    //                 color: isSelected[0]
                    //                     ? Colors.white
                    //                     : ColorConstant.lightblack,
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //         Row(
                    //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //           children: [
                    //             Text(
                    //               'Part time',
                    //               style: GoogleFonts.manrope(
                    //                 fontSize: 14,
                    //                 color: isSelected[1]
                    //                     ? Colors.white
                    //                     : ColorConstant.lightblack,
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //         Row(
                    //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //           children: [
                    //             Text(
                    //               'Remote',
                    //               style: GoogleFonts.manrope(
                    //                 fontSize: 14,
                    //                 color: isSelected[2]
                    //                     ? Colors.white
                    //                     : ColorConstant.lightblack,
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(height: 20),

                    // Salary Range Slider
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16),
                      child: Text(
                        'Salary Range',
                        style: GoogleFonts.manrope(
                          fontSize: 14,
                          color: ColorConstant.lightblack,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16),
                      child: RangeSlider(
                        values: RangeValues(minSalary, maxSalary),
                        min: 100,
                        max: 10000,
                        inactiveColor: ColorConstant.scalecolor,
                        activeColor: ColorConstant.backgroundColor,
                        labels: RangeLabels(
                          '\$${minSalary.toStringAsFixed(2)}', // Format to two decimal places
                          '\$${maxSalary.toStringAsFixed(2)}', // Format to two decimal places
                        ),
                        onChanged: (RangeValues values) {
                          setModalState(() {
                            minSalary = values.start;
                            maxSalary = values.end;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('\$${minSalary.toInt()}'),
                          Text('\$${maxSalary.toInt()}'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    // Show Results Button
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // Implement filter action here
                            Navigator.pop(context); // Close modal after action
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(),
                            backgroundColor: ColorConstant.botton,
                            minimumSize: Size(double.infinity, 56),
                          ),
                          child: Text(
                            'Show Results',
                            style: GoogleFonts.manrope(
                              fontSize: 16,
                              color: ColorConstant.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _showJobMenu(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: ColorConstant.appliedbuttonback,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.bookmark_border),
              title: Text("Save",
                  style: GoogleFonts.manrope(
                    fontSize: 16,
                    color: ColorConstant.black,
                    fontWeight: FontWeight.bold,
                  )),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          SavedJobScreen()), // Replace `NewPage` with the page you want to navigate to
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.info_outline),
              title: Text(
                "See job detail",
                style: GoogleFonts.manrope(
                  fontSize: 16,
                  color: ColorConstant.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Navigator.pop(context);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => JobDetailsDummyScreen(
                            listid: '',
                            page: '',
                          )), // Replace `NewPage` with the page you want to navigate to
                );
              },
            ),
          ],
        );
      },
    );
  }
}
