import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet_field.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ujilevel_bk/auth/signIn.dart';
import 'package:ujilevel_bk/components/constant.dart';
import 'package:ujilevel_bk/components/dropDown.dart';
import 'package:ujilevel_bk/components/textField.dart';
import 'package:ujilevel_bk/main.dart';
import 'package:ujilevel_bk/providers/auth.dart';

class AddConsultation extends StatefulWidget {
  const AddConsultation({super.key});

  @override
  State<AddConsultation> createState() => _AddConsultationState();
}

class _AddConsultationState extends State<AddConsultation> {
  String? id;

  bool onChange = false;
  List<String> selectedStudent = [];

  final List<String> typeList = [
    'Personal Counseling',
    'Social Counseling',
    'Career Counseling',
    'Study Counseling',
  ];
  String? selectedType;

  final List<String> careerList = [
    'I want go to Lecture',
    'I want go to Work',
    'I want to be Enterpreneurial',
    'I want getting Married',
  ];
  String? selectedCareer;

  TimeOfDay? selectedTime;
  DateTime? selectedDate;

  TextEditingController _timeController = TextEditingController();
  TextEditingController _dateController = TextEditingController();

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
      resizeToAvoidBottomInset : false,
      body: Form(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
              horizontal: width * .05, vertical: height * .03),
          margin: EdgeInsets.only(top: height * .05),
          child: Consumer<Auth>(
            builder: (context, auth, child){
              if(auth.authenticated){
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
                            fontSize: height * .028
                          ),
                        ),

                        SizedBox(height: height * 0.07,),

                        // Form Starts
                        Form(
                            child: Consumer<Auth>(
                              builder: (context, auth, child){
                                if(auth.authenticated){
                                  return Column(
                                    children: [

                                      // show multi select when counseling type is a Social counseling
                                      selectedType == 'Social Counseling'
                                      ? MultiSelectBottomSheetField<String>(
                                          items: studentList.map((item) => MultiSelectItem(item, item)).toList(),
                                          onConfirm: (values){
                                            setState(() {
                                              selectedStudent = values;
                                            });
                                          },
                                        initialValue: selectedStudent,
                                      )
                                      : CusTextField(
                                          context,
                                          label: "Name",
                                          labelColor: CusColors.header,
                                          value: auth.user?.name ?? '',
                                          enabled: false,
                                          onChanged: (val) => setState(() {
                                            onChange = true;
                                          })
                                      ),

                                      CusDropDown(
                                        context,
                                        label: "Counseling Type",
                                        selectedType: selectedType,
                                        hint: "Select Counseling Type",
                                        item: typeList,
                                        onChanged: (String? value){
                                          setState((){
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
                                          onChanged: (String? value){
                                            setState((){
                                              selectedCareer = value;
                                              onChange = true;
                                            });
                                          },
                                      )

                                      : Container(),

                                      CusTextField(
                                        context,
                                        label: "Title",
                                        labelColor: CusColors.header,
                                        hint: 'Consultation title',
                                        onChanged: (val) => setState(() {
                                          onChange = true;
                                        })
                                      ),
                                      CusTextField(
                                        context,
                                        label: "Time",
                                        labelColor: CusColors.header,
                                        hint: 'Pick the Time',
                                        controller: _timeController,
                                        onTap: () => selectTime(context),
                                        type: TextInputType.none,
                                        suffIcon: CupertinoIcons.time,
                                        onChanged: (val) => setState(() {
                                          onChange = true;
                                        })
                                      ),
                                      CusTextField(
                                          context,
                                          label: "Date",
                                          labelColor: CusColors.header,
                                          hint: 'Pick the Date',
                                          controller: _dateController,
                                          onTap: () => selectDate(context),
                                          type: TextInputType.none,
                                          suffIcon: IconlyLight.calendar,
                                          onChanged: (val) => setState(() {
                                            onChange = true;
                                          })
                                      ),
                                      CusTextField(
                                        context,
                                        label: "Place",
                                        labelColor: CusColors.header,
                                        hint: 'Choose the Place',
                                        onChanged: (val) => setState(() {
                                          onChange = true;
                                        })
                                      ),
                                      CusTextField(
                                        context,
                                        label: "Description",
                                        hint: "Describe your problem",
                                        labelColor: CusColors.header,
                                        optional: true,
                                        onChanged: (val) => setState(() {
                                          onChange = true;
                                        })
                                      ),
                                    ],
                                  );
                                } else {
                                  return SignIn();
                                }
                              }
                            ),
                        ),
                        // Form ends

                        Spacer(),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: onChange ? () => showAlert(
                                  context,
                                  title: "Confirm Discard Changes",
                                  content: "Are you sure want to discard all changes?",
                                  onYes: (){
                                    Navigator.pop(context);
                                    Get.back();
                                  }
                              ) : () => Get.back(),
                              style: ButtonStyle(
                                minimumSize: MaterialStatePropertyAll(
                                    Size(
                                      width * .4,
                                      height * .065,
                                    )
                                ),
                                shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0),
                                    side: BorderSide(
                                      width: 1,
                                      color: Colors.black
                                    )
                                  )
                                ),
                                shadowColor: MaterialStatePropertyAll(Colors.transparent),
                                backgroundColor: MaterialStatePropertyAll(Colors.transparent)
                              ),
                              child: Text(
                                  'Back',
                                style: GoogleFonts.mPlus1(
                                  color: Color(0xFF2c2c2c),
                                  fontWeight: FontWeight.w700
                                ),
                              ),
                            ),

                            AnimatedContainer(
                              duration: Duration(milliseconds: 200),
                              curve: Curves.easeIn,
                              decoration: BoxDecoration(
                                color: onChange ? Color(0xFF2c2c2c) : Color(0xFF2c2c2c).withOpacity(.25)
                              ),
                              child: ElevatedButton(
                                onPressed: onChange ? () => showAlert(
                                    context,
                                    title: "Confirm Request",
                                    content: "Do you want to start request?",
                                    onYes: (){
                                      // add save function here
                                      Navigator.pop(context);
                                      Get.back();
                                    }
                                ) : null,
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
                                      )
                                  ),
                                  backgroundColor: MaterialStatePropertyAll(Colors.transparent)
                                ),
                                child: Text(
                                    'Save',
                                  style: GoogleFonts.mPlus1(
                                      fontWeight: FontWeight.w700
                                  ),
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
            }
          ),
        ),
      ),
    );
  }

  Future<void> showAlert(BuildContext context, {
    required String? title,
    required String? content,
    required onYes,
    onNo
  }) async {
    await showCupertinoDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: Text(title ?? "Alert"),
          content: Text(content ?? "Are you sure?"),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              child: Text("Yes"),
              onPressed: onYes ?? () {
                Navigator.pop(context);
              },
            ),
            CupertinoDialogAction(
              child: Text("No"),
              isDestructiveAction: true,
              onPressed: onNo ?? () => Navigator.pop(context),
            ),
          ],
        )
    );
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child){
        return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child!,
        );
      }
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
        _timeController.text = selectedTime!.format(context); // Format the time based on the user's locale
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
