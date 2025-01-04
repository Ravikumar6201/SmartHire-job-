// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_application/Common/Contant.dart';
import 'package:job_application/UI/Home/HomeScreen.dart';
import 'package:job_application/UI/JobApply/JobDetails.dart';
import 'package:job_application/UI/Notifications/notifications.dart';
import 'package:job_application/UI/Saved/Recentjob.dart';

class AllpostedJob extends StatefulWidget {
  String headername;

  @override
  AllpostedJob({required this.headername});
  @override
  State<AllpostedJob> createState() => _AllpostedJobState();
}

class _AllpostedJobState extends State<AllpostedJob> {
  final List<Map<String, dynamic>> recentList = [
    {
      'companyLogo': 'assets/images/Vector.png', // Icon for the company logo
      'icon': Icons.bookmark, // Additional icon
      'iconcolor': ColorConstant.botton, // Color for the icon
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
      'icon': Icons.bookmark,
      'iconcolor': ColorConstant.botton,
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
      'icon': Icons.bookmark,
      'iconcolor': ColorConstant.botton,
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
    {
      'companyLogo': 'assets/images/Dropbox.png',
      'icon': Icons.bookmark,
      'iconcolor': ColorConstant.botton,
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
      'icon': Icons.bookmark,
      'iconcolor': ColorConstant.botton,
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text(widget.headername,
        //     style: GoogleFonts.manrope(
        //         color: ColorConstant.black,
        //         fontSize: 16,
        //         fontWeight: FontWeight.bold)),
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
                )),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          shrinkWrap: true,
          physics: AlwaysScrollableScrollPhysics(), // Disables scrolling
          itemCount: recentList.length, // Adjust item count as needed
          itemBuilder: (context, index) {
            var recent = recentList[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => JobDetailsScreen(
                    //         listid: '',
                    //             page: '',
                    //           )), // Replace `NewPage` with the page you want to navigate to
                    // );
                  },
                  child: Container(
                    height: 200,
                    margin: EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 0.5, color: ColorConstant.bordercolor),
                        borderRadius: BorderRadius.circular(16)),
                    child: JobCardRecent(
                      city: '',
                      country: '',
                      views: 0,
                      applicants: 0,
                      is_saved: false,
                      companyLogo: recent['companyLogo'],
                      // icon: recent['icon'],
                      // iconcolor: recent['iconcolor'],
                      companyName: recent['companyName'],
                      jobTitle: recent['jobTitle'],
                      location: recent['location'],
                      jobType: recent['jobType'],
                      description: recent['description'],
                      // applicants: recent['applicants'],
                      // views: recent['views'],
                      timestamp: recent['timestamp'],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
