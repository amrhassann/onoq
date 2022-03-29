import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:onoq/utils/styles.dart';

import 'package:sizer/sizer.dart';

import 'data/model/cart_model.dart';
import 'data/model/delivery_model.dart';
import 'data/model/product_detail_model.dart';
import 'data/model/product_model.dart';
import 'data/model/product_option_model.dart';
import 'modules/splashscreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(ProductAdapter());
  Hive.registerAdapter(DetailProductAdapter());
  Hive.registerAdapter(DeliveryAdapter());
  Hive.registerAdapter(ProductOptionDetailsAdapter());
  Hive.registerAdapter(CartModelAdapter());
  runApp(const OnoqStore());
}

class OnoqStore extends StatelessWidget {
  const OnoqStore({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    // Set Device Orientation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // Set statusbar to light
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    EasyLoading.instance
      ..maskType = EasyLoadingMaskType.black
      ..loadingStyle = EasyLoadingStyle.custom
      ..backgroundColor = Colors.white
      ..textColor = Colors.black
      ..indicatorColor = Colors.black;

    return LayoutBuilder(
      builder: (_, constraints) => OrientationBuilder(
        builder: (ctx, orientation) {
          return Sizer(
            builder: (_, __, ___) {
              return GetMaterialApp(
                title: 'Store',
                builder: EasyLoading.init(),
                theme: ThemeData(
                  appBarTheme: const AppBarTheme(
                    backgroundColor: Colors.white,
                    iconTheme: IconThemeData(color: Colors.black),
                  ),
                  primarySwatch: ColorPalettes().colorPrimarySwatch,
                  textTheme: GoogleFonts.latoTextTheme(textTheme).copyWith(
                    bodyText1: GoogleFonts.montserrat(
                      textStyle: textTheme.bodyText1,
                    ),
                  ),
                  fontFamily: 'Poppins',
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                ),
                debugShowCheckedModeBanner: false,
                routes: {
                  '/': (ctx) => const SplashScreen(),
                },
                onUnknownRoute: (settings) {
                  return MaterialPageRoute(
                    builder: (ctx) => const SplashScreen(),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
