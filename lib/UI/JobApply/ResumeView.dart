import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:dio/dio.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_application/Common/Contant.dart';
import 'package:job_application/Common/Url.dart';
import 'package:job_application/main.dart';
import 'package:path_provider/path_provider.dart';

class PdfPreviewPage extends StatelessWidget {
  final String pdfUrl;

  PdfPreviewPage({required this.pdfUrl});
  Future<void> downloadPdf(BuildContext context) async {
    try {
      // Get app's document directory
      final dir = await getApplicationDocumentsDirectory();
      final filePath =
          '${dir.path}/downloaded_file.pdf'; // Specify the file name

      // Download the PDF
      Dio dio = Dio();
      await dio.download(pdfUrl, filePath);

      // Show success toast
      Fluttertoast.showToast(
        msg: 'Resume Downloaded Successfully',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: ColorConstant.green,
        textColor: ColorConstant.white,
        fontSize: 16.0,
      );

      print('PDF saved to: $filePath');

      // Show notification
      const AndroidNotificationDetails androidDetails =
          AndroidNotificationDetails(
        'download_channel', // Channel ID
        'Downloads', // Channel Name
        channelDescription: 'Notifications for file downloads',
        importance: Importance.high,
        priority: Priority.high,
      );

      const NotificationDetails notificationDetails =
          NotificationDetails(android: androidDetails);

      await flutterLocalNotificationsPlugin.show(
        0, // Notification ID
        'Download Complete', // Title
        'Your file has been downloaded to: $filePath', // Body
        notificationDetails,
      );
    } catch (e) {
      // Show failure toast
      Fluttertoast.showToast(
        msg: 'Failed to download PDF: $e',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: ColorConstant.red,
        textColor: ColorConstant.white,
        fontSize: 16.0,
      );
      print('Error: $e');
    }
  }

  // Future<void> downloadPdf(BuildContext context) async {
  //   try {
  //     // Get app's document directory
  //     final dir = await getApplicationDocumentsDirectory();
  //     final filePath =
  //         '${dir.path}/downloaded_file.pdf'; // Specify the file name

  //     // Download the PDF
  //     Dio dio = Dio();
  //     await dio.download(pdfUrl, filePath);
  //     Fluttertoast.showToast(
  //       msg: 'Resume Downloaded Secussfully',
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.TOP, // Show toast at the top
  //       timeInSecForIosWeb: 1,
  //       backgroundColor: ColorConstant.green,
  //       textColor: ColorConstant.white,
  //       fontSize: 16.0,
  //     );

  //     // ScaffoldMessenger.of(context).showSnackBar(
  //     //   SnackBar(content: Text('PDF downloaded to $filePath')),
  //     // );

  //     print('PDF saved to: $filePath');
  //   } catch (e) {
  //     Fluttertoast.showToast(
  //       msg: 'Failed to download PDF: $e',
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.TOP, // Show toast at the top
  //       timeInSecForIosWeb: 1,
  //       backgroundColor: ColorConstant.red,
  //       textColor: ColorConstant.white,
  //       fontSize: 16.0,
  //     );
  //     // ScaffoldMessenger.of(context).showSnackBar(
  //     //   SnackBar(content: Text('Failed to download PDF: $e')),
  //     // );
  //     print('Error: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Resume',
            style: GoogleFonts.manrope(
                fontSize: 16,
                color: ColorConstant.black,
                fontWeight: FontWeight.bold),
          ),
          centerTitle: false,
          actions: [
            PopupMenuButton<String>(
              color: ColorConstant.white,
              onSelected: (value) {
                if (value == 'Download') {
                  downloadPdf(context);
                } else if (value == 'Cancel') {
                  // Navigator.of(context).pop();
                }
              },
              itemBuilder: (BuildContext context) {
                return {'Download', 'Cancel'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ],
          // actions: [
          //   IconButton(
          //     icon: Icon(Icons.download),
          //     onPressed: () => downloadPdf(context), // Trigger download
          //   ),
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
      body: const PDF().cachedFromUrl(
        pdfUrl,
        placeholder: (progress) => Center(
          child: CircularProgressIndicator(value: progress / 100),
        ),
        errorWidget: (error) => Center(
          child: Text('Failed to load PDF: $error'),
        ),
      ),
    );
  }
}
