import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../utils/styles.dart';

/// Custom Button
/// - There are two types and two styles
/// .
/// For two button in a row use, please wrap this widget with Expanded Widget

enum ButtonType { small, large }
enum ButtonStyleFill { filled, outlined }

class CustomPrimaryButton extends StatelessWidget {
  final ButtonType? type;
  final ButtonStyleFill? style;
  final String? label;
  final Color? color;
  final Function()? onPressed;
  final bool? enable;
  final Icon? icon;
  final bool? rounded;

  const CustomPrimaryButton({
    Key? key,
    this.color = ColorPalettes.bluePrimary,
    this.type = ButtonType.small,
    this.style = ButtonStyleFill.filled,
    this.label,
    this.onPressed,
    this.icon = null,
    this.enable = true,
    this.rounded = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case ButtonType.small:
        if (style == ButtonStyleFill.filled) {
          if (icon != null) {
            return TextButton.icon(
              style: TextButton.styleFrom(
                padding:
                    EdgeInsets.symmetric(horizontal: 6.0.w, vertical: 2.0.h),
                backgroundColor: enable! ? color : Colors.grey,
                shape: rounded == true
                    ? RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      )
                    : const StadiumBorder(),
                primary: Colors.white,
                elevation: 0.0,
              ),
              icon: icon!,
              onPressed: enable! ? onPressed : null,
              label: Text(
                label!,
                textAlign: TextAlign.center,
                style: TextStyles.kRegularBody.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            );
          } else {
            if (icon != null) {
              return TextButton.icon(
                style: TextButton.styleFrom(
                  padding:
                      EdgeInsets.symmetric(horizontal: 6.0.w, vertical: 2.0.h),
                  backgroundColor: enable! ? color : Colors.grey,
                  shape: rounded == true
                      ? RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        )
                      : const StadiumBorder(),
                  primary: Colors.white,
                  elevation: 0.0,
                ),
                onPressed: enable! ? onPressed : null,
                icon: icon!,
                label: Text(
                  label!,
                  textAlign: TextAlign.center,
                  style: TextStyles.kRegularBody.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              );
            } else {
              return TextButton(
                style: TextButton.styleFrom(
                  padding:
                      EdgeInsets.symmetric(horizontal: 6.0.w, vertical: 2.0.h),
                  backgroundColor: enable! ? color : Colors.grey,
                  shape: rounded == true
                      ? RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        )
                      : const StadiumBorder(),
                  primary: Colors.white,
                  elevation: 0.0,
                ),
                onPressed: enable! ? onPressed : null,
                child: Text(
                  label!,
                  textAlign: TextAlign.center,
                  style: TextStyles.kRegularBody.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              );
            }
          }
        }
        return TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 6.0.w, vertical: 2.0.h),
            shape: rounded == true
                ? RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  )
                : const StadiumBorder(),
            side: BorderSide(
              color: color!,
            ),
            primary: ColorPalettes.bluePrimary,
          ),
          child: Text(
            label!,
            textAlign: TextAlign.center,
            style: TextStyles.kRegularBody.copyWith(
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
          onPressed: onPressed,
        );

      case ButtonType.large:
        if (style == ButtonStyleFill.filled) {
          if (icon != null) {
            return SizedBox(
              width: 100.0.w,
              child: TextButton.icon(
                style: TextButton.styleFrom(
                  padding:
                      EdgeInsets.symmetric(horizontal: 6.0.w, vertical: 2.5.h),
                  backgroundColor: enable! ? color : Colors.grey,
                  shape: rounded == true
                      ? RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        )
                      : const StadiumBorder(),
                  primary: Colors.white,
                  elevation: 0.0,
                ),
                icon: icon!,
                onPressed: enable! ? onPressed : null,
                label: Text(
                  label!,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 12.0.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            );
          } else {
            if (icon != null) {
              return SizedBox(
                width: 100.0.w,
                child: TextButton.icon(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                        horizontal: 6.0.w, vertical: 2.5.h),
                    backgroundColor: enable! ? color : Colors.grey,
                    shape: rounded == true
                        ? RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          )
                        : const StadiumBorder(),
                    primary: Colors.white,
                    elevation: 0.0,
                  ),
                  onPressed: enable! ? onPressed : null,
                  icon: icon!,
                  label: Text(
                    label!,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 12.0.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            } else {
              if (icon != null) {
                return SizedBox(
                  width: 100.0.w,
                  child: TextButton.icon(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          horizontal: 6.0.w, vertical: 2.5.h),
                      backgroundColor: enable! ? color : Colors.grey,
                      shape: rounded == true
                          ? RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            )
                          : const StadiumBorder(),
                      primary: Colors.white,
                      elevation: 0.0,
                    ),
                    onPressed: enable! ? onPressed : null,
                    icon: icon!,
                    label: Text(
                      label!,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 12.0.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              } else {
                return SizedBox(
                  width: 100.0.w,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          horizontal: 6.0.w, vertical: 2.5.h),
                      backgroundColor: enable! ? color : Colors.grey,
                      shape: rounded == true
                          ? RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            )
                          : const StadiumBorder(),
                      primary: Colors.white,
                      elevation: 0.0,
                    ),
                    onPressed: enable! ? onPressed : null,
                    child: Text(
                      label!,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 12.0.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              }
            }
          }
        }
        return SizedBox(
          width: 100.0.w,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 6.0.w, vertical: 2.5.h),
              shape: rounded == true
                  ? RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    )
                  : const StadiumBorder(),
              side: const BorderSide(
                color: ColorPalettes.bluePrimary,
              ),
              primary: ColorPalettes.bluePrimary,
            ),
            child: Text(
              label!,
              textAlign: TextAlign.center,
              style: TextStyles.kRegularBody.copyWith(
                fontWeight: FontWeight.w500,
                color: ColorPalettes.bluePrimary,
              ),
            ),
            onPressed: onPressed,
          ),
        );
      default:
        return const SizedBox();
    }
  }
}
