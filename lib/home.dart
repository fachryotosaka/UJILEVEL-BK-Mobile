import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:ujilevel_bk/components/constant.dart';
import 'package:ujilevel_bk/details.dart';
import 'package:ujilevel_bk/profile.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: width * .05, vertical: height * .055),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hi, Lexa !",
                      style: GoogleFonts.mPlus1(
                        color: CusColors.header,
                        fontWeight: FontWeight.w700,
                        fontSize: width*.055,
                      ),
                    ),
                    Text(
                      "XI PPLG 2",
                      style: GoogleFonts.mPlus1(
                        color: CusColors.subHeader.withOpacity(.5),
                        fontWeight: FontWeight.w700,
                        fontSize: width*.03
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: ()=>Get.to(Profile(), transition: Transition.fade),
                  child: CircleAvatar(
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
            SizedBox(height: height*.03 ,),
            TextFormField(
              style: GoogleFonts.mPlus1(
                color: CusColors.subHeader,
                fontWeight: FontWeight.w400,
                fontSize: width*.028,
                letterSpacing: .5,
              ),
              decoration: InputDecoration(
                prefixIcon: Container(margin:EdgeInsets.only(right: 20, left: 15),child: Icon(IconlyLight.search, color: CusColors.subHeader.withOpacity(.5),)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: CusColors.subHeader.withOpacity(0))
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: CusColors.subHeader.withOpacity(.3))
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                hintText: "Type anywhere to search...",
                hintStyle: GoogleFonts.mulish(
                  color: CusColors.subHeader.withOpacity(.5),
                  fontWeight: FontWeight.w400,
                  fontSize: width*.028,
                  letterSpacing: .5
                ),
                suffixIcon: Container(margin:EdgeInsets.only(right: 10) ,child: Icon(IconlyLight.filter,color: CusColors.subHeader.withOpacity(.5),))
              ),
            ),

            SizedBox(height: height*.045,),

            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(bottom: height*.025),
              child: Text(
                "Schedule",
                style: GoogleFonts.mPlus1(
                  color: CusColors.header.withOpacity(.98),
                  fontWeight: FontWeight.w700,
                  fontSize: width*.04
                ),
              ),
            ),
            
            Container(
              width: double.infinity,
              alignment: Alignment.centerLeft,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: ()=>Get.to(Details(), transition: Transition.leftToRightWithFade),
                    child: Stack(
                      children: [
                        Container(
                          height: height*.12,
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(left: 3, top: 3),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Color(0xffE2E8F0))
                          ),
                        ),
                        Container(
                          height: height*.12,
                          padding: EdgeInsets.symmetric(vertical: 14, horizontal: 25),
                          margin: EdgeInsets.only(right: 3),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Color(0xffE2E8F0))
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: width*.5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Anxiety",
                                      style: GoogleFonts.mulish(
                                          color: Color(0xff1E293B),
                                          fontWeight: FontWeight.w700,
                                          fontSize: width*.05
                                      ),
                                    ),
                                    SizedBox(height: height*.01,),
                                    Text(
                                      "Add a field in the portal to let the user connect their Slack account.",
                                      style: GoogleFonts.mulish(
                                        color: CusColors.footer,
                                        fontSize: width*.025
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: height*.005),
                                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 8),
                                decoration: BoxDecoration(
                                  color: Color(0xffFFF9F0),
                                  borderRadius: BorderRadius.circular(8)
                                ),
                                child: Text(
                                  "Pending",
                                  style: GoogleFonts.mulish(
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFFFFB033),
                                    fontSize: width*.025
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ]
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
