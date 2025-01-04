// ignore_for_file: must_be_immutable, non_constant_identifier_names, prefer_if_null_operators

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_application/Common/Contant.dart';
import 'package:intl/intl.dart';
import 'package:job_application/Common/Deletepopup.dart';
import 'package:job_application/Core/Provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailExperienceScreen extends StatefulWidget {
  String designation,
      worktype,
      companyname,
      startdate,
      enddate,
      rolenresponssibility;
  bool delete;
  @override
  DetailExperienceScreen(
      {required this.designation,
      required this.worktype,
      required this.companyname,
      required this.startdate,
      required this.enddate,
      required this.rolenresponssibility,
      required this.delete});
  @override
  _DetailExperienceScreenState createState() => _DetailExperienceScreenState();
}

class _DetailExperienceScreenState extends State<DetailExperienceScreen> {
  late TextEditingController positionController;
  late TextEditingController companyController;
  late TextEditingController descriptionController;
  String? start_month;
  String? start_year;
  String? end_month;
  String? end_year;

  @override
  void initState() {
    super.initState();
    positionController = TextEditingController(text: widget.designation);
    companyController = TextEditingController(text: widget.companyname);
    descriptionController =
        TextEditingController(text: widget.rolenresponssibility);
    startDate = widget.startdate;
    endDate = widget.enddate;

    UserProfile();
  }

