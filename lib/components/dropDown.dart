import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ujilevel_bk/components/constant.dart';

Widget CusDropDown(BuildContext context, {
  required String? label,
  required selectedType,
  required onChanged,
  required hint,
  required List<String> item
}) {
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;

  return Container(
    margin: EdgeInsets.only(
        bottom: height * .026),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toString(),
          style: GoogleFonts.mPlus1(
            fontWeight: FontWeight.w600,
            color: CusColors.header,
            fontSize: width * .03,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              isExpanded: true,
              value: selectedType,
              buttonStyleData: ButtonStyleData(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: CusColors.subHeader.withOpacity(.3)
                      )
                  )
              ),
              onChanged: onChanged,
              hint: Text(
                hint.toString(),
                style: GoogleFonts.mulish(
                  fontWeight: FontWeight.w700,
                  fontSize: width * .032,
                ),
              ),
              items: item.map((String item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: GoogleFonts.mulish(
                    fontWeight: FontWeight.w700,
                    fontSize: width * .032,
                  ),
                ),
              )).toList(),
            )
        ),
      ],
    ),
  );
}