// ignore_for_file: prefer_const_constructors, prefer_is_empty, non_constant_identifier_names, unused_local_variable, empty_catches, avoid_types_as_parameter_names, use_key_in_widget_constructors, await_only_futures, avoid_print

import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:job_application/Common/Contant.dart';
import 'package:job_application/Core/Provider.dart';
import 'package:job_application/UI/Home/HomeScreen.dart';
import 'package:job_application/UI/Login/OnboardingScreen.dart';
import 'package:job_application/UI/Login/SplashScreen.dart';
import 'package:job_application/firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// import 'package:timezone/data/latest.dart' as tz;
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Initialize Firebase only if not already initialized
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        name: 'SmartHire',
        options: DefaultFirebaseOptions.currentPlatform,
      );
      // await Firebase.initializeApp(
      //   options: DefaultFirebaseOptions.currentPlatform,
      // );
      debugPrint("Firebase initialized successfully.");
    } else {
      debugPrint("Firebase already initialized. Skipping initialization.");
    }

    // Initialize other services
    await SharedPreferences.getInstance();
    FlutterLocalNotificationsPlugin();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    runApp(MyApp());
  } catch (e, stackTrace) {
    debugPrint('Error during Firebase initialization: $e');
    debugPrint('Stack trace: $stackTrace');
    // runApp(ErrorScreen(error: e.toString()));
  }
}

late Widget? showFirstScreen;

class MyApp extends StatefulWidget {
  static String? mobilenumber = '';

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isFirstLoad = true;

  @override
  void initState() {
    super.initState();
    getInitialScreen();
    checkLocationPermission();
  }

  checkLocationPermission() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      isFirstLoad = false;
    });
  }

  Future<void> getInitialScreen() async {
    String mobileno = '';
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      mobileno = preferences.getString('userid') ?? '';
    } catch (e) {
      print('Error while getting initial screen: $e');
    }
    setState(() {
      showFirstScreen = mobileno.isNotEmpty ? HomeScreen() : OnboardingScreen();
    });
    await Future.delayed(Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaleFactor: 1.0, // Prevent text scaling
              size: MediaQuery.of(context)
                  .size, // Prevent screen zoom adjustments
            ),
            child: child!,
          );
        },
        // builder: (context, child) {
        //   return MediaQuery(
        //     data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        //     child: child!,
        //   );
        // },
        debugShowCheckedModeBanner: false,
        title: 'Job Application',
        theme: ThemeData(
          scaffoldBackgroundColor:
              ColorConstant.backgraund, // Set default background color to white
          appBarTheme: AppBarTheme(
            backgroundColor:
                ColorConstant.backgraund, // Set AppBar color to white
            iconTheme: IconThemeData(
                color: ColorConstant.black), // Set AppBar icon color to black
            titleTextStyle: TextStyle(
                color: ColorConstant.black,
                fontSize: 20), // Set AppBar title text color
            elevation: 0, // Remove shadow under the AppBar
          ),
        ),
        home: isFirstLoad ? SplashScreen() : showFirstScreen,
      ),
    );
  }
}
