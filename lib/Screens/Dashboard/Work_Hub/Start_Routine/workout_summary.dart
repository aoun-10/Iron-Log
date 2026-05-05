import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iron_log/Screens/Dashboard/Work_Hub/Start_Routine/history.dart';
import 'package:iron_log/Screens/Dashboard/home_state.dart';
import 'package:iron_log/Widgets/button.dart';

import '../../../../Widgets/custom_button.dart';
import '../../../../Widgets/custom_paint.dart';
import '../../../../core/theme/app_color.dart';

class WorkoutSummary extends StatelessWidget {
  const WorkoutSummary({super.key});

  static const Color customRed = AppColors.primaryRed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leadingWidth: 70.w,
        toolbarHeight: 80.h,
        leading: Padding(
          padding: EdgeInsets.only(left: 20.w, top: 10.h),
          child: CustomButton(
            onTap: (){
              Get.back();
            },),
        ),
        title: Padding(
          padding: EdgeInsets.only(top: 15.h),
          child: Text(
            "Your Workout Summary",
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),
                Text(
                  "WORKOUT SUMMARY",
                  style: GoogleFonts.quattrocento(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20.h),

                // Main Legacy Gains Card
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 40.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white12,
                        Colors.black26,
                        Colors.white12,
                      ],
                    ),
                    border: Border.all(color: Colors.white10),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Workout Complete",
                        style: GoogleFonts.inter(
                          color: customRed,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        "LEGACY GAINS",
                        style: GoogleFonts.quattrocento(
                          color: Colors.white,
                          fontSize: 23.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        "Chest Workout . Morning Session",
                        style: GoogleFonts.inter(
                          color: Colors.white54,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),

                // Total Volume Card
                _buildSummaryCard(
                  title: "TOTAL VOLUME",
                  value: "12,450",
                  unit: " KG",
                  isFullWidth: true,
                ),
                SizedBox(height: 10.h),

                // Duration and Exercises Row
                Row(
                  children: [
                    Expanded(
                      child: _buildSummaryCard(
                        title: "DURATION",
                        value: "74",
                        unit: " MIN",
                      ),
                    ),
                    SizedBox(width: 20.w),
                    Expanded(
                      child: _buildSummaryCard(
                        title: "EXERCISES",
                        value: "8",
                        unit: "",
                        icon: Icons.fitness_center,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 15.h),
                GestureDetector(
                  onTap: (){
                    Get.to(History());
                  },
                  child: Text(
                    "View Exercise History",
                    style: GoogleFonts.inter(
                      color: customRed,
                      fontSize: 13.sp,
                      decoration: TextDecoration.underline,
                      decorationColor: customRed,
                    ),
                  ),
                ),
                SizedBox(height: 15.h),
                Button(
                    label: "Save & Exit",
                    onTap: (){
                      Get.to(HomeState(initialIndex: 1,));
                    }
                ),
                //SizedBox(height: 100.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Reusable Helper for Cards
  Widget _buildSummaryCard({
    required String title,
    required String value,
    required String unit,
    bool isFullWidth = false,
    IconData? icon,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(30.w),
      decoration: BoxDecoration(
        color: AppColors.darkBackground,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Column(
        // Agar isFullWidth true hai (Total Volume), to alignment start hogi, warna center.
        crossAxisAlignment: isFullWidth
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              color: Colors.white38,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (isFullWidth) SizedBox(height: 2.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            mainAxisAlignment: isFullWidth
                ? MainAxisAlignment.start
                : MainAxisAlignment.center,
            children: [
              Text(
                value,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                unit,
                style: GoogleFonts.inter(
                  color: customRed,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (icon != null) ...[
                SizedBox(width: 3.w),
                Icon(icon, color: customRed, size: 20.sp),
              ]
            ],
          ),
        ],
      ),
    );
  }
}