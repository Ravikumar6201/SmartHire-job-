// ignore_for_file: prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, prefer_interpolation_to_compose_strings, unnecessary_string_interpolations

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:job_application/Common/Contant.dart';
import 'package:job_application/Common/Url.dart';
import 'package:job_application/Core/Provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfile extends StatefulWidget {
  String image, name, jobtitle, about;
  @override
  EditProfile(
      {required this.image,
      required this.name,
      required this.jobtitle,
      required this.about});
  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late TextEditingController fullNameController;
  late TextEditingController jobTitleController;
  late TextEditingController aboutController;
  String? Token;
  String? userID;

  @override
  void initState() {
    super.initState();
    fullNameController = TextEditingController(text: widget.name);
    jobTitleController = TextEditingController(text: widget.jobtitle);
    aboutController = TextEditingController(text: widget.about);
    getData();
  }

  getData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Token = preferences.getString('token');
    userID = preferences.getString('userid');
    setState(() {
      Token;
      userID;
    });
  }

//image pickr
  XFile? _selectedImage;

  // Create an instance of ImagePicker
  final ImagePicker _picker = ImagePicker();

  // Function to pick an image
  Future<void> _pickImage() async {
    // Show bottom sheet to choose from gallery, camera or delete
    final String? option = await showModalBottomSheet<String>(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: [
            ListTile(
              leading: Text(
                'Profile Photo',
                style: GoogleFonts.manrope(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: ColorConstant.black),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            ListTile(
              leading: Icon(
                Icons.photo_album_outlined,
                color: ColorConstant.lightblack,
              ),
              title: Text(
                'Choose from Gallery',
                style: GoogleFonts.manrope(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: ColorConstant.lightblack),
              ),
              onTap: () {
                Navigator.pop(context, 'gallery');
              },
            ),
            SizedBox(
              height: 16,
            ),
            // ListTile(
            //   leading: Icon(Icons.photo_library),
            //   title: Text('Choose from Gallery'),
            //   onTap: () {
            //     Navigator.pop(context, 'gallery');
            //   },
            // ),
            ListTile(
              leading: Icon(
                Icons.camera_alt_outlined,
                color: ColorConstant.lightblack,
              ),
              title: Text(
                'Take a Photo',
                style: GoogleFonts.manrope(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: ColorConstant.lightblack),
              ),
              onTap: () {
                Navigator.pop(context, 'camera');
              },
            ),
            // if (_selectedImage !=
            //     null) // Show the delete option only if an image is selected
            ListTile(
              leading: Icon(
                Icons.delete,
                color: ColorConstant.backcolorrejecttext,
              ),
              title: Text(
                'Delete Current Image',
                style: GoogleFonts.manrope(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: ColorConstant.backcolorrejecttext),
              ),
              onTap: () {
                Navigator.pop(context, 'delete');
              },
            ),
          ],
        );
      },
    );

    // Handle the user's choice
    if (option != null) {
      switch (option) {
        case 'gallery':
          // Pick an image from the gallery
          final XFile? pickedFile =
              await _picker.pickImage(source: ImageSource.gallery);
          if (pickedFile != null) {
            setState(() {
              _selectedImage = pickedFile; // Set the selected image
            });
            UserProvider()
                .ProfileImageupload(
                    userID.toString(), Token.toString(), _selectedImage!)
                .then((response) {
              if (response['success']) {
                Fluttertoast.showToast(
                  msg: response['data']['message'],
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.TOP, // Show toast at the top
                  timeInSecForIosWeb: 1,
                  backgroundColor: ColorConstant.backgraund,
                  textColor: ColorConstant.white,
                  fontSize: 16.0,
                );
              } else {}
            });
          }
          break;
        case 'camera':
          // Take a new photo with the camera
          final XFile? pickedFile =
              await _picker.pickImage(source: ImageSource.camera);
          if (pickedFile != null) {
            setState(() {
              _selectedImage = pickedFile; // Set the new photo
            });
            UserProvider()
                .ProfileImageupload(
                    userID.toString(), Token.toString(), _selectedImage!)
                .then((response) {
              if (response['success']) {
                Fluttertoast.showToast(
                  msg: response['data']['message'],
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.TOP, // Show toast at the top
                  timeInSecForIosWeb: 1,
                  backgroundColor: ColorConstant.backgraund,
                  textColor: ColorConstant.white,
                  fontSize: 16.0,
                );
              } else {}
            });
          }
          break;
        case 'delete':
          // Delete the current image
          setState(() {
            _selectedImage = null; // Clear the selected image
          });
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UserProvider>();
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Edit Profile',
            style: GoogleFonts.manrope(
                fontSize: 16,
                color: ColorConstant.black,
                fontWeight: FontWeight.bold),
          ),
          centerTitle: false,
          actions: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
                // Navigator.pushAndRemoveUntil(
                //   context,
                //   MaterialPageRoute(builder: (context) => SettingScreen()),
                //   (Route<dynamic> route) => false,
                // );
              },
              child: Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Image.asset(
                    'assets/images/settingimg/settings.png',
                    height: 25,
                    width: 25,
                    fit: BoxFit.contain,
                  )),
            )
          ],
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
      body: provider.isLoading
          ? Center(
              child: CircularProgressIndicator(
              color: ColorConstant.botton,
            ))
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          if (widget.image != '')
                            CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(
                                  "${ApiConstants.baseUrl}" +
                                      widget
                                          .image), // Replace with your image asset
                            ),
                          if (widget.image == '')
                            CircleAvatar(
                              radius: 50,
                              backgroundImage: AssetImage(
                                  'assets/images/settingimg/user-profile.jpg'), // Replace with your image asset
                            ),
                          if (_selectedImage != null)
                            ClipOval(
                              child: Image.file(
                                File(_selectedImage!
                                    .path), // Display the selected image
                                fit: BoxFit.cover,
                                width: 100, // Adjust the width as needed
                                height: 100,
                              ),
                            ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: CircleAvatar(
                              radius: 15,
                              backgroundColor: ColorConstant.botton,
                              child: InkWell(
                                  onTap:
                                      _pickImage, // Open the image picker on tap
                                  child: Icon(Icons.add,
                                      color: ColorConstant.white, size: 18)
                                  // _selectedImage == null
                                  //     ? Icon(Icons.add,
                                  //         color: ColorConstant.white,
                                  //         size:
                                  //             18) // Show add icon if no image selected
                                  //     : ClipOval(
                                  //         child: Image.file(
                                  //           File(_selectedImage!
                                  //               .path), // Display the selected image
                                  //           fit: BoxFit.cover,
                                  //           width: 30, // Adjust the width as needed
                                  //           height: 30, // Adjust the height as needed
                                  //         ),
                                  //       ),
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    Center(
                      child: Column(
                        children: [
                          Text(
                            widget.name,
                            style: GoogleFonts.manrope(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4),
                          Text(
                            widget.jobtitle,
                            style: GoogleFonts.manrope(
                                fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 32),
                    _buildInputField(
                        label: "Full Name",
                        icon: Icons.person_outline,
                        controller: fullNameController,
                        showPrefixIcon: true),
                    SizedBox(height: 16),
                    _buildInputField(
                        label: "Job Title",
                        icon: Icons.business_center_outlined,
                        controller: jobTitleController,
                        showPrefixIcon: true),
                    SizedBox(height: 16),
                    _buildInputField(
                        label: "About",
                        icon: Icons.business_center_outlined,
                        controller: aboutController,
                        maxLines: 4,
                        showPrefixIcon: false),
                    SizedBox(height: 32),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              side: BorderSide(color: ColorConstant.lightblack),
                            ),
                            child: Text("Cancel",
                                style: GoogleFonts.manrope(
                                    color: ColorConstant.lightblack,
                                    fontSize: 14)),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              Map<String, dynamic> result =
                                  await provider.Profileupdate(
                                      userID.toString(),
                                      Token.toString(),
                                      fullNameController.text,
                                      jobTitleController.text,
                                      aboutController.text);
                              if (result['success']) {
                                // Handle successful registration
                                final data = result['data'];
                                Fluttertoast.showToast(
                                  msg: data['message'],
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity:
                                      ToastGravity.TOP, // Show toast at the top
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: ColorConstant.green,
                                  textColor: ColorConstant.white,
                                  fontSize: 16.0,
                                );
                              } else {
                                Fluttertoast.showToast(
                                  msg: result['data']['message'],
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity:
                                      ToastGravity.TOP, // Show toast at the top
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: ColorConstant.green,
                                  textColor: ColorConstant.white,
                                  fontSize: 16.0,
                                );
                              }
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorConstant.botton,
                              padding: EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: Text("Save",
                                style: GoogleFonts.manrope(
                                  fontSize: 14,
                                  color: ColorConstant.white,
                                )),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildInputField({
    required String label,
    required IconData icon,
    required TextEditingController controller,
    required bool
        showPrefixIcon, // Add a new parameter to control the visibility
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: GoogleFonts.manrope(
                fontSize: 14, color: ColorConstant.lightblack)),
        SizedBox(height: 8),
        TextField(
          controller: controller,
          style: GoogleFonts.manrope(
              fontSize: 14, color: ColorConstant.lightblack),
          maxLines: maxLines,
          decoration: InputDecoration(
            hintStyle: GoogleFonts.manrope(
                color: ColorConstant.lightblack, fontSize: 14),
            prefixIcon: showPrefixIcon
                ? Icon(
                    icon,
                    color: ColorConstant.botton,
                  )
                : null, // Conditionally show the icon or set it to null
            prefixStyle: GoogleFonts.manrope(
              color: ColorConstant.lightblack,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
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
            filled: true,
            fillColor: ColorConstant.transparent,
          ),
        ),
      ],
    );
  }
}
