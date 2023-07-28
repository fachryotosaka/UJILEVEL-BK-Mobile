import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';

class CusColors{
  static Color mainColor = Color(0xFF4351FF);
  static Color header = Color(0xFF37373E);
  static Color subHeader = Color(0xFF676767);
  static Color footer = Color(0xFF94A3B8);
}

InputDecoration textInputDecoration = InputDecoration(
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: BorderSide(color: CusColors.subHeader.withOpacity(.2)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.circular(18),
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 18),
    isDense: true,
    filled: true,
    fillColor: Color(0xFFF6F7F9),
);