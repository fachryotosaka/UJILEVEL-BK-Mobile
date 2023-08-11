import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ujilevel_bk/components/constant.dart';

class PageHeader extends StatelessWidget {
  const PageHeader({
    Key? key,
    this.title,
  }) : super(key: key);

  final String? title;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Flexible(
          flex: 1,
          child: GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Text(
                String.fromCharCode(
                    CupertinoIcons.chevron_left.codePoint),
                style: TextStyle(
                    inherit: false,
                    color: const Color(0xFF0F1828),
                    fontSize: width * .045,
                    fontWeight: FontWeight.w700,
                    fontFamily:
                    CupertinoIcons.chevron_left.fontFamily,
                    package: CupertinoIcons
                        .chevron_left.fontPackage),
              ),
            ),
          ) 
        ),
        Flexible(
            flex: 20,
            child: Center(
              child: Text(
                title.toString(),
                style: GoogleFonts.mPlus1(
                    fontWeight: FontWeight.w700,
                    color: CusColors.header,
                    fontSize: width * .045),
              ),
            )
        )
      ],
    );
  }
}