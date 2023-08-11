import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:ujilevel_bk/components/constant.dart';
import 'package:ujilevel_bk/editConsultation.dart';
import 'package:ujilevel_bk/main.dart';
import 'package:ujilevel_bk/models/consultation.dart';
import 'package:ujilevel_bk/providers/auth.dart';

class Details extends StatelessWidget {
  final Consultation consultation;
  const Details({Key? key, required this.consultation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.symmetric(
                horizontal: width * .05, vertical: height * .05),
            child: Consumer<Auth>(
              builder: ((context, auth, child) {
                if (auth.authenticated) {
                  return Column(
                    children: [
                      Flexible(
                          flex: 0,
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () => Get.back(),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Text(
                                    String.fromCharCode(CupertinoIcons
                                        .chevron_left.codePoint),
                                    style: TextStyle(
                                        inherit: false,
                                        color: const Color(0xFF0F1828),
                                        fontSize: width * .045,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: CupertinoIcons
                                            .chevron_left.fontFamily,
                                        package: CupertinoIcons
                                            .chevron_left.fontPackage),
                                  ),
                                ),
                              ),

                              consultation.status == "waiting"
                                  ? Spacer()
                                  : Container(),

                              Flexible(
                                  flex: 20,
                                  child: Center(
                                    child: Text(
                                      "Detail",
                                      style: GoogleFonts.mPlus1(
                                          fontWeight: FontWeight.w700,
                                          color: CusColors.header,
                                          fontSize: width * .045),
                                    ),
                                  )
                              ),

                              consultation.status == "waiting"
                                ? GestureDetector(
                                  onTap: () => Get.to(EditConsultation(),
                                     transition: Transition.rightToLeftWithFade),
                                  child: Icon(
                                    Icons.edit_note_outlined,
                                    color: CusColors.subHeader,
                                  ),
                                )
                                : Container()
                            ],
                          )),
                      SizedBox(
                        height: height * .03,
                      ),
                      Flexible(
                          flex: 3,
                          child: ListView(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      consultation.title!,
                                      style: GoogleFonts.mPlus1(
                                          fontWeight: FontWeight.w700,
                                          color:
                                              CusColors.header.withOpacity(.9),
                                          fontSize: width * .072),
                                    ),
                                    SizedBox(
                                      height: height * .01,
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(right: width * .16),
                                      child: Text(
                                        consultation.description!,
                                        style: GoogleFonts.mulish(
                                            color: CusColors.footer,
                                            fontSize: width * .03),
                                      ),
                                    ),
                                    SizedBox(
                                      height: height * .05,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: width * .4,
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "NAME",
                                                  style: GoogleFonts.mulish(
                                                      color: CusColors.footer
                                                          .withOpacity(.8),
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: width * .02),
                                                ),
                                                Text(
                                                  auth.user?.name ?? '',
                                                  style: GoogleFonts.mPlus1(
                                                      color: CusColors.header,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: width * .04),
                                                ),
                                              ]),
                                        ),
                                        SizedBox(
                                          width: width * .15,
                                        ),
                                        Flexible(
                                          flex: 1,
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "TEACHER",
                                                  style: GoogleFonts.mulish(
                                                      color: CusColors.footer
                                                          .withOpacity(.8),
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: width * .02),
                                                ),
                                                Text(
                                                  consultation.teacher_name!,
                                                  style: GoogleFonts.mPlus1(
                                                      color: CusColors.header,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: width * .04),
                                                ),
                                              ]),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: height * .048,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: width * .4,
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "SERVICE",
                                                  style: GoogleFonts.mulish(
                                                      color: CusColors.footer
                                                          .withOpacity(.8),
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: width * .02),
                                                ),
                                                Text(
                                                  consultation.serviceName!,
                                                  style: GoogleFonts.mPlus1(
                                                      color: CusColors.header,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: width * .04),
                                                ),
                                              ]),
                                        ),
                                        SizedBox(
                                          width: width * .15,
                                        ),
                                        Flexible(
                                          flex: 1,
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Place",
                                                  style: GoogleFonts.mulish(
                                                      color: CusColors.footer
                                                          .withOpacity(.8),
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: width * .02),
                                                ),
                                                Text(
                                                  consultation.place!,
                                                  style: GoogleFonts.mPlus1(
                                                      color: CusColors.header,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: width * .04),
                                                ),
                                              ]),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: height * .048,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: width * .4,
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "STATUS",
                                                  style: GoogleFonts.mulish(
                                                      color: CusColors.footer
                                                          .withOpacity(.8),
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: width * .02),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      top: height * .014),
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 15,
                                                      vertical: 6),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    color:
                                                        const Color(0xFFFFF9F0),
                                                  ),
                                                  child: Text(
                                                    consultation.status!,
                                                    style: GoogleFonts.mPlus1(
                                                        color: const Color(
                                                            0xFFFFB033),
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: width * .032),
                                                  ),
                                                ),
                                              ]),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ))
                    ],
                  );
                } else {
                  return const HomePage();
                }
              }),
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.symmetric(vertical: height * .04),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: width * .32,
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                        blurRadius: 15,
                        offset: const Offset(0, 4),
                        color: Colors.black.withOpacity(.15))
                  ]),
                  child: ElevatedButton(
                      onPressed: () => Get.to(EditConsultation(), transition: Transition.fade),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(CusColors.mainColor),
                        padding: MaterialStatePropertyAll(
                            EdgeInsets.symmetric(vertical: height * .016)),
                      ),
                      child: Text(
                        "Messages",
                        style: GoogleFonts.mPlus1(
                            color: const Color(0xFFEAEBEF),
                            fontWeight: FontWeight.w700,
                            fontSize: width * .032),
                      )),
                ),
                Container(
                  width: width * .32,
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                        blurRadius: 15,
                        offset: const Offset(0, 4),
                        color: Colors.black.withOpacity(.15))
                  ]),
                  child: ElevatedButton(
                      onPressed: () => showAlert(
                          context,
                          title: "Confirm Canceling ",
                          content: "Are you sure want to cancel your consultation?",
                          onYes: (){
                            Navigator.pop(context);
                            Get.back();
                          }
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                              const MaterialStatePropertyAll(Color(0xFFFF4377)),
                          padding: MaterialStatePropertyAll(
                              EdgeInsets.symmetric(vertical: height * .016))),
                      child: Text(
                        "Cancel",
                        style: GoogleFonts.mPlus1(
                            color: const Color(0xFFEAEBEF),
                            fontWeight: FontWeight.w700,
                            fontSize: width * .032),
                      )),
                ),
              ],
            ),
          ),
        ],
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
}
