import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ujilevel_bk/auth/signIn.dart';
import 'package:ujilevel_bk/components/constant.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: width * .05, vertical: height * .05),
        child: Column(
          children: [
            Flexible(
              flex: 0,
                child: Row(
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
                            "Profile",
                            style: GoogleFonts.mPlus1(
                                fontWeight: FontWeight.w700,
                                color: CusColors.header,
                                fontSize: width*.045
                            ),
                          ),
                        )
                    )
                  ],
                ),
            ),
            SizedBox(height: height*.01,),
            Flexible(
              flex: 3,
                child: ListView(
                  children: [
                    Column(
                      children: [
                        CircleAvatar(
                          maxRadius: 58,
                          backgroundColor: Color(0xFF979797),
                          child: CircleAvatar(
                            maxRadius: 55,
                            backgroundImage: AssetImage("images/rendang.jpg"),
                          ),
                        ),
                        SizedBox(height: height*.022,),
                        Text(
                          "Lexa Otosaka",
                          style: GoogleFonts.dmSans(
                            color: Color(0xFF181D27),
                            fontWeight: FontWeight.w700,
                            fontSize: width*.05
                          ),
                        ),
                        Text(
                          "Fachrylord0@gmail.com",
                          style: GoogleFonts.dmSans(
                            color: Color(0xFFababab),
                            fontSize: width*.03
                          ),
                        ),

                        SizedBox(height: height*.055,),

                        UserProfile(),
                      ],
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

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Form(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: height*.026),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Name",
                    style: GoogleFonts.mPlus1(
                      fontWeight: FontWeight.w500,
                      color: CusColors.subHeader.withOpacity(.25),
                      fontSize: width*.028
                    ),
                  ),
                  SizedBox(height: 6,),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Lexa Otosaka",
                      hintStyle: GoogleFonts.mulish(
                        color: CusColors.header.withOpacity(.6),
                        fontSize: width*.034,
                        fontWeight: FontWeight.w500,
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: CusColors.subHeader.withOpacity(.2), width: 1.5)
                      ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: CusColors.subHeader.withOpacity(.5), width: 1.5),
                        )
                    ),
                  )
                ],
              ),
            ),Container(
              margin: EdgeInsets.only(bottom: height*.026),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Class",
                    style: GoogleFonts.mPlus1(
                      fontWeight: FontWeight.w600,
                      color: CusColors.subHeader.withOpacity(.3),
                      fontSize: width*.03,
                    ),
                  ),
                  SizedBox(height: 8,),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "XI PPLG 2",
                      hintStyle: GoogleFonts.mulish(
                        color: CusColors.header.withOpacity(.6),
                        fontSize: width*.034,
                        fontWeight: FontWeight.w500,
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: CusColors.subHeader.withOpacity(.2), width: 1.5)
                      ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: CusColors.subHeader.withOpacity(.5), width: 1.5),
                        )
                    ),
                  )
                ],
              ),
            ),Container(
              margin: EdgeInsets.only(bottom: height*.026),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Gender",
                    style: GoogleFonts.mPlus1(
                      fontWeight: FontWeight.w600,
                      color: CusColors.subHeader.withOpacity(.3),
                      fontSize: width*.03,
                    ),
                  ),
                  SizedBox(height: 8,),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Male",
                      hintStyle: GoogleFonts.mulish(
                        color: CusColors.header.withOpacity(.6),
                        fontSize: width*.034,
                        fontWeight: FontWeight.w500,
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: CusColors.subHeader.withOpacity(.2), width: 1.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: CusColors.subHeader.withOpacity(.5), width: 1.5),
                      )
                    ),
                  ),

                  SizedBox(height: height*.05,),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment(-1.9, 0.0),
                            colors: [
                              CusColors.mainColor,
                              Color(0xFF19A7CE),
                            ]
                        ),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [BoxShadow(
                            color: Colors.black.withOpacity(.25),
                            spreadRadius: 0,
                            blurRadius: 20,
                            offset: Offset(0, 4)
                        )]
                    ),
                    child: ElevatedButton(
                      onPressed: ()=>Get.to(SignIn(), transition: Transition.circularReveal),
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)
                              )
                          ),
                          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                              const EdgeInsets.all(20 )
                          ),
                          backgroundColor: MaterialStateProperty.all(Colors.transparent),
                          shadowColor: MaterialStateProperty.all(Colors.transparent)
                      ),
                      child: Text(
                          'Logout',
                          style: GoogleFonts.mulish(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontSize: width * .033,
                              letterSpacing: .5
                          )
                      ),
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
