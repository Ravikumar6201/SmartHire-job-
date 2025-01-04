import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_application/Common/Contant.dart';

class ContactUsForm extends StatefulWidget {
  @override
  _ContactUsFormState createState() => _ContactUsFormState();
}

class _ContactUsFormState extends State<ContactUsForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Process the form data
      String name = _nameController.text;
      String email = _emailController.text;
      String subject = _subjectController.text;
      String message = _messageController.text;

      // Example: Print the values
      print('Name: $name');
      print('Email: $email');
      print('Subject: $subject');
      print('Message: $message');
      _formKey.currentState!.reset();
      _showSuccessDialog(context);
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text('Your message has been sent!')),
      // );
    }
  }

  // Function to show the success dialog
  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ColorConstant.themeGradientEnd,
          title: Row(
            children: [
              // Icon(Icons.check_circle, color: Colors.green),
              SizedBox(width: 10),
              Text(
                'Success',
                style: GoogleFonts.manrope(),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/images/greentick.gif',
                  width: 100, height: 100),
              SizedBox(height: 20),
              Text('Your application was sent successfully!',
                  style: GoogleFonts.manrope(), textAlign: TextAlign.center),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Contact Us',
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInputField(
                  label: "Name",
                  icon: Icons.person_outline,
                  controller: _nameController,
                  showPrefixIcon: true,
                  readonly: false,
                  maxLines: 1,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                _buildInputField(
                  label: "Email",
                  icon: Icons.email_outlined,
                  controller: _emailController,
                  showPrefixIcon: true,
                  readonly: false,
                  maxLines: 1,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                _buildInputField(
                  label: "Subject",
                  icon: Icons.subject_outlined,
                  controller: _subjectController,
                  showPrefixIcon: true,
                  readonly: false,
                  maxLines: 1,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the subject';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                _buildInputField(
                  label: "Message",
                  icon: Icons.message_outlined,
                  controller: _messageController,
                  showPrefixIcon: false,
                  readonly: false,
                  maxLines: 4,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your message';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 24),
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
                                color: ColorConstant.lightblack, fontSize: 14)),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          _submitForm();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorConstant.botton,
                          padding: EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Text("Send",
                            style: GoogleFonts.manrope(
                              fontSize: 14,
                              color: ColorConstant.white,
                            )),
                      ),
                    ),
                  ],
                ),
              ],
            ),
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
    required bool readonly,
    required int maxLines,
    required String? Function(String?) validator, // Add a validator parameter
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: GoogleFonts.manrope(
                fontSize: 14, color: ColorConstant.lightblack)),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          readOnly: readonly,
          style: GoogleFonts.manrope(fontSize: 14, color: ColorConstant.black),
          maxLines: maxLines,
          decoration: InputDecoration(
            hintStyle: GoogleFonts.manrope(
                color: ColorConstant.lightblack, fontSize: 14),
            prefixIcon: showPrefixIcon
                ? Icon(
                    icon,
                    color: ColorConstant.editinfo,
                  )
                : null, // Conditionally show the icon or set it to null
            prefixStyle: GoogleFonts.manrope(
              color: ColorConstant.lightblack,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
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
          validator: validator, // Use the validator here
        ),
      ],
    );
  }
}
