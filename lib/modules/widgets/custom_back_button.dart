import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

class CustomBackButton extends StatelessWidget {
  final bool? withSkeleton;
  final dynamic result;
  final void Function()? customOnPressed;
  const CustomBackButton({
    Key? key,
    this.withSkeleton,
    this.result,
    this.customOnPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashRadius: 3.0.h,
      icon: Icon(
        withSkeleton == true
            ? Icons.arrow_back_sharp
            : Icons.keyboard_arrow_left,
        color: Colors.black,
        size: SizerUtil.deviceType == DeviceType.mobile
            ? 22.0.sp
            : SizerUtil.deviceType == DeviceType.tablet
                ? 18.0.sp
                : 32.0.sp,
      ),
      onPressed: customOnPressed ?? () => Navigator.pop(context, result),
      tooltip: 'Back'.tr,
    );
  }
}
