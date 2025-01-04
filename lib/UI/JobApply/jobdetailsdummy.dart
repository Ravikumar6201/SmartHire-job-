// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, non_constant_identifier_names, prefer_interpolation_to_compose_strings, unused_element, avoid_print

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_application/Common/Contant.dart';
import 'package:job_application/Common/Url.dart';
import 'package:job_application/Core/Provider.dart';
import 'package:job_application/UI/JobApply/JobAppliedSecuss.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_html/flutter_html.dart';

class JobDetailsDummyScreen extends StatefulWidget {
  String page, listid;
  @override
  JobDetailsDummyScreen({required this.page, required this.listid});

  @override
  State<JobDetailsDummyScreen> createState() => _JobDetailsDummyScreenState();
}

class _JobDetailsDummyScreenState extends State<JobDetailsDummyScreen> {
  // Track selected tab index
  bool _showBottomBar = true;
  int _selectedIndex = 0;
  final List<String> listData = [
    'Job Description',
    'Company',
  ];
  // @override
  // void initState() {
  //   super.initState();
  //   UserProfile();
  // }

  // String? Token;
  // String? userID;
  // UserProfile() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   Token = preferences.getString('token');
  //   userID = preferences.getString('userid');
  //   setState(() {
  //     Token;
  //     userID;
  //   });
  //   print(Token);
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     //get recent job
  //     context.read<UserProvider>().fetchjobdetails(
  //         userID.toString(), // User ID
  //         Token.toString(),
  //         widget.listid??'');
  //   });
  // }

  void _onTabSelecteded(int index) {
    setState(() {
      _selectedIndex = index;
      _showBottomBar = true;
      if (_selectedIndex == 1) {
        setState(() {
          _showBottomBar = false;
        });
      }
    });
    print("Selected tab: ${listData[index]}");
  }

