import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:ujilevel_bk/components/constant.dart';
import 'package:ujilevel_bk/controllers/consultation_controller.dart';
import 'package:ujilevel_bk/details.dart';
import 'package:ujilevel_bk/main.dart';
import 'package:ujilevel_bk/models/consultation.dart';
import 'package:ujilevel_bk/profile.dart';
import 'package:ujilevel_bk/providers/auth.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Consultation> _consultations = [];

  @override
  void initState() {
    super.initState();
    _fetchConsultation();
  }

  Future<void> _fetchConsultation() async {
    ConsultationController controller = ConsultationController();
    try {
      final consultations = await controller.getConsultation();
      setState(() {
        _consultations = consultations;
      });
    } catch (e) {
      // Handle the error
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    print(_consultations);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(
            horizontal: width * .05, vertical: height * .055),
        child: Consumer<Auth>(
          builder: ((context, auth, child) {
            if (auth.authenticated) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            auth.user?.name ?? '',
                            style: GoogleFonts.mPlus1(
                              color: CusColors.header,
                              fontWeight: FontWeight.w700,
                              fontSize: width * .055,
                            ),
                          ),
                          Text(
                            auth.user?.email ?? '',
                            style: GoogleFonts.mPlus1(
                                color: CusColors.subHeader.withOpacity(.5),
                                fontWeight: FontWeight.w700,
                                fontSize: width * .03),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () => Get.to(() => const Profile(),
                            transition: Transition.fade),
                        child: const CircleAvatar(
                          maxRadius: 25,
                          backgroundColor: Color(0xFF979797),
                          child: CircleAvatar(
                            maxRadius: 22,
                            backgroundImage: AssetImage("images/rendang.jpg"),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: height * .03,
                  ),
                  TextFormField(
                    style: GoogleFonts.mPlus1(
                      color: CusColors.subHeader,
                      fontWeight: FontWeight.w400,
                      fontSize: width * .028,
                      letterSpacing: .5,
                    ),
                    decoration: InputDecoration(
                        prefixIcon: Container(
                            margin: const EdgeInsets.only(right: 20, left: 15),
                            child: Icon(
                              IconlyLight.search,
                              color: CusColors.subHeader.withOpacity(.5),
                            )),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                color: CusColors.subHeader.withOpacity(0))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                color: CusColors.subHeader.withOpacity(.3))),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 10),
                        hintText: "Type anywhere to search...",
                        hintStyle: GoogleFonts.mulish(
                            color: CusColors.subHeader.withOpacity(.5),
                            fontWeight: FontWeight.w400,
                            fontSize: width * .028,
                            letterSpacing: .5),
                        suffixIcon: Container(
                            margin: const EdgeInsets.only(right: 10),
                            child: Icon(
                              IconlyLight.filter,
                              color: CusColors.subHeader.withOpacity(.5),
                            ))),
                  ),
                  SizedBox(
                    height: height * .045,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(bottom: height * .025),
                    child: Text(
                      "Schedule",
                      style: GoogleFonts.mPlus1(
                          color: CusColors.header.withOpacity(.98),
                          fontWeight: FontWeight.w700,
                          fontSize: width * .04),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 435,
                    alignment: Alignment.centerLeft,
                    child: ListView.builder(
                      itemCount: _consultations.length,
                      itemBuilder: (context, index) {
                        final consultation = _consultations[index];
                        return GestureDetector(
                          onTap: () => Get.to(Details(consultation: consultation),
                              transition: Transition.leftToRightWithFade),
                          child: Stack(children: [
                            Container(
                              height: height * .12,
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.only(left: 3, top: 3),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: const Color(0xffE2E8F0))),
                            ),
                            Container(
                              height: height * .12,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 14, horizontal: 25),
                              margin: const EdgeInsets.only(right: 3),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: const Color(0xffE2E8F0))),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: width * .5,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          consultation.title!,
                                          style: GoogleFonts.mulish(
                                              color: const Color(0xff1E293B),
                                              fontWeight: FontWeight.w700,
                                              fontSize: width * .05),
                                        ),
                                        SizedBox(
                                          height: height * .002,
                                        ),
                                        Text(
                                          consultation.description!,
                                          style: GoogleFonts.mulish(
                                              color: CusColors.footer,
                                              fontSize: width * .025),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: height * .005),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 8),
                                    decoration: BoxDecoration(
                                        color: const Color(0xffFFF9F0),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Text(
                                      consultation.status!,
                                      style: GoogleFonts.mulish(
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xFFFFB033),
                                          fontSize: width * .025),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ]),
                        );
                      },
                    ),
                  )
                ],
              );
            } else {
              return const HomePage();
            }
          }),
        ),
      ),
    );
  }
}
