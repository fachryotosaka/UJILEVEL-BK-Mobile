import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ujilevel_bk/auth/signIn.dart';
import 'package:ujilevel_bk/components/constant.dart';
import 'package:ujilevel_bk/components/dropDown.dart';
import 'package:ujilevel_bk/components/textField.dart';
import 'package:ujilevel_bk/controllers/consultation_controller.dart';
import 'package:ujilevel_bk/main.dart';
import 'package:ujilevel_bk/providers/auth.dart';
import 'package:intl/intl.dart';

class AddConsultation extends StatefulWidget {
  final VoidCallback refreshCallback;
  const AddConsultation({super.key, required this.refreshCallback});

  @override
  State<AddConsultation> createState() => _AddConsultationState();
}

class _AddConsultationState extends State<AddConsultation> {
  String? id;
  String? teacherId;
  String? serviceId = '3';
  String? title;
  String? place;
  String? description;

  String? selectedType;
  String? selectedCareer;
  TimeOfDay? selectedTime;
  DateTime? selectedDate;
  bool onChange = false;
  List<String> selectedStudent = [];

  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getTeacher();
  }

  Future<void> _getTeacher() async {
    ConsultationController controller = ConsultationController();
    try {
      final teacherList = await controller.getTeacher();
      setState(() {
        teacherId = teacherList[0]['id'].toString();
      });
    } catch (e) {
      // Handle the error
      print('Error: $e');
    }
  }

  Future<void> _addConsultation() async {
    ConsultationController controller = ConsultationController();
    String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate!);
    String formattedTime = DateFormat('HH:mm:ss').format(DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      selectedTime!.hour,
      selectedTime!.minute,
    ));
    try {
      Map<String, dynamic> data = {
        'service_id': serviceId,
        'student_id': id,
        'teacher_id': teacherId,
        'title': title,
        'place': place,
        'description': description,
        'time': formattedTime,
        'date': formattedDate,
        'career_type': selectedCareer
      };

      await controller.addConsultation(data);

      // Handle the API response, e.g., display a success message
    } catch (e) {
      print('Error adding consultation: $e');
      // Handle errors, e.g., show an error message to the user
    }
  }

  final List<String> typeList = [
    'Personal Counseling',
    'Social Counseling',
    'Career Counseling',
    'Study Counseling',
  ];

  final List<String> careerList = [
    'I want go to Lecture',
    'I want go to Work',
    'I want to be Enterpreneurial',
    'I want getting Married',
  ];

  final List<String> studentList = [
    'Flutter',
    'Node.Js',
    'React Native',
    'Java',
    'Docker',
    'MySql'
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
              horizontal: width * .05, vertical: height * .03),
          margin: EdgeInsets.only(top: height * .05),
          child: Consumer<Auth>(builder: (context, auth, child) {
            if (auth.authenticated) {
              id = auth.user!.id;
              return SingleChildScrollView(
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Page Title
                      Text(
                        "Request Consultation",
                        style: GoogleFonts.mPlus1(
                            fontWeight: FontWeight.w700,
                            fontSize: height * .028),
                      ),

                      SizedBox(
                        height: height * 0.07,
                      ),

                      // Form Starts
                      Form(
                        child: Consumer<Auth>(builder: (context, auth, child) {
                          if (auth.authenticated) {
                            return Column(
                              children: [
                                // show multi select when counseling type is a Social counseling
                                selectedType == 'Social Counseling'
                                    ? MultiSelectBottomSheetField<String>(
                                        items: studentList
                                            .map((item) =>
                                                MultiSelectItem(item, item))
                                            .toList(),
                                        onConfirm: (values) {
                                          setState(() {
                                            selectedStudent = values;
                                          });
                                        },
                                        initialValue: selectedStudent,
                                      )
                                    : CusTextField(context,
                                        label: "Name",
                                        labelColor: CusColors.header,
                                        value: auth.user?.name ?? '',
                                        enabled: false,
                                        onChanged: (val) => setState(() {
                                              onChange = true;
                                            })),

                                CusDropDown(
                                  context,
                                  label: "Counseling Type",
                                  selectedType: selectedType,
                                  hint: "Select Counseling Type",
                                  item: typeList,
                                  onChanged: (String? value) {
                                    setState(() {
                                      selectedType = value;
                                      onChange = true;
                                    });
                                  },
                                ),

                                // showing dropdown to select career plan
                                selectedType == 'Career Counseling'
                                    ? CusDropDown(
                                        context,
                                        label: "Career Plan",
                                        selectedType: selectedCareer,
                                        hint: "Select your Career Plan",
                                        item: careerList,
                                        onChanged: (String? value) {
                                          setState(() {
                                            selectedCareer = value;
                                            onChange = true;
                                          });
                                        },
                                      )
                                    : Container(),

                                CusTextField(context,
                                    label: "Title",
                                    labelColor: CusColors.header,
                                    hint: 'Consultation title',
                                    onChanged: (val) => setState(() {
                                          title = val;
                                          onChange = true;
                                        })),
                                CusTextField(context,
                                    label: "Time",
                                    labelColor: CusColors.header,
                                    hint: 'Pick the Time',
                                    controller: _timeController,
                                    onTap: () => selectTime(context),
                                    type: TextInputType.none,
                                    suffIcon: CupertinoIcons.time,
                                    onChanged: (val) => setState(() {
                                          onChange = true;
                                        })),
                                CusTextField(context,
                                    label: "Date",
                                    labelColor: CusColors.header,
                                    hint: 'Pick the Date',
                                    controller: _dateController,
                                    onTap: () => selectDate(context),
                                    type: TextInputType.none,
                                    suffIcon: IconlyLight.calendar,
                                    onChanged: (val) => setState(() {
                                          onChange = true;
                                        })),
                                CusTextField(context,
                                    label: "Place",
                                    labelColor: CusColors.header,
                                    hint: 'Choose the Place',
                                    onChanged: (val) => setState(() {
                                          place = val;
                                          onChange = true;
                                        })),
                                CusTextField(context,
                                    label: "Description",
                                    hint: "Describe your problem",
                                    labelColor: CusColors.header,
                                    optional: true,
                                    onChanged: (val) => setState(() {
                                          description = val;
                                          onChange = true;
                                        })),
                              ],
                            );
                          } else {
                            return const SignIn();
                          }
                        }),
                      ),
                      // Form ends

                      const Spacer(),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: onChange
                                ? () => showAlert(context,
                                        title: "Confirm Discard Changes",
                                        content:
                                            "Are you sure want to discard all changes?",
                                        onYes: () {
                                      Navigator.pop(context);
                                      Get.back();
                                    })
                                : () => Get.back(),
                            style: ButtonStyle(
                                minimumSize: MaterialStatePropertyAll(Size(
                                  width * .4,
                                  height * .065,
                                )),
                                shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(0),
                                        side: const BorderSide(
                                            width: 1, color: Colors.black))),
                                shadowColor: const MaterialStatePropertyAll(
                                    Colors.transparent),
                                backgroundColor: const MaterialStatePropertyAll(
                                    Colors.transparent)),
                            child: Text(
                              'Back',
                              style: GoogleFonts.mPlus1(
                                  color: const Color(0xFF2c2c2c),
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeIn,
                            decoration: BoxDecoration(
                                color: onChange
                                    ? const Color(0xFF2c2c2c)
                                    : const Color(0xFF2c2c2c).withOpacity(.25)),
                            child: ElevatedButton(
                              onPressed: onChange
                                  ? () => showAlert(context,
                                          title: "Confirm Request",
                                          content:
                                              "Do you want to start request?",
                                          onYes: () async {
                                        await _addConsultation();
                                        // // add save function here
                                        if (context.mounted) {
                                          Navigator.pop(context);
                                        }
                                        Get.back();
                                      })
                                  : null,
                              style: ButtonStyle(
                                  minimumSize: MaterialStatePropertyAll(
                                    Size(
                                      width * .4,
                                      height * .065,
                                    ),
                                  ),
                                  shape: MaterialStatePropertyAll(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0),
                                  )),
                                  backgroundColor:
                                      const MaterialStatePropertyAll(
                                          Colors.transparent)),
                              child: Text(
                                'Save',
                                style: GoogleFonts.mPlus1(
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            } else {
              return const HomePage();
            }
          }),
        ),
      ),
    );
  }

  Future<void> showAlert(BuildContext context,
      {required String? title,
      required String? content,
      required onYes,
      onNo}) async {
    await showCupertinoDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
              title: Text(title ?? "Alert"),
              content: Text(content ?? "Are you sure?"),
              actions: <CupertinoDialogAction>[
                CupertinoDialogAction(
                  onPressed: onYes ??
                      () {
                        Navigator.pop(context);
                      },
                  child: const Text("Yes"),
                ),
                CupertinoDialogAction(
                  isDestructiveAction: true,
                  onPressed: onNo ?? () => Navigator.pop(context),
                  child: const Text("No"),
                ),
              ],
            ));
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child!,
          );
        });
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
        _timeController.text = selectedTime!
            .format(context); // Format the time based on the user's locale
      });
    }
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2024),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _dateController.text = selectedDate!.toString().split(" ")[0];
      });
    }
  }

  @override
  void dispose() {
    _timeController.dispose();
    _dateController.dispose();
    super.dispose();
  }
}
