import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import 'constans.dart';

class ColorPalettes {
  MaterialColor colorPrimarySwatch = const MaterialColor(
    0xFF1387C9,
    <int, Color>{
      50: Color(0xFF1387C9),
      100: Color(0xFF1387C9),
      200: Color(0xFF1387C9),
      300: Color(0xFF1387C9),
      400: Color(0xFF1387C9),
      500: Color(0xFF1387C9),
      600: Color(0xFF1387C9),
      700: Color(0xFF1387C9),
      800: Color(0xFF1387C9),
      900: Color(0xFF1387C9),
    },
  );
  static const greyLight = Color(0xFF999999);
  static const greyMedium = Color(0xFF8a7c70);
  static const greyDark = Color(0xFF666666);

  static const blackDark = Color(0xFF333333);
  static const blackLight = Color(0xFF4F4F4F);

  static const white = Color(0xFFFFFFFF);
  static const whiteDark = Color(0xFFCCCCCC);
  static const whiteDarkA = Color(0xFFDCDCDC);
  static const whiteDarkB = Color(0xFFCCCCCC);

  static const blue = Color(0xFFf0666b);
  static const bluePrimary = Color(0xFFf0666b);
  static const blueWhite = Color(0xFFf0666b);
  static const blueLight = Color.fromARGB(255, 21, 29, 37);

  static const yellowA = Color(0xFFF1AA59);
  static const yellowB = Color(0xFFFF7900);
  static const yellowC = Color(0xFFFF9663);
  static const red = Color(0xFFDD5253);

  static const purple = Color(0xFFD35E9F);
  static const green = Color(0xFF199C6D);

  static const orange = Color(0xFFFF9D1D);
  static const lightOrange = Color(0xFFF8AB98);

  static const purpleA = Color(0xFF23cc31);
  static const lightGreen = Color(0xFFABDA7B);

  static const mixA = Color(0xFFFD5B2A);
  static const mixB = Color(0xFFFA9832);
  static const mixC = Color(0xFFF9BF37);
  static const mixD = Color(0xFFF89721);
}

class TextStyles {
  static var kBoldTitle = GoogleFonts.poppins(
    fontSize: 14.0.sp,
    fontWeight: FontWeight.w600,
  );

  static var kMediumBody = GoogleFonts.poppins(
    fontSize: 16.0.sp,
    fontWeight: FontWeight.w600,
  );

  static var kRegularBody = GoogleFonts.poppins(
    fontSize: 12.0.sp,
    fontWeight: FontWeight.w400,
  );

  static var kSmallBody = GoogleFonts.poppins(
    fontSize: 10.0.sp,
    fontWeight: FontWeight.w400,
  );
}

class FormStyle {
  static var inputStyle = GoogleFonts.poppins(
    fontSize: Dimens.normalFontSize,
    fontWeight: FontWeight.w400,
    color: const Color(0xFF999999),
  );
  static TextStyle normalTextStyle = TextStyle(fontSize: Dimens.normalFontSize);
  static TextStyle errorTextStyle = TextStyle(fontSize: Dimens.smallFontSize);

  static var inputDecorationStyle = InputDecoration(
    contentPadding: EdgeInsets.all(4.0.w),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: ColorPalettes.whiteDark,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: ColorPalettes.yellowB,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
    ),
    errorBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xFFF0636A),
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
    ),
    focusedErrorBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: ColorPalettes.yellowB,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
    ),
  );
}
