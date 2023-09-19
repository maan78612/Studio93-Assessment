import 'package:assessment_studio_93/constants/app/app_constants.dart';
import 'package:assessment_studio_93/constants/app/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SharedWidget {
  AppBar customAppBar(String title, bool isLeading) {
    return AppBar(
      backgroundColor: AppConfig.colors.offWhite,
      elevation: 0,
      centerTitle: isLeading ? true : false,
      leading: isLeading
          ? IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.arrow_back_ios, color: AppConfig.colors.black))
          : null,
      title: Text(
        title,
        style: latoBold.copyWith(
            color: AppConfig.colors.black,
            fontSize: 20.sp,
            fontWeight: FontWeight.w900),
      ),
      actions: [
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.more_horiz,
              color: AppConfig.colors.black,
            )),
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.favorite,
              color: AppConfig.colors.black,
            ))
      ],
    );
  }
}
