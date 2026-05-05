import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Widgets/custom_button.dart';

class TermsConditional extends StatelessWidget {
  const TermsConditional({super.key});

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
              "Terms & Conditions",
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

            // HEADING
            Text(
              "Welcome to Iron Log.",
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
                    "By using this application, you agree to the following terms and conditions. ",
                  ),
                  TextSpan(
                    text:
                    "Please read them carefully.",
                  ),
                ],
              ),
            ),

            SizedBox(height: 20.h),

            Text(
              "Iron Log is a fitness workout tracking application designed to help users log exercises, create workout routines, track progress, and view workout history. The app also provides basic tools such as timers and simple calculators to support gym activities.",
              style: TextStyle(
                fontSize: 15.sp,
                color: Colors.white70,
                height: 1.6,
              ),
            ),

            SizedBox(height: 20.h),

            Text(
              "Users are responsible for entering accurate workout information including exercises, sets, reps, and weight. Iron Log does not verify or validate user-entered data.",
              style: TextStyle(
                fontSize: 15.sp,
                color: Colors.white70,
                height: 1.6,
              ),
            ),

            SizedBox(height: 20.h),
            Text(
              "Iron Log is not a medical or professional fitness service. The app does not provide medical advice, diagnosis, or treatment. Users should consult a qualified professional before starting any exercise program.",
              style: TextStyle(
                fontSize: 15.sp,
                color: Colors.white70,
                height: 1.6,
              ),
            ),

            SizedBox(height: 20.h),
            Text(
              "All data entered into the app, including workout logs, routines, and progress, is for personal tracking purposes only. Users are responsible for maintaining their own records.",
              style: TextStyle(
                fontSize: 15.sp,
                color: Colors.white70,
                height: 1.6,
              ),
            ),
            SizedBox(height: 10.h),

            Text(
              "No Advanced Features in Current Version The current version of Iron Log focuses only on basic workout tracking features. Advanced features such as detailed analytics and recovery tracking may be included in future updates.",
              style: TextStyle(
                fontSize: 15.sp,
                color: Colors.white70,
                height: 1.6,
              ),
            ),

            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}