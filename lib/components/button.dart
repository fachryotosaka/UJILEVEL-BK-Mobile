import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

Widget build(BuildContext context, {
  required String? text,
  required Color? bgColor,
}) {
double width = MediaQuery.of(context).size.width;
double height = MediaQuery.of(context).size.height;

  return ElevatedButton(
    onPressed: () => Get.back(),
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
        backgroundColor: MaterialStatePropertyAll(bgColor ?? Colors.black)
    ),
    child: Text(
      text.toString(),
      style: GoogleFonts.mPlus1(
          color: Color(0xFF2c2c2c),
          fontWeight: FontWeight.w700
      ),
    ),
  );
}