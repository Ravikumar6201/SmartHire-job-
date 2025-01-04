import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_application/Common/Contant.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  // Dummy data stored as a Map
  final Map<String, String> aboutUsData = {
    "title": "About Us",
    "description": """
      <p>Welcome to <strong>Our Company</strong>! We are dedicated to providing top-quality services to our customers.</p>
      <p><strong>Our Mission:</strong> To deliver innovative and reliable solutions that exceed customer expectations.</p>
      <p><strong>Our Vision:</strong> To be a global leader in our industry, setting benchmarks for excellence.</p>
      <p>Thank you for being a part of our journey. Together, we can achieve greatness!</p>
      <p><em>Contact us at <a href="mailto:info@ourcompany.com">info@ourcompany.com</a></em></p>
    """,
    "image": "assets/images/Logo.png", // Replace with your image path
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'About Us',
            style: GoogleFonts.manrope(
                fontSize: 16,
                color: ColorConstant.black,
                fontWeight: FontWeight.bold),
          ),
          centerTitle: false,
          // actions: [
          //   IconButton(
          //       onPressed: () {},
          //       icon: Icon(
          //         Icons.settings_outlined,
          //         size: 24,
          //       )),
          // ],
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset(
              'assets/images/backarrow.png',
              height: 100,
              width: 100,
              fit: BoxFit.contain,
            ),
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Section
              if (aboutUsData["image"] != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    aboutUsData["image"]!,
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              const SizedBox(height: 01.0),

              // Description Section (HTML formatted)
              Html(
                data: aboutUsData["description"],
                style: {
                  "p": Style(
                    fontSize: FontSize.large,
                    lineHeight: LineHeight(1.6),
                    color: Colors.black87,
                  ),
                  "strong": Style(fontWeight: FontWeight.bold),
                  "em": Style(fontStyle: FontStyle.italic),
                  "a": Style(color: Colors.blue),
                },
                // onLinkTap: (url, context, attributes, element) {
                //   // Handle link taps (e.g., open email or URL)
                //   if (url != null) {
                //     print("Clicked link: $url");
                //   }
                // },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
