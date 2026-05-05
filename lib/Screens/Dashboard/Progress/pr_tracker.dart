import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Widgets/custom_button.dart';
import '../../../Widgets/custom_paint.dart';
import '../../../core/theme/app_color.dart';

class PRTracker extends StatelessWidget {
  const PRTracker({super.key});

  final Color primaryRed = AppColors.primaryRed;

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
            "Your PR Tracker",
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
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 7.h),
              _buildMainHeading(),
              SizedBox(height: 15.h),
              _buildTotalPowerLoadCard(),
              SizedBox(height: 15.h),
              _buildSubHeading("BIG FOUR MASTERY"),
              SizedBox(height: 15.h),
              _buildLiftCard("Squat", "145", "March 12", 0.75, Icons.fitness_center),
              _buildLiftCard("Bench Press", "105", "March 18", 0.65, Icons.accessibility_new),
              _buildLiftCard("Deadlift", "180", "March 22", 0.85, Icons.bolt),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMainHeading() {
    return Text(
      "PERSONAL RECORDS",
      style: GoogleFonts.quattrocento(
        color: Colors.white,
        fontSize: 28.sp,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildTotalPowerLoadCard() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: AppColors.darkBackground,
        border: Border.all(color: Color(0xFF181818),width: 1.5),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "TOTAL POWERLOAD",
                style: GoogleFonts.inter(
                  color: Colors.grey,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    "490",
                    style: GoogleFonts.inter(
                      color: primaryRed,
                      fontSize: 40.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 3.w),
                  Text(
                    "kg",
                    style: GoogleFonts.inter(color: Colors.white, fontSize: 18.sp),
                  ),
                ],
              ),
              SizedBox(height: 5.h),
              Row(
                children: [
                  Icon(Icons.trending_up, color: primaryRed, size: 16.sp),
                  SizedBox(width: 5.w),
                  Text(
                    "+12.5% vs last month",
                    style: GoogleFonts.inter(color: primaryRed, fontSize: 12.sp),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            right: 0,
            top: 0,
            child: Opacity(
              opacity: 0.9,
              child: Image.asset("assets/icons/PRtrackerIcon.png",width: 80.w,height: 100.h,),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSubHeading(String title) {
    return Text(
      title,
      style: GoogleFonts.inter(
        color: Colors.grey,
        fontSize: 12.sp,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.0,
      ),
    );
  }

  Widget _buildLiftCard(String title, String weight, String date, double progress,final icon) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.h),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.darkBackground,
        border: Border.all(color: Color(0xFF181818),width: 1.5),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(icon, color: Colors.white, size: 16.sp),
                  SizedBox(width: 10.w),
                  Text(
                    title,
                    style: GoogleFonts.quattrocento(
                      color: Colors.white,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    weight,
                    style: GoogleFonts.inter(
                      color: primaryRed,
                      fontSize: 26.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    "KG",
                    style: GoogleFonts.inter(color: Colors.white, fontSize: 10.sp),
                  ),
                ],
              ),
            ],
          ),
          Text(
            "Last PR : $date",
            style: GoogleFonts.inter(color: Colors.grey, fontSize: 12.sp),
          ),
          SizedBox(height: 20.h),
          Stack(
            children: [
              Container(
                height: 4.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              Container(
                height: 4.h,
                width: 200.w * progress, // Responsive progress bar
                decoration: BoxDecoration(
                  color: primaryRed,
                  borderRadius: BorderRadius.circular(2.r),
                  boxShadow: [
                    BoxShadow(color: primaryRed.withValues(alpha: 0.5), blurRadius: 4, spreadRadius: 1)
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}