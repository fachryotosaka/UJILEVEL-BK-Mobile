import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ujilevel_bk/components/constant.dart';

Widget CusTextField(BuildContext context, {
  required String? label,
  labelColor,
  String? hint,
  TextInputType? type,
  bool? enabled,
  double? radius,
  IconData? suffIcon,
  String? value,
  controller,
  onTap,
  onChanged,
  validation,
  bool? forPassword,
  bool? optional,
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
          '${label.toString()}${optional != null ? ' *' : ''}',
          style: GoogleFonts.mPlus1(
            fontWeight: FontWeight.w600,
            color: labelColor ?? CusColors.subHeader.withOpacity(.3),
            fontSize: width * .03,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        TextFormField(
          controller: controller,
          keyboardType: type,
          onTap: onTap,
          onChanged: onChanged,
          initialValue: value,
          obscureText: forPassword ?? false,
          validator: validation,
          style: GoogleFonts.mulish(
            fontSize: width * .032,
            fontWeight: FontWeight.w700,
          ),
          decoration:
            InputDecoration(
              enabled: enabled ?? true,
              hintText: hint ?? value,
              hintStyle:
                GoogleFonts.mulish(
                  color: CusColors.header.withOpacity(value != null ? 1 : .6),
                  fontSize: width * .032,
                  fontWeight: FontWeight.w600,
                ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              enabledBorder:
                OutlineInputBorder(
                    borderRadius: BorderRadius.circular(radius ?? 0),
                    borderSide: BorderSide(
                        color: CusColors.subHeader.withOpacity(.2),
                        width: 1.5
                    )
                ),
              disabledBorder:
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(radius ?? 0),
                  borderSide: BorderSide(
                      color: CusColors.subHeader.withOpacity(.2),
                        width: 1.5
                  ),
                ),
              focusedBorder:
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(radius ?? 0),
                  borderSide: BorderSide(
                      color: CusColors.subHeader.withOpacity(.5),
                      width: 1.5
                  ),
                ),
              suffixIcon: Icon(suffIcon, color: CusColors.subHeader, size: width * .055,),
            ),
        )
      ],
    ),
  );
}