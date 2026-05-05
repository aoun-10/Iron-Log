import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Widgets/custom_button.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
      toolbarHeight: 100.h,
      leadingWidth: 70.w,
      backgroundColor: Colors.black,
      elevation: 0,

      leading: Padding(
        padding: EdgeInsets.only(left: 15.w, top: 20.h),
        child: CustomButton(
          onTap: (){
            Get.back();
          },
        ),
      ),
      flexibleSpace: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 50.h,left: 90.w),
          child: Text(
            "Privacy Policy",
            style: GoogleFonts.quattrocento(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        child: ListView(
          children: [

            // TITLE
            Text(
              "Privacy Policy – Iron Log",
              style: GoogleFonts.quattrocento(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            SizedBox(height: 20.h),
            RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 15.sp,
                  color: Colors.white70,
                  height: 1.6,
                ),
                children: [
                  TextSpan(
                    text:
                    "Iron Log respects your privacy and is committed to protecting your personal information. ",
                  ),
                  TextSpan(
                    text:
                    "This Privacy Policy explains how your data is handled when you use the application.",
                  ),
                ],
              ),
            ),

            SizedBox(height: 20.h),
            RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 15.sp,
                  color: Colors.white70,
                  height: 1.6,
                ),
                children: [
                  TextSpan(
                    text:
                    "Iron Log is a workout tracking application that allows users to log exercises, create routines, track progress, view workout history, and use basic gym tools such as a timer and calculator.",
                  ),
                ],
              ),
            ),

            SizedBox(height: 20.h),
            RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 15.sp,
                  color: Colors.white70,
                  height: 1.6,
                ),
                children: [
                  TextSpan(
                    text: "Iron Log collects only the information that you enter the app, including:\n",
                  ),
                ],
              ),
            ),

            bulletText("Workout data (exercises, sets, reps, weight)"),
            bulletText("Workout routines"),
            bulletText("Progress and history data"),

            SizedBox(height: 20.h),
            Text(
              "The data you enter is used only to:",
              style: TextStyle(
                fontSize: 15.sp,
                color: Colors.white70,
              ),
            ),
            SizedBox(height: 10.h),
            bulletText("Save your workouts"),
            bulletText("Display your routines"),
            bulletText("Show your progress over time"),
            bulletText("Provide access to your workout history"),
            SizedBox(height: 20.h),
            Text(
              "Your data is used solely to improve your experience in the app.",
              style: TextStyle(
                fontSize: 15.sp,
                color: Colors.white70,
                height: 1.6,
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              "Your data is stored securely and is used only for app functionality. The app does not use your data for advertising or marketing purposes.",
              style: TextStyle(
                fontSize: 15.sp,
                color: Colors.white70,
                height: 1.6,
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              "Iron Log does not sell, share, or distribute your personal data to third parties.",
              style: TextStyle(
                fontSize: 15.sp,
                color: Colors.white70,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
Widget bulletText(String text) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "• ",
        style: TextStyle(
          fontSize: 18.sp,
          color: Colors.white70,
        ),
      ),
      Expanded(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 15.sp,
            color: Colors.white70,
            height: 1.6,
          ),
        ),
      ),
    ],
  );
}