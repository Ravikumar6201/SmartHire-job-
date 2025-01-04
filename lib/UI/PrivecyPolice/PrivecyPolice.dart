import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_application/Common/Contant.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivecyPoliceScreen extends StatefulWidget {
  @override
  State<PrivecyPoliceScreen> createState() => _PrivecyPoliceScreenState();
}

class _PrivecyPoliceScreenState extends State<PrivecyPoliceScreen> {
  late final WebViewController _webViewController;
  bool _isLoading = true; // Flag to track loading state

  @override
  void initState() {
    super.initState();
    // Initialize the WebView controller
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted) // Allow JavaScript
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() {
              _isLoading = true; // Show loader when page starts loading
            });
          },
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false; // Hide loader when page finishes loading
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(
          'https://smarthire.shandilyam.com/beta/admin/front-privacy'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Privacy Policy',
          style: GoogleFonts.manrope(
            fontSize: 16,
            color: ColorConstant.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
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
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            WebViewWidget(
              controller: _webViewController,
            ),
            if (_isLoading) // Display loader when _isLoading is true
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Container(
                  decoration: BoxDecoration(
                    color: ColorConstant.white,
                  ),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: ColorConstant.botton,
                      backgroundColor: ColorConstant.white,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
