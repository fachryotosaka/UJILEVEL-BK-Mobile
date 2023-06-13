import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:get/get.dart';
import 'package:ujilevel_bk/components/constant.dart';
import 'package:ujilevel_bk/details.dart';
import 'package:ujilevel_bk/home.dart';
import 'package:ujilevel_bk/profile.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: width * .045, vertical: height * .018),
              alignment: Alignment.centerLeft,
              // width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: width*.005),
                    child: RichText(
                      text: TextSpan(
                          text: 'G',
                          style: GoogleFonts.mPlus1(
                            color: CusColors.mainColor,
                            fontWeight: FontWeight.w700,
                            fontSize: height * .025
                          ),
                            children: <InlineSpan>[
                              TextSpan(
                                text: 'uidance.',
                                style: GoogleFonts.mPlus1(
                                  color: CusColors.header,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18
                                )
                              )
                            ]
                        ),
                    ),
                  ),

                  SizedBox(height: height * .09,),

                  Text(
                    "Welcome Back !",
                    style: GoogleFonts.mPlus1(
                      color: Color(0xFF2C2C2C),
                      fontWeight: FontWeight.w700,
                      fontSize: width*.075
                    ),
                  ),
                  SizedBox(height: 2,),
                  Text(
                    "start managing your finance faster and better.",
                    style: GoogleFonts.mulish(
                      color: CusColors.subHeader.withOpacity(.7),
                      fontSize: width*.03
                    ),
                  ),

                  SizedBox(height: height*.05,),

                  AuthForm(),

                  SizedBox(height: height*.09,),

                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      "©2023 ALL RIGHT RESERVED",
                      style: GoogleFonts.mulish(
                          fontWeight: FontWeight.w500,
                          color: CusColors.subHeader.withOpacity(.5),
                          fontSize: width*.03
                      ),
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

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Form(
        child:Column(
          children: [
            Container(
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(
                  color:CusColors.subHeader
                ),
                decoration: textInputDecoration.copyWith(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                    prefixIcon: Icon(
                      IconlyLight.message,
                      size: 10,
                      color: CusColors.mainColor,
                    ),
                    isDense: true,
                    hintText: "you@example.com",
                    hintStyle: GoogleFonts.mulish(
                        color: CusColors.subHeader.withOpacity(.5),
                        fontSize: width * .032
                    )
                ),
              ),
            ),
            const SizedBox(height: 20,),
            TextFormField(
              keyboardType: TextInputType.visiblePassword,
              style: TextStyle(
                  color:CusColors.subHeader
              ),
              decoration: textInputDecoration.copyWith(
                  prefixIcon: Container(
                    margin: EdgeInsets.only(left: 20, right: 15),
                    child: Icon(
                      IconlyLight.lock,
                      size: width*.05,
                      color: CusColors.mainColor,
                    ),
                  ),
                  suffixIcon: Container(
                    margin: EdgeInsets.only(right: 8),
                    child: Icon(
                      Icons.remove_red_eye_outlined,
                      size: width*.05,
                      color: CusColors.subHeader.withOpacity(0.5),
                    ),
                  ),
                  hintText: "At least 8 character",
                  hintStyle: GoogleFonts.mulish(
                      color: CusColors.subHeader.withOpacity(.5),
                      fontSize: width * .032
                  )
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15, right: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                      'Forgot password ?',
                      style: GoogleFonts.mulish(
                          color: CusColors.mainColor,
                          fontSize: width * .028,
                      )
                  )
                ],
              ),
            ),
            SizedBox(height: height*0.05,),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(-1.2, 0.0),
                    colors: [
                      Color(0xFF19A7CE),
                      CusColors.mainColor,
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
                  onPressed: ()=>Get.to(Home(), transition: Transition.circularReveal),
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)
                          )
                      ),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.all(18)
                      ),
                      backgroundColor: MaterialStateProperty.all(Colors.transparent),
                      shadowColor: MaterialStateProperty.all(Colors.transparent)
                  ),
                  child: Text(
                      'Sign in',
                    style: GoogleFonts.mulish(
                      fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontSize: width * .043
                    )
                  ),
              ),
            ),
            SizedBox(height: 10,),
            Container(
              width: double.infinity,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 5),
              child: RichText(
                textAlign: TextAlign.left,
                  text: TextSpan(
                    text: "This information will be security saved as per the ",
                    style: GoogleFonts.mulish(
                      color: CusColors.subHeader.withOpacity(.5),
                      fontSize: width*.026,
                    ),
                    children: <InlineSpan>[
                      TextSpan(
                        text: "Terms & Privacy Policy",
                        style: GoogleFonts.mulish(
                          color: CusColors.mainColor,
                          fontWeight: FontWeight.w700
                        )
                      )
                    ]
                  ),
              ),
            ),

            SizedBox(height: height*.04,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 2,
                      child: Divider(
                        height: 1,
                        color: CusColors.subHeader.withOpacity(0.4),
                      ),
                  ),
                  Flexible(
                      flex: 1,
                      child: Text(
                        "Or",
                        style: GoogleFonts.mulish(
                          fontWeight: FontWeight.w600,
                          fontSize: 11,
                          color: CusColors.subHeader
                        ),
                      )
                  ),
                  Flexible(
                    flex: 2,
                      child: Divider(
                        height: 1,
                        color: CusColors.subHeader.withOpacity(0.4),
                      ),
                  ),
                ],
              ),
            ),

            SizedBox(height: height*.035,),

            Container(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: ()=>Get.to(Profile(), transition: Transition.cupertino),
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.all(18)
                    ),
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: CusColors.subHeader.withOpacity(.5), width: 1.3)
                      ),
                    ),
                    backgroundColor: MaterialStatePropertyAll(Colors.white),
                    shadowColor: MaterialStatePropertyAll(Colors.transparent)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset("images/google.svg",width: width*.05,),
                      SizedBox(width: 14,),
                      Text(
                        "Sign in with google",
                        style: GoogleFonts.mulish(
                          color: CusColors.subHeader,
                          fontWeight: FontWeight.w500,
                          fontSize: width*.035
                        ),
                      )
                    ],
                  )
              ),
            ),


          ],
        )
    );
  }
}
