import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:ujilevel_bk/components/constant.dart';

class Details extends StatelessWidget {
  const Details({Key? key}) : super(key: key);

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
            padding: EdgeInsets.symmetric(horizontal: width * .05, vertical: height * .05),
            child: Column(
              children: [
                Flexible(
                  flex: 0,
                    child:Row(
                      children: [
                        Flexible(
                          flex: 1,
                            child:GestureDetector(
                              onTap: ()=>Get.back(),
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  String.fromCharCode(CupertinoIcons.chevron_left.codePoint),
                                  style: TextStyle(
                                    inherit: false,
                                    color: Color(0xFF0F1828),
                                    fontSize: width*.045,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: CupertinoIcons.chevron_left.fontFamily,
                                    package: CupertinoIcons.chevron_left.fontPackage
                                  ),
                                ),
                              ),
                            ),
                        ),
                        Flexible(
                          flex: 20,
                            child: Center(
                              child: Text(
                                "Detail",
                                style: GoogleFonts.mPlus1(
                                  fontWeight: FontWeight.w700,
                                  color: CusColors.header,
                                  fontSize: width*.045
                                ),
                              ),
                            )
                        )
                      ],
                    )
                ),
                SizedBox(height: height*.03,),
                Flexible(
                  flex: 3,
                    child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  "Anxiety",
                                style: GoogleFonts.mPlus1(
                                  fontWeight: FontWeight.w700,
                                  color: CusColors.header.withOpacity(.9),
                                  fontSize: width*.072
                                ),
                              ),
                              SizedBox(height: height*.01,),
                              Padding(
                                padding: EdgeInsets.only(right: width*.16),
                                child: Text(
                                  "Add a field in the portal to let the user connect their Slack account.",
                                  style: GoogleFonts.mulish(
                                    color: CusColors.footer,
                                    fontSize: width*.03
                                  ),
                                ),
                              ),
                              SizedBox(height: height*.05,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: width*.4,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children:[
                                        Text(
                                        "NAME",
                                        style: GoogleFonts.mulish(
                                          color: CusColors.footer.withOpacity(.8),
                                          fontWeight: FontWeight.w700,
                                          fontSize: width*.02
                                        ),
                                      ),
                                        Text(
                                        "Lexa Otosaka",
                                        style: GoogleFonts.mPlus1(
                                          color: CusColors.header,
                                          fontWeight: FontWeight.w700,
                                          fontSize: width*.04
                                        ),
                                      ),
                                      ]
                                    ),
                                  ),
                                  SizedBox(width: width*.15,),
                                  Flexible(
                                    flex: 1,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children:[
                                        Text(
                                        "GENDER",
                                        style: GoogleFonts.mulish(
                                          color: CusColors.footer.withOpacity(.8),
                                          fontWeight: FontWeight.w700,
                                          fontSize: width*.02
                                        ),
                                      ),
                                        Text(
                                        "Male",
                                        style: GoogleFonts.mPlus1(
                                          color: CusColors.header,
                                          fontWeight: FontWeight.w700,
                                          fontSize: width*.04
                                        ),
                                      ),
                                      ]
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: height*.048,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: width*.4,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children:[
                                        Text(
                                        "CLASS",
                                        style: GoogleFonts.mulish(
                                          color: CusColors.footer.withOpacity(.8),
                                          fontWeight: FontWeight.w700,
                                          fontSize: width*.02
                                        ),
                                      ),
                                        Text(
                                        "XI PPLG 2",
                                        style: GoogleFonts.mPlus1(
                                          color: CusColors.header,
                                          fontWeight: FontWeight.w700,
                                            fontSize: width*.04
                                        ),
                                      ),
                                      ]
                                    ),
                                  ),
                                  SizedBox(width: width*.15,),
                                  Flexible(
                                    flex: 1,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children:[
                                        Text(
                                        "Place",
                                        style: GoogleFonts.mulish(
                                          color: CusColors.footer.withOpacity(.8),
                                          fontWeight: FontWeight.w700,
                                          fontSize: width*.02
                                        ),
                                      ),
                                        Text(
                                        "Lab",
                                        style: GoogleFonts.mPlus1(
                                          color: CusColors.header,
                                          fontWeight: FontWeight.w700,
                                          fontSize: width*.04
                                        ),
                                      ),
                                      ]
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: height*.048,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: width*.4,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children:[
                                        Text(
                                        "STATUS",
                                        style: GoogleFonts.mulish(
                                          color: CusColors.footer.withOpacity(.8),
                                          fontWeight: FontWeight.w700,
                                          fontSize: width*.02
                                        ),
                                      ),
                                        Container(
                                          margin: EdgeInsets.only(top: height*.014),
                                          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            color: Color(0xFFFFF9F0),
                                          ),
                                          child: Text(
                                          "Pending",
                                          style: GoogleFonts.mPlus1(
                                            color: Color(0xFFFFB033),
                                            fontWeight: FontWeight.w700,
                                            fontSize: width*.032
                                          ),
                                      ),
                                        ),
                                      ]
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                )
              ],
            ),
          ),

          Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.symmetric(vertical: height * .04),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: width*.32,
                  decoration: BoxDecoration(
                    boxShadow: [BoxShadow(
                      blurRadius: 15,
                      offset: Offset(0, 4),
                      color: Colors.black.withOpacity(.15)
                    )]
                  ),
                  child: ElevatedButton(
                      onPressed: (){},
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(CusColors.mainColor),
                        padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: height*.016)),
                      ),
                      child: Text(
                        "Messages",
                        style: GoogleFonts.mPlus1(
                          color: Color(0xFFEAEBEF),
                          fontWeight: FontWeight.w700,
                          fontSize: width*.032
                        ),
                      )
                  ),
                ),
                Container(
                  width: width*.32,
                  decoration: BoxDecoration(
                      boxShadow: [BoxShadow(
                          blurRadius: 15,
                          offset: Offset(0, 4),
                          color: Colors.black.withOpacity(.15)
                      )]
                  ),
                  child: ElevatedButton(
                      onPressed: (){},
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Color(0xFFFF4377)),
                        padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: height*.016))
                      ),
                      child: Text(
                        "Cancel",
                        style: GoogleFonts.mPlus1(
                          color: Color(0xFFEAEBEF),
                          fontWeight: FontWeight.w700,
                          fontSize: width*.032
                        ),
                      )
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
