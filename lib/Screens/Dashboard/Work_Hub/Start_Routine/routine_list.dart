import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:iron_log/Screens/Dashboard/Work_Hub/Start_Routine/create_routine.dart';

import '../../../../Widgets/custom_button.dart';
import '../../../../Widgets/custom_paint.dart';
import '../../../../core/theme/app_color.dart'; // Dotted border ke liye package

class RoutineList extends StatelessWidget {
  const RoutineList({super.key});

  // Custom Red Color
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
            "Training Library",
            style: GoogleFonts.inter(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(20.w,0.h, 20.w, 0.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 7.h),
              Text(
                "SAVED ROUTINES",
                style: GoogleFonts.quattrocento(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 15.h),

              // Routine Cards
              _buildRoutineCard("Pull Day: Strength", "06", "24 March 2026"),
              _buildRoutineCard("Leg Day: Atomic", "10", "21 March 2026"),
              _buildRoutineCard("Dead Lift", "06", "24 March 2026"),

              SizedBox(height: 10.h),

              // Dotted Create Routine Card (Workable & Responsive)
              GestureDetector(
                onTap: () {
                  Get.to(CreateRoutine());
                },
                child: DottedBorder(
                  color: customRed.withValues(alpha: 0.6),
                  strokeWidth: 1.5.w,
                  dashPattern: const [6, 4],
                  borderType: BorderType.RRect,
                  //radius: Radius.circular(15.r),
                  child: Container(
                    width: double.infinity,
                    height: 160.h,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.02),
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomButton(
                          onTap: (){
                            Get.to(CreateRoutine());
                          },
                          icon: Icons.add_circle_outline_outlined,
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          "CREATE YOUR ROUTINE",
                          style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }

  // Routine Card Widget
  Widget _buildRoutineCard(String title, String count, String date) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(22.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.r),
        border: Border.all(color: Color(0xFF181818),width: 1.5),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF535050).withValues(alpha: 0.5),
            Color(0xFF201F1F).withValues(alpha: 0.5),
            Color(0xFF868282).withValues(alpha: 0.3),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.quattrocento(
              fontSize: 23.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 7.h),
          Row(
            children: [
              _buildInfoColumn("Excerices", count),
              SizedBox(width: 40.w),
              _buildInfoColumn("Last Done", date),
            ],
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              _buildSmallButton(Icons.edit, "EDIT"),
              SizedBox(width: 12.w),
              _buildSmallButton(Icons.logout, "LOG"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoColumn(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(fontSize: 12.sp, color: Colors.white60),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: GoogleFonts.inter(
              fontSize: 8.sp,
              color: customRed,
              fontWeight: FontWeight.w600
          ),
        ),
      ],
    );
  }

  Widget _buildSmallButton(IconData icon, String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
                fontSize: 9.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white
            ),
          ),
          SizedBox(width: 8.w),
          Icon(icon, size: 10.sp, color: Colors.white),
        ],
      ),
    );
  }
}