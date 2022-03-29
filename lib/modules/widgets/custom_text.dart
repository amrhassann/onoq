import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:styled_text/styled_text.dart';

import '../../utils/styles.dart';

final styles = {
  'b': StyledTextTag(
    style: const TextStyle(fontWeight: FontWeight.bold),
  ),
  'boldYellow': StyledTextTag(
    style: const TextStyle(
        fontWeight: FontWeight.bold, color: ColorPalettes.yellowA),
  ),
  'regularYellowB': StyledTextTag(
    style: const TextStyle(
        fontWeight: FontWeight.w500, color: ColorPalettes.yellowB),
  ),
  'w600YellowA': StyledTextTag(
    style: const TextStyle(
        fontWeight: FontWeight.w600, color: ColorPalettes.yellowA),
  ),
};

class NormalText extends StatelessWidget {
  final String? text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final int? maxLines;
  final TextAlign? textAlign;
  final bool isUnderline;
 final TextDirection textDirection;
  const NormalText({
    Key? key,
    required this.text,
    required this.fontSize,
    required this.fontWeight,
    required this.color,
    this.maxLines,
    this.textAlign,
    this.isUnderline = false,
    this.textDirection=TextDirection.ltr,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      maxLines: maxLines,
      textAlign: textAlign,
      textDirection: textDirection,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        overflow: TextOverflow.ellipsis,
        fontFamily: 'Poppins',
        decoration: isUnderline ? TextDecoration.underline : null,
      ),
      // style: GoogleFonts.poppins(
      //   fontSize: fontSize,
      //   fontWeight: fontWeight,
      //   color: color,
      // ),
    );
  }
}

class CustomText extends StatelessWidget {
  final String? text;
  final double? fontSize;
  final FontWeight fontWeight;
  final Color color;
  final int? maxLines;
  final TextAlign? textAlign;

  const CustomText({
    Key? key,
    required this.text,
    required this.fontSize,
    required this.fontWeight,
    required this.color,
    this.maxLines,
    this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StyledText(
      text: text!,
      maxLines: maxLines,
      textAlign: textAlign != null ? textAlign! : TextAlign.left,
      style: GoogleFonts.poppins(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
      tags: styles,
    );
  }
}

class CustomTextInsight extends StatelessWidget {
  final String? text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;

  const CustomTextInsight({
    Key? key,
    required this.text,
    required this.fontSize,
    required this.fontWeight,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StyledText(
      text: text!,
      textAlign: TextAlign.justify,
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
      style: GoogleFonts.poppins(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
      tags: styles,
    );
  }
}
