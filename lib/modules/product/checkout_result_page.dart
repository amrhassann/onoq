import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:onoq/modules/product/product_home_screen.dart';

import 'package:sizer/sizer.dart';

import '../../utils/styles.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text.dart';

enum CheckoutResult { success, failed }

class CheckoutResultPage extends StatelessWidget {
  final CheckoutResult? result;
  const CheckoutResultPage({Key? key, this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: result == CheckoutResult.success
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Lottie.asset(
                    'assets/lottie/lottie-success.json',
                    width: 60.w,
                    height: 60.w,
                  ),
                  NormalText(
                      text: 'Checkout Successful',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: ColorPalettes.bluePrimary),
                  const SizedBox(height: 16),
                  NormalText(
                      text:
                          'Thankyou for your purchase, we will process your order item',
                      fontSize: 12.sp,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                  const SizedBox(height: 16),
                  CustomPrimaryButton(
                      label: 'Back to shopping again',
                      onPressed: () =>
                          Get.offAll(() => const ProductHomeScreen())),
                  SizedBox(height: 2.h),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Lottie.asset(
                    'assets/lottie/lottie-failed.json',
                    width: 60.w,
                    height: 60.w,
                  ),
                  NormalText(
                      text: 'Oppss ! Checkout Failed',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: ColorPalettes.red),
                  const SizedBox(height: 16),
                  NormalText(
                      text:
                          'Your checkout could not be processed. Please try again later',
                      fontSize: 12.sp,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                  const SizedBox(height: 16),
                  CustomPrimaryButton(
                      color: ColorPalettes.red,
                      label: 'Back to Home',
                      onPressed: () => Get.back()),
                ],
              ),
      ),
    );
  }
}
