import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iron_log/Screens/Dashboard/Work_Hub/Start_Routine/live_workout.dart';
import 'package:iron_log/Widgets/button.dart';
import '../../../../Widgets/custom_button.dart';
import '../../../../core/theme/app_color.dart';

class StartWorkout extends StatelessWidget {
  const StartWorkout({super.key});

  // Custom Red Color Code
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
            "Current Session",
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(20.w, 0.h, 20.w, 0.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.h),
                    Text(
                      "WORKOUT PREVIEW",
                      style: GoogleFonts.quattrocento(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 25.h),

                    // Main Banner Card
                    _buildBannerCard(),

                    SizedBox(height: 25.h),

                    // Exercise Plan Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Excercie Plan",
                          style: GoogleFonts.quattrocento(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "6 TOTAL EXERCISES",
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w900,
                            color: customRed,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 20.h),

                    // Exercise List
                    _buildExerciseItem("01", "BARBELL BENCH PRESS", "4 SETS × 8-10 REPS"),
                    _buildExerciseItem("02", "OVERHEAD PRESS", "3 SETS × 10 REPS"),
                    _buildExerciseItem("03", "INCLINE DB FLYES", "3 SETS × 12-15 REPS"),
                  ],
                ),
              ),
            ),

            // Bottom Start Workout Button
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 0.h, 20.w, 20.h),
              child: Button(
                  label: "Start Workout",
                  icon: Icons.play_arrow,
                  onTap: (){
                    Get.to(LiveWorkout());
                  },
                  height: 55.h,
              )
            ),
          ],
        ),
      ),
    );
  }

  // Banner Widget
  Widget _buildBannerCard() {
    return Container(
      width: double.infinity,
      height: 125.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Color(0xFF181818),width: 1.5),
        image: DecorationImage(
          image: AssetImage("assets/images/start_workout1.png"),
          fit: BoxFit.cover,
          opacity: 0.4,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(0.25),
            blurRadius: 10,
            spreadRadius: 0,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(30.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "CHEST DAY",
              style: GoogleFonts.quattrocento(
                fontSize: 23.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              "Hypertrophy phase . 65 mins",
              style: GoogleFonts.inter(
                fontSize: 11.sp,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Exercise List Item Widget
  Widget _buildExerciseItem(String number, String name, String details) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 17.h),
      decoration: BoxDecoration(
        color: Color(0xFF201F1F),
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Row(
        children: [
          Text(
            number,
            style: GoogleFonts.inter(
              fontSize: 28.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white24,
            ),
          ),
          SizedBox(width: 15.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: GoogleFonts.quattrocento(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                details,
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  color: Colors.white38,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}