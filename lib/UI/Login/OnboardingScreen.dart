// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_application/Common/Contant.dart';
import 'package:job_application/UI/Login/login.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: screenSize.height * 0.02,
          horizontal: screenSize.width * 0.04,
        ),
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                children: [
                  // First onboarding page
                  _buildOnboardingPage(
                    image: 'assets/images/onboarding2.png',
                    title: 'Your Career Journey Starts Here',
                    description:
                        'Discover jobs that match your skills, experience, and preferences. Smart Hire makes finding your dream job simple and personalized.',
                    screenSize: screenSize,
                  ),
                  // Second onboarding page
                  _buildOnboardingPage(
                    image: 'assets/images/onboarding1.png',
                    title: 'Your Dream Job Awaits',
                    description:
                        'Ready to take the next step in your career? Create your profile and explore endless possibilities with SmartHire!',
                    screenSize: screenSize,
                  ),
                ],
              ),
            ),
            // Smooth page indicator and "Get Started" button
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: screenSize.height * 0.04,
              ),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      final currentPage = _pageController.page?.round() ?? 0;
                      if (currentPage < 1) {
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        // Go to the next screen or do something on the last page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  LoginScreen()), // Replace `NewPage` with the page you want to navigate to
                        ); // Change '/home' to your target route
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        vertical: screenSize.height * 0.02,
                        horizontal: screenSize.width * 0.25,
                      ),
                      backgroundColor: ColorConstant.botton,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ), // Button color
                    ),
                    child: Text(
                      'Get Started',
                      style: GoogleFonts.manrope(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: ColorConstant.white),
                    ),
                  ),
                  SizedBox(height: 20),
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: 2,
                    effect: CustomizableEffect(
                      activeDotDecoration: DotDecoration(
                        height: screenSize.height * 0.01,
                        width: screenSize.width * 0.1,
                        color: ColorConstant.botton, // Active dot color
                        borderRadius: BorderRadius.circular(5),
                      ),
                      dotDecoration: DotDecoration(
                        height: screenSize.height * 0.01,
                        width: screenSize.width * 0.02,
                        color: Colors.grey, // Inactive dot color
                        borderRadius: BorderRadius.circular(2.5),
                      ),
                      spacing: screenSize.width * 0.02,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOnboardingPage({
    required String image,
    required String title,
    required String description,
    required Size screenSize,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.04),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 40.0, right: 0),
              child: TextButton(
                onPressed: () {
                  // Skip action
                },
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: Text(
                    "SKIP",
                    style: GoogleFonts.manrope(
                        color: ColorConstant.skip,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          Spacer(flex: 1),
          Center(
            child: Image.asset(
              image,
              height: screenSize.height * 0.4,
              fit: BoxFit.contain,
            ),
          ),
          Spacer(flex: 1),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.manrope(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: ColorConstant.black,
            ),
          ),
          SizedBox(height: 16),
          Text(
            description,
            textAlign: TextAlign.center,
            style: GoogleFonts.manrope(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          Spacer(flex: 2),
        ],
      ),
    );
  }
}
