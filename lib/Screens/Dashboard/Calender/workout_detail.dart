import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../Widgets/custom_button.dart';

class WorkoutDetail extends StatelessWidget {
  const WorkoutDetail({super.key});

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
            "See Your Workout Detail",
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
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 7.h),
              Text(
                "WORKOUT DETAILS",
                style: GoogleFonts.quattrocento(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20.h),

              // Exercise 1: Bench Press
              _buildExerciseHeader("Bench Press", "04 SETS"),
              _buildSetCard("01", "100", "08"),
              _buildSetCard("02", "100", "08"),
              _buildSetCard("03", "100", "07"),
              _buildSetCard("04", "100", "06"),

              SizedBox(height: 10.h),

              // Exercise 2: Inclined Press
              _buildExerciseHeader("Inclined Press", "01 SET"),
              _buildSetCard("01", "32", "12"),

              SizedBox(height: 10.h),

              // Exercise 3: Chest Flys
              Opacity(
                  opacity: 0.5,
              child: _buildExerciseHeader("Chest Flys", "01 SET")),
              Opacity(
                  opacity: 0.5,
              child: _buildSetCard("01", "15", "12")),

              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }

  // Header for each Exercise
  Widget _buildExerciseHeader(String title, String setsCount) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.quattrocento(
              fontSize: 23.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            setsCount,
            style: GoogleFonts.inter(
              fontSize: 10.sp,
              fontWeight: FontWeight.w400,
              color: Colors.grey.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }

  // Individual Set Card
  Widget _buildSetCard(String setNo, String kg, String reps) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 18.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(40.r),
      ),
      child: Row(
        children: [
          // Set Number (01, 02...)
          Text(
            setNo,
            style: GoogleFonts.inter(
              fontSize: 18.sp,
              fontWeight: FontWeight.w900,
              color: Colors.white.withValues(alpha: 0.1),
            ),
          ),
          const Spacer(),
          // Weight Value
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                kg,
                style: GoogleFonts.inter(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 4.w),
              Text(
                "KG",
                style: GoogleFonts.inter(
                  fontSize: 10.sp,
                  color: Colors.grey.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
          const Spacer(flex: 2),
          // Reps Value
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                reps,
                style: GoogleFonts.inter(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 4.w),
              Text(
                "Reps",
                style: GoogleFonts.inter(
                  fontSize: 10.sp,
                  color: Colors.grey.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}