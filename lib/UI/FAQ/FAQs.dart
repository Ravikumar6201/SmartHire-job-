import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';

import 'package:job_application/Common/Contant.dart'; // For Future.delayed

class FAQsScreen extends StatefulWidget {
  const FAQsScreen({super.key});

  @override
  State<FAQsScreen> createState() => _FAQsScreenState();
}

class _FAQsScreenState extends State<FAQsScreen> {
  Future<List<Map<String, String>>> fetchDummyFAQs() async {
    // Simulating a network delay
    await Future.delayed(const Duration(seconds: 2));

    // Dummy data
    return [
      {
        "question": "What is Flutter?",
        "answer":
            "Flutter is an open-source UI software development toolkit by Google.",
      },
      {
        "question": "How do I use this app?",
        "answer":
            "You can navigate through the app using the menu at the bottom.",
      },
      {
        "question": "Is Flutter free to use?",
        "answer": "Yes, Flutter is free and open-source for everyone to use.",
      },
      {
        "question": "Does Flutter support web development?",
        "answer": "Yes, Flutter can be used to build web applications.",
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQs',
            style: GoogleFonts.manrope(
                color: ColorConstant.black,
                fontSize: 16,
                fontWeight: FontWeight.bold)),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Image.asset(
            'assets/images/backarrow.png',
            height: 100,
            // width: 100,
            fit: BoxFit.contain,
          ),
        ),
        backgroundColor: ColorConstant.white,
        elevation: 0,
      ),
      body: FutureBuilder<List<Map<String, String>>>(
        future: fetchDummyFAQs(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show loading spinner
            return Center(child: CircularProgressIndicator(
              color: ColorConstant.botton,
            ));
          } else if (snapshot.hasError) {
            // Show error message
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            // Show message if no FAQs are available
            return const Center(child: Text('No FAQs available.'));
          } else {
            // Render the FAQ list
            final faqs = snapshot.data!;
            return ListView.builder(
              itemCount: faqs.length,
              itemBuilder: (context, index) {
                final faq = faqs[index];
                return ExpansionTile(
                  title: Text(
                    faq['question']!,
                    style: GoogleFonts.manrope(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
                      child: Text(faq['answer']!, style: GoogleFonts.manrope()),
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
