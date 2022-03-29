import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onoq/modules/product/product_home_screen.dart';
import 'package:onoq/modules/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      Get.offAll(() => const ProductHomeScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: 100.h,
          width: 100.w,
          child: Column(
            children: [
              Expanded(
                flex: 10,
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 8.h,
                  key: const Key('splashIconText'),
                ),
              ),
              Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      NormalText(
                        text: 'Find your dream shopping here',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                      SizedBox(height: 2.h),
                      const CircularProgressIndicator(
                        key: Key('loadingIndicator'),
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
