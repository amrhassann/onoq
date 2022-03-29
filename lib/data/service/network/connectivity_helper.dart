import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityHelper {
  final Connectivity _connectivity = Connectivity();

  void init(BuildContext context) {
    checkStatus().then((value) {
      if (value) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              !value ? 'Not Connected,You are in offline mode' : 'Connected',
              textAlign: TextAlign.center,
            ),
            backgroundColor: !value ? Colors.redAccent : Colors.green,
            duration: Duration(seconds: !value ? 5000 : 3),
          ),
        );
      }
    });
    _connectivity.onConnectivityChanged.listen((result) async {
      bool isNotConnected;

      if (result == ConnectivityResult.none) {
        isNotConnected = true;
      } else {
        isNotConnected = !await checkStatus();
      }

      if (!isNotConnected) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isNotConnected
                ? 'Not Connected,You are in offline mode'
                : 'Connected',
            textAlign: TextAlign.center,
          ),
          backgroundColor: isNotConnected ? Colors.redAccent : Colors.green,
          duration: Duration(seconds: isNotConnected ? 5000 : 3),
        ),
      );

      if (!isNotConnected) {
        // Get.offAll(
        //   () => HomePage(
        //     fromPage: pageController.page.value,
        //   ),
        //   transition: Transition.noTransition,
        // );
      }
    });
  }

  static Future<bool> checkStatus() async {
    bool isConnected = false;
    try {
      final result = await InternetAddress.lookup('elevenia.co.id');
      isConnected = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      isConnected = false;
    }
    return isConnected;
  }
}
