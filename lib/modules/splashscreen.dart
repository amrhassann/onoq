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

    Future.delayed(const Duration(seconds: 1), () {
      Get.offAll(() => const ProductHomeScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child: Image.asset(
          'assets/images/logo.png',
          height: 8.h,
          key: const Key('splashIconText'),
        ),
      )
    );
  }
}