  String? Token;
  String? userID;
  UserProfile() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Token = preferences.getString('token');
    userID = preferences.getString('userid');
    setState(() {
      Token;
      userID;
    });
    print(Token);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //get worktype
      context.read<UserProvider>().fetchWorktype(
            Token.toString(),
          );
    });
  }

  @override
  void dispose() {
    positionController.dispose();
    companyController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  String? workType = 'Intern';
  String? startDate;
  String? endDate;

  String? workid;
  int startyear = 0;
  int startmonth = 0;
  int endyear = 0;
  int endmonth = 0;
  Map<String, int>? StratDate;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UserProvider>();
    final worklist = provider.WorktypeList;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: Text(
          'Add Experience',
          style: GoogleFonts.manrope(
              fontSize: 16,
              color: ColorConstant.black,
              fontWeight: FontWeight.bold),
        ),
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset(
              'assets/images/backarrow.png',
              height: 100,
              width: 100,
              fit: BoxFit.contain,
            )),
      ),
      body: provider.isLoading
          ? Center(
              child: CircularProgressIndicator(
              color: ColorConstant.botton,
            ))
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Position Field
                  _buildInputField(
                    label: 'Designation',
                    controller: positionController,
                    hint: 'Enetr Designation ..',
                  ),
                  const SizedBox(height: 16),

                  // Work Type Dropdown
                  _buildDropdownField(
                    label: 'Work Type',
                    value: workType,
                    items: worklist,
                    onChanged: (value) {
                      setState(() {
                        workType = value;
                      });
                    },
                  ),
                  const SizedBox(height: 16),

                  // Company Name Field
                  _buildInputField(
                    label: 'Company Name',
                    controller: companyController,
                    hint: 'Enter Company name ..',
                  ),
                  const SizedBox(height: 16),

                  // Start and End Date
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Expanded(
                  //       child: Text('',
                  //           style: GoogleFonts.manrope(
                  //               fontSize: 14,
                  //               fontWeight: FontWeight.bold,
                  //               color: ColorConstant.lightblack)),
                  //     ),
                  //     const SizedBox(width: 8),
                  //     Expanded(
                  //       child: Text('',
                  //           style: GoogleFonts.manrope(
                  //               fontSize: 14,
                  //               fontWeight: FontWeight.bold,
                  //               color: ColorConstant.lightblack)),
                  //     ),
                  //   ],
                  // ),
                  SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildDateField(
                        label: 'Start',
                        date: startDate,
                        onTap: () async {
                          StratDate = await _pickDate(context, "start", null);
                          if (StratDate != null) {
                            setState(() {
                              startyear = StratDate!["year"]!;
                              startmonth = StratDate!["month"]!;
                              startDate = _formatEndDate(
                                  StratDate!["month"], StratDate!["year"]);
                              String monthName =
                                  _getMonthName(StratDate!["month"]!);
                              start_month = monthName.toString();
                              start_year = StratDate!["year"]!.toString();
                            });
                          } else {
                            Fluttertoast.showToast(
                              msg: 'Please Select Valied Date!',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity:
                                  ToastGravity.TOP, // Show toast at the top
                              timeInSecForIosWeb: 1,
                              backgroundColor: ColorConstant.red,
                              textColor: ColorConstant.white,
                              fontSize: 16.0,
                            );
                          }
                        },
                      ),
                      const SizedBox(width: 8),
                      _buildDateField(
                        label: 'End',
                        date: endDate,
                        onTap: () async {
                          if (StratDate != null) {
                            Map<String, int>? pickedDate =
                                await _pickDate(context, "end", StratDate);
                            if (pickedDate != null &&
                                    startyear <= pickedDate["year"]!
                                // &&
                                // startmonth <= pickedDate['month']!
                                ) {
                              setState(() {
                                endyear = pickedDate["year"]!;
                                endmonth = pickedDate["month"]!;
                                endDate = _formatEndDate(
                                    pickedDate["month"], pickedDate["year"]);
                                print(endDate);
                                String monthName =
                                    _getMonthName(pickedDate["month"]!);
                                end_month = monthName.toString();
                                end_year = pickedDate["year"].toString();
                              });
                            } else {
                              Fluttertoast.showToast(
                                msg: 'Please Select Valied Date!',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity:
                                    ToastGravity.TOP, // Show toast at the top
                                timeInSecForIosWeb: 1,
                                backgroundColor: ColorConstant.red,
                                textColor: ColorConstant.white,
                                fontSize: 16.0,
                              );
                            }
                          } else {
                            Fluttertoast.showToast(
                              msg: 'Please Select Start Date First!',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity:
                                  ToastGravity.TOP, // Show toast at the top
                              timeInSecForIosWeb: 1,
                              backgroundColor: ColorConstant.red,
                              textColor: ColorConstant.white,
                              fontSize: 16.0,
                            );
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Description Field
                  _buildInputField(
                    label: 'Description',
                    controller: descriptionController,
                    hint: 'Enter Description ..',
                    maxLines: 2,
                  ),
                  const SizedBox(height: 16),

                  // Add Media Button
                  /* Container(
              height: 56,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(width: 01, color: ColorConstant.botton)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add,
                    color: ColorConstant.editinfo,
                  ),
                  Text(
                    " Add Media",
                    style: GoogleFonts.manrope(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: ColorConstant.editinfo),
                  ),
                ],
              ),
            ),
           */
                  // const SizedBox(height: 24),

                  // Bottom Buttons
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
                            if (start_year != null &&
                                end_year != null &&
                                workid != null &&
                                descriptionController.text != '' &&
                                companyController.text != "" &&
                                positionController.text != "") {
                              Map<String, dynamic> result =
                                  await provider.addExprience(
                                      '',
                                      userID.toString(),
                                      Token.toString(),
                                      positionController.text,
                                      workid.toString(),
                                      companyController.text,
                                      start_month.toString(),
                                      start_year.toString(),
                                      end_month.toString(),
                                      end_year.toString(),
                                      descriptionController.text);
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
                                  backgroundColor: ColorConstant.red,
                                  textColor: ColorConstant.white,
                                  fontSize: 16.0,
                                );
                              }

                              Navigator.pop(context);
                            } else {
                              Fluttertoast.showToast(
                                msg: 'All field are required *',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity:
                                    ToastGravity.TOP, // Show toast at the top
                                timeInSecForIosWeb: 1,
                                backgroundColor: ColorConstant.red,
                                textColor: ColorConstant.white,
                                fontSize: 16.0,
                              );
                            }
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
                ],
              ),
            ),
    );
  }

  // Helper to build a text input field
  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    String? hint,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: GoogleFonts.manrope(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: ColorConstant.lightblack)),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          maxLines: maxLines,
          style: GoogleFonts.manrope(
              fontSize: 14,
              color: ColorConstant.black,
              fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.manrope(
                color: ColorConstant.black,
                fontSize: 14,
                fontWeight: FontWeight.bold),
            // Conditionally show the icon or set it to null
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
          // decoration: InputDecoration(
          //   hintText: hint,
          //   border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          //   contentPadding:
          //       const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          // ),
        ),
      ],
    );
  }

  // Helper to build a dropdown field
  Widget _buildDropdownField({
    required String label,
    required String? value,
    required List<dynamic> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: GoogleFonts.manrope(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: ColorConstant.lightblack)),
        const SizedBox(height: 6),
        DropdownButtonFormField<String>(
          // value: workid, // Use the selected workid
          onChanged: (String? newValue) {
            setState(() {
              workid =
                  newValue ?? ''; // Update the workid with the selected value
            });
          },

          dropdownColor: ColorConstant.white, // Background color for dropdown
          items: items.map((item) {
            return DropdownMenuItem<String>(
              value: item['id'] ?? '',
              // Assuming 'key' is the field you want to display in the dropdown
              child: Text(
                item['title'] ?? '', // Assuming 'value' is the display name
                style: GoogleFonts.manrope(
                  fontSize: 14,
                  color: ColorConstant.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }).toList(),
          style: GoogleFonts.manrope(
            fontSize: 14,
            color: ColorConstant.black,
            fontWeight: FontWeight.bold,
          ),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
              borderSide: BorderSide(
                color: ColorConstant.backcolorreject,
                width: 1,
              ),
            ),
            hintText:
                'Select Work Type', // This is the hint that will show when no value is selected

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(
                color: ColorConstant.backcolorreject,
                width: 1,
              ),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          ),
        )

        // DropdownButtonFormField<String>(
        //   value: value,
        //   onChanged: onChanged,
        //   dropdownColor:
        //       ColorConstant.backcolointerview, // Background color for dropdown
        //   items: items.map((item) {
        //     return DropdownMenuItem(
        //       value: item,
        //       child: Text(
        //         item,
        //         style: GoogleFonts.manrope(
        //           fontSize: 14,
        //           color: ColorConstant.black,
        //           fontWeight: FontWeight.bold,
        //         ),
        //       ),
        //     );
        //   }).toList(),
        //   style: GoogleFonts.manrope(
        //     fontSize: 14,
        //     color: ColorConstant.black,
        //     fontWeight: FontWeight.bold,
        //   ),
        //   decoration: InputDecoration(
        //     border: OutlineInputBorder(
        //       borderRadius: BorderRadius.circular(16.0),
        //     ),
        //     enabledBorder: OutlineInputBorder(
        //       borderRadius: BorderRadius.circular(16.0),
        //       borderSide: BorderSide(
        //         color: ColorConstant.backcolorreject,
        //         width: 1,
        //       ),
        //     ),
        //     focusedBorder: OutlineInputBorder(
        //       borderRadius: BorderRadius.circular(20.0),
        //       borderSide: BorderSide(
        //         color: ColorConstant.backcolorreject,
        //         width: 1,
        //       ),
        //     ),
        //     contentPadding:
        //         const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        //   ),
        // ),
      ],
    );
  }

  // Helper to build a date picker field
  Widget _buildDateField({
    required String label,
    required String? date,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(label,
            style: GoogleFonts.manrope(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: ColorConstant.lightblack)),
        SizedBox(height: 6),
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 30),
            decoration: BoxDecoration(
              border: Border.all(color: ColorConstant.bordercolor),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              date != null ? date : 'Select Date',
              style: GoogleFonts.manrope(
                  color: ColorConstant.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  // Helper to show date picker
  String formatDate(DateTime date) {
    return DateFormat('MMM yyyy').format(date);
  }

// The method to show the dialog for selecting a year and month
// The method to show the dialog for selecting a year and month
  Future<Map<String, int>?> _pickDate(
      BuildContext context, String type, Map<String, int>? startDate) async {
    int currentYear = DateTime.now().year;
    int currentMonth = DateTime.now().month;

    // Set default year and month based on type
    int selectedYear =
        type == "start" ? currentYear : startDate?['year'] ?? currentYear;
    int selectedMonth =
        type == "start" ? currentMonth : startDate?['month'] ?? currentMonth;

    return showDialog<Map<String, int>>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16), // Rounded corners
          ),
          title:
              Text(type == "start" ? 'Select Start Date' : 'Select End Date'),
          content: SizedBox(
            height: 400, // Adjust the height as needed
            width: 300,
            child: StatefulBuilder(
              builder: (BuildContext context,
                  void Function(void Function()) setState) {
                return Column(
                  children: [
                    // Year Selection Dropdown
                    DropdownButton<int>(
                      value: selectedYear,
                      isExpanded: true,
                      items: List.generate(
                        currentYear - 1950 + 1,
                        (index) {
                          int year = 1950 + index;
                          if (type == "end" &&
                              startDate != null &&
                              year < startDate['year']!) {
                            return null; // Skip years before the start year
                          }
                          return DropdownMenuItem(
                            value: year,
                            child: Text(year.toString()),
                          );
                        },
                      ).whereType<DropdownMenuItem<int>>().toList(),
                      onChanged: (int? year) {
                        if (year != null) {
                          setState(() {
                            selectedYear = year;
                            // Adjust selected month based on the year
                            if (type == "end" &&
                                startDate != null &&
                                selectedYear == startDate['year']! &&
                                selectedMonth < startDate['month']!) {
                              selectedMonth = startDate['month']!;
                            } else if (selectedYear == currentYear &&
                                selectedMonth > currentMonth) {
                              selectedMonth = currentMonth;
                            }
                          });
                        }
                      },
                      dropdownColor: Colors.white,
                    ),
                    const SizedBox(height: 16),
                    // Month Selection List
                    Expanded(
                      child: ListView.builder(
                        itemCount: 12, // Show all months for past years
                        itemBuilder: (BuildContext context, int index) {
                          int monthNumber = index + 1;

                          // Disable invalid months based on the type
                          bool isDisabled = (type == "end" &&
                                  startDate != null &&
                                  ((selectedYear == startDate['year']! &&
                                          monthNumber < startDate['month']!) ||
                                      (selectedYear == currentYear &&
                                          monthNumber > currentMonth))) ||
                              (type == "start" &&
                                  selectedYear == currentYear &&
                                  monthNumber > currentMonth);

                          String monthName = _getMonthName(monthNumber);

                          return ListTile(
                            enabled: !isDisabled,
                            title: Text(
                              monthName,
                              style: TextStyle(
                                color: isDisabled ? Colors.grey : Colors.black,
                              ),
                            ),
                            onTap: !isDisabled
                                ? () {
                                    Navigator.of(context).pop({
                                      "month": monthNumber,
                                      "year": selectedYear,
                                    }); // Return selected month and year
                                  }
                                : null,
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

// Helper function to get month name from number
  String _getMonthName(int month) {
    List<String> monthNames = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return monthNames[month - 1]; // Correctly fetches the month name
  }

  // Helper method to format the date in "Jan-YYYY" format
  String _formatEndDate(int? month, int? year) {
    if (month != null && year != null) {
      String monthName = _getMonthName(month); // Get full month name
      String shortMonthName =
          monthName.substring(0, 3); // Get the first 3 letters (Jan, Feb, etc.)
      return '$shortMonthName-$year'; // Format as "Jan-2024"
    }
    return ''; // Return empty string if month or year is null
  }
}
