// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bottom_cupertino_tabbar/bottom_cupertino_tabbar.dart';
import 'package:job_application/Common/Contant.dart';
import 'package:job_application/Setting.dart';
import 'package:job_application/UI/Home/Dashboard.dart';
import 'package:job_application/UI/Activity/Activitis.dart';
import 'package:job_application/UI/Profile/Profile.dart';
import 'package:job_application/UI/Saved/saved.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    Dashboard(),
    SavedJobScreen(),
    ActivityScreen(),
    SettingScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // Display the current page
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: _selectedIndex, // Set the currently selected index
        onTap: _onItemTapped, // Update the selected index on tap
        activeColor: ColorConstant.botton, // Set the color of the selected item
        inactiveColor:
            ColorConstant.bootombar, // Set the color of unselected items
        items: const [
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/images/home-2.png'), // Path to your asset
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_outline),
            label: 'Saved',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage(
                  'assets/images/chart-notification.png'), // Path to your asset
            ),
            label: 'Activity',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: 'Setting',
          ),
        ],
      ),
    );
  }
}
