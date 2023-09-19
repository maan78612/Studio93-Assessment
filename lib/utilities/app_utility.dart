import 'dart:io';

import 'package:assessment_studio_93/constants/app/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';


class AppUtility {
  static void hideKeyboard() {
    FocusScope.of(Get.context!).requestFocus(FocusNode());
  }

  static String getFreshDateTimeID() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  // will pop function
  DateTime? currentBackPressTime;

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      toast(msg: "press again to exit",bgColor: AppConfig.colors.black);
      return Future.value(false);
    }
    return Future.value(true);
  }

  static void toast({required String msg, required Color bgColor}) {
    Fluttertoast.showToast(
        msg: msg,
        fontSize: 16.sp,
        timeInSecForIosWeb: 2,
        backgroundColor: bgColor,

        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER);
  }

  static void snackBar(
    String title,
    String message,
    bool progress,
  ) {
    Get.snackbar(title, message,
        backgroundColor: AppConfig.colors.offWhite,
        colorText: Colors.white,
        showProgressIndicator: progress,
        progressIndicatorBackgroundColor: Colors.lightBlueAccent,
        progressIndicatorValueColor:
            const AlwaysStoppedAnimation<Color>(Colors.tealAccent),
        snackPosition: kIsWeb ? SnackPosition.TOP : SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
        maxWidth: 600.sp,
        borderRadius: 10.sp);
  }

  static Future<bool> showConfirmationDialog(
      BuildContext context, String title) async {
    return await showDialog(
      context: context,
      builder: (context) {
        if (Platform.isIOS) {

          return CupertinoAlertDialog(
            title: Text(title),
            actions: <Widget>[
              CupertinoDialogAction(
                child: const Text("No"),
                onPressed: () => Navigator.of(context).pop(false),
              ),
              CupertinoDialogAction(
                isDefaultAction: true,
                child: const Text("Yes"),
                onPressed: () => Navigator.of(context).pop(true),
              )
            ],
          );
        } else {
          print("android");
          return Container(
            constraints: const BoxConstraints(maxHeight: 300.0),
            child: AlertDialog(
              title: Text(title),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () => Navigator.of(context).pop(false),
                ),
                TextButton(
                  child: const Text('Yes'),
                  onPressed: () => Navigator.of(context).pop(true),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