  // Build section title
  Widget _buildSectionTitle(String title, double deviceWidth) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 14),
      child: Text(
        title,
        style: GoogleFonts.manrope(fontSize: 14, fontWeight: FontWeight.bold),
      ),
    );
  }

  // Build responsibility item
  final List<String> responsibilities = [
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
    "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
    "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s."
  ];
  Widget _buildResponsibilityItem() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0),
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: responsibilities.length,
        itemBuilder: (context, index) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '• ',
                style: GoogleFonts.manrope(
                  fontSize: 14,
                  color: ColorConstant.lightblack,
                ),
              ),
              Expanded(
                child: Text(
                  responsibilities[index],
                  style: GoogleFonts.manrope(
                    fontSize: 14,
                    color: ColorConstant.category,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  final String fullText =
      "Your 400 characters long string goes here. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin sit amet consectetur arcu. Pellentesque non dui et erat condimentum varius sit amet at lorem. Mauris eget justo sed urna gravida aliquet et non felis. Sed luctus nisi at dolor ultricies, id ornare tortor suscipit. Morbi sagittis, quam ac aliquet faucibus, dui ipsum pharetra felis, sit amet sagittis risus ligula at mauris. Donec aliquam vehicula mauris, sit amet bibendum nulla interdum id. In id suscipit orci, vitae tincidunt dui. Aenean commodo elit nec dolor gravida, non sagittis dolor gravida. Duis nec nisl odio.";
  final int initialTextLength = 200;

  bool isExpanded = false;

  String truncateString(String text) {
    if (text.length > 22) {
      return text.substring(0, 22) + '...';
    }
    return text;
  }

  // Build content for "Job Description" tab
  Widget _buildJobDescriptionContent(
      double deviceWidth, double deviceHeight, String aboutjob) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Html(
        //   data: aboutjob, // HTML content
        //   style: {
        //     "p": Style(
        //       fontSize: FontSize(14.0), // Customize the font size
        //       fontFamily: GoogleFonts.manrope().fontFamily, // Use GoogleFonts
        //     ),
        //   },
        // ),
        // Text(
        //   aboutjob,
        //   style: GoogleFonts.manrope(fontSize: 14),
        // ),

        Text(
          isExpanded
              ? fullText
              : fullText.substring(0, initialTextLength) + "...",
          style: GoogleFonts.manrope(fontSize: 14),
        ),
        InkWell(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: Text(
            isExpanded ? "Show Less" : "Show More",
            style: TextStyle(
                color: ColorConstant.botton,
                fontWeight: FontWeight.bold,
                fontSize: 14),
          ),
        ),
        SizedBox(height: deviceHeight * 0.02),
        if (_selectedIndex == 0)
          _buildSectionTitle("Responsibilities:", deviceWidth),
        if (_selectedIndex == 0) _buildResponsibilityItem(),
      ],
    );
  }

  // Build content for "Company" tab
  Widget _buildCompanyContent(
      double deviceWidth,
      double deviceHeight,
      String logo,
      String name,
      String shortdis,
      String website,
      String head,
      String founded,
      String size,
      String revrnue,
      String about,
      String location) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: deviceHeight * 0.2,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background.png"),
              alignment: Alignment
                  .topRight, // Position the image in the top-right corner
              fit: BoxFit.fill, // Adjust the image fit
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: ColorConstant.transparent,
                      radius: 16, // Set the desired radius
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/logo4.png',
                          height:
                              100, // Adjust to match the diameter (radius * 2)
                          width: 100,
                          fit: BoxFit
                              .cover, // Ensures the image covers the circular area
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(Icons.error,
                                size: 50,
                                color: Colors.grey); // Default error icon
                          },
                        ),
                      ),
                    ),
                    // CircleAvatar(
                    //   backgroundColor: ColorConstant.accentColor,
                    //   radius: 16,
                    //   child: Image.network("${ApiConstants.baseUrl}" + logo),
                    //   // color: ColorConstant.white, size: 16),
                    // ),
                    SizedBox(width: 10),
                    Text(
                      name,
                      style: GoogleFonts.manrope(
                        color: ColorConstant.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  shortdis,
                  style: GoogleFonts.manrope(
                      fontSize: 16,
                      color: ColorConstant.white,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: deviceHeight * 0.02),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Company Info",
                style: GoogleFonts.manrope(
                    color: ColorConstant.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            _buildCompanyInfo("Website", website, "assets/images/global.png"),
            // SizedBox(height: 5),
            _buildCompanyInfo(
                "Headquarters", location, "assets/images/map-pin.png"),
            // SizedBox(height: deviceHeight * 0.01),
            _buildCompanyInfo("Founed", founded, "assets/images/flash.png"),
            // SizedBox(height: deviceHeight * 0.01),
            _buildCompanyInfo("Size", size, "assets/images/users.png"),
            // SizedBox(height: deviceHeight * 0.01),
            _buildCompanyInfo(
                "Revenue", revrnue, "assets/images/dollar-circle.png"),
            Html(
              data: about, // HTML content
              style: {
                "p": Style(
                  fontSize: FontSize(14.0), // Customize the font size
                  fontFamily:
                      GoogleFonts.manrope().fontFamily, // Use GoogleFonts
                ),
              },
            ),

            // SizedBox(height: deviceHeight * 0.02),

            // Text(
            //   "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
            //   style: GoogleFonts.manrope(
            //       fontSize: 16, color: ColorConstant.category),
            // ),
            // // SizedBox(height: deviceHeight * 0.02),
            // Text(
            //   "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text.",
            //   style: GoogleFonts.manrope(
            //       fontSize: 16, color: ColorConstant.category),
            // ),
            // Text(
            //   "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text.",
            //   style: GoogleFonts.manrope(
            //       fontSize: 14, color: ColorConstant.category),
            // ),
            // Text(
            //   "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text.",
            //   style: GoogleFonts.manrope(
            //       fontSize: 14, color: ColorConstant.category),
            // ),
          ],
        ),

        // SizedBox(height: deviceHeight * 0.02),
        // _buildSectionTitle("Company Culture", deviceWidth),
        // _buildResponsibilityItem(
        //     "Collaborative and inclusive workplace.", deviceWidth),
        // _buildResponsibilityItem(
        //     "Focus on innovation and growth.", deviceWidth),
        // _buildResponsibilityItem(
        //     "Committed to employee development.", deviceWidth),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // final provider = context.watch<UserProvider>();
    // final jobdetailslist = provider.Jobdetails;
    final mediaQuery = MediaQuery.of(context);
    final deviceWidth = mediaQuery.size.width;
    final deviceHeight = mediaQuery.size.height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Product Designer",
          style: GoogleFonts.manrope(fontSize: 18, color: ColorConstant.black),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.bookmark_border,
              color: ColorConstant.lightblack,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body:
          // provider.isLoading
          //     ? Center(
          //         child: CircularProgressIndicator(
          //         color: ColorConstant.botton,
          //       ))
          //     :
          SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (_selectedIndex == 0) SizedBox(height: deviceHeight * 0.02),
              if (_selectedIndex == 0)
                CircleAvatar(
                  backgroundColor: ColorConstant.transparent,
                  radius: 40, // Set the desired radius
                  child: ClipOval(
                    child: Image.asset(
                      "assets/images/logo4.png",
                      height: 150, // Adjust to match the diameter (radius * 2)
                      width: 150,
                      fit: BoxFit
                          .cover, // Ensures the image covers the circular area
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(Icons.error,
                            size: 50, color: Colors.grey); // Default error icon
                      },
                    ),
                  ),
                ),
              // Container(
              //   height: 80,
              //   width: 80,
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(50),
              //       color: ColorConstant.white),
              //   child: Image.network(
              //     "${ApiConstants.baseUrl}" +
              //         jobdetailslist['company_logo'],
              //     fit: BoxFit.fill,
              //   ),
              // ),
              if (_selectedIndex == 0) SizedBox(height: deviceHeight * 0.02),
              if (_selectedIndex == 0)
                if (_selectedIndex == 0)
                  Text(
                    'Shabdarth Technologies',
                    style: GoogleFonts.manrope(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              if (_selectedIndex == 0) SizedBox(height: deviceHeight * 0.02),
              if (_selectedIndex == 0)
                Text(
                  'Mumbau' + ", " + "Pune",
                  style: GoogleFonts.manrope(
                    fontSize: 16,
                    color: ColorConstant.lightblack,
                  ),
                ),
              if (_selectedIndex == 0) SizedBox(height: deviceHeight * 0.02),
              if (_selectedIndex == 0)
                Container(
                  height: 99,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 0.1)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildInfoCard(
                            'Location',
                            'Mumabi',
                            'assets/images/map-pin.png',
                            deviceWidth,
                            deviceHeight,
                            Color(0xFF2DD4BF)),
                        // SizedBox(width: deviceWidth * 0.02),
                        _buildInfoCard(
                          "Job Type",
                          'Fill-time',
                          'assets/images/timer.png',
                          deviceWidth,
                          deviceHeight,
                          Color(0xFF887EF9),
                        ),
                        // SizedBox(width: deviceWidth * 0.02),
                        _buildInfoCard(
                            "Salaries",
                            '10000' + "-" + '30000',
                            'assets/images/dollar-circle.png',
                            deviceWidth,
                            deviceHeight,
                            ColorConstant.accentColor),
                      ],
                    ),
                  ),
                ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(listData.length, (index) {
                  return GestureDetector(
                    onTap: () => _onTabSelecteded(index),
                    child: Container(
                      height: 40,
                      width: 160,
                      decoration: BoxDecoration(
                        color: _selectedIndex == index
                            ? ColorConstant.backgroundColor
                            : ColorConstant.white,
                        border: Border.all(color: ColorConstant.bordercolor),
                        borderRadius: BorderRadius.circular(8),
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
                  );
                }),
              ),
              SizedBox(height: deviceHeight * 0.02),
              _selectedIndex == 0
                  ? _buildJobDescriptionContent(
                      deviceWidth,
                      deviceHeight,
                      'job description',
                    )
                  : _buildCompanyContent(
                      deviceWidth,
                      deviceHeight,
                      'assets/images/',
                      'Product Desiger',
                      "We are on a mission to accelerate the world's transition to design industry",
                      'www.abc.com',
                      'Mumbai',
                      '2016',
                      '20',
                      '100000',
                      fullText,
                      'Mumbai',
                    ),
              SizedBox(height: deviceHeight * 0.05),
            ],
          ),
        ),
      ),
      // bottomNavigationBar:
      bottomNavigationBar: _showBottomBar
          ? BottomAppBar(
              color: ColorConstant.white,
              elevation: 2.0,
              shape: CircularNotchedRectangle(),
              child: Padding(
                padding: const EdgeInsets.symmetric(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (_selectedIndex == 0 && widget.page == '')
                      Container(
                        width: double.infinity,
                        // padding: EdgeInsets.only(left: 16.0, right: 16.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ApplyJobSecussScreen()), // Replace `NewPage` with the page you want to navigate to
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorConstant.botton,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            minimumSize: Size(double.infinity, 50),
                          ),
                          child: Text(
                            "Apply for this job",
                            style: GoogleFonts.manrope(
                                fontSize: 16,
                                color: ColorConstant.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    if (_selectedIndex == 0 && widget.page == 'Applied')
                      Container(
                        decoration: BoxDecoration(
                            color:
                                ColorConstant.precentage, // Highlight selected
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                                color: ColorConstant.botton,
                                width: 2) // Border for selected item

                            ),
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("This job applied on 23 Dec 2024",
                              style: GoogleFonts.manrope(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: ColorConstant.black,
                              )),
                        )),
                      ),
                    if (_selectedIndex == 0 && widget.page == 'Shortlisted')
                      Container(
                        decoration: BoxDecoration(
                            color:
                                ColorConstant.precentage, // Highlight selected
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                                color: ColorConstant.botton,
                                width: 2) // Border for selected item

                            ),
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Your application marked on shortlisted",
                              style: GoogleFonts.manrope(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: ColorConstant.black,
                              )),
                        )),
                      ),
                  ],
                ),
              ),
            )
          : null, // Null removes the BottomAppBar
    );
  }

  Widget _buildCompanyInfo(String title, String subtitle, String image) {
    return Container(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                image,
                height: 20,
                width: 20,
              ),
              SizedBox(width: 16),
              Text(title,
                  style: GoogleFonts.manrope(
                      fontSize: 13,
                      color: ColorConstant.black,
                      fontWeight: FontWeight.bold))
            ],
          ),
          Text(
            truncateString(subtitle),
            style: GoogleFonts.manrope(
                fontSize: 13,
                color: ColorConstant.lightblack,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, String subtitle, String image,
      double deviceWidth, double deviceHeight, Color color) {
    return Container(
      width: 93,
      child: Column(
        children: [
          Image.asset(
            image,
            color: color,
            width: 24,
            height: 24,
          ),
          SizedBox(
            height: 8,
          ),
          // Icon(icon, color: ColorConstant.botton, size: deviceWidth * 0.07),
          // SizedBox(height: deviceHeight * 0.005),
          Text(
            title,
            style: GoogleFonts.manrope(
                fontSize: 10, color: ColorConstant.lightblack),
          ),
          SizedBox(height: 5),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              subtitle,
              style: GoogleFonts.manrope(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
