import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iron_log/Screens/Dashboard/Home/Upgrade/upgrade_plan.dart';
import '../../../../Widgets/button.dart';
import '../../../../Widgets/custom_button.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../Widgets/custom_paint.dart';

class Upgrade extends StatelessWidget {
  const Upgrade({super.key});

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
            "Set Your Plan To Subscription",
            style: GoogleFonts.inter(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 7.h),
              Text(
                "UPGRADE TO PRO",
                style: GoogleFonts.quattrocento(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 40.h),

              // Main Upgrade Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(30.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(color:AppColors.primaryRed.withValues(alpha: 0.4), width: 1.5),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.primaryRed.withValues(alpha: 0.3),
                      AppColors.primaryRed.withValues(alpha: 0.3),
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "LIMIT REACHED",
                      style: GoogleFonts.quattrocento(
                        fontSize: 23.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      "Upgrade to Pro to unlock unlimited\nroutines and custom exercises.",
                      style: GoogleFonts.inter(
                        fontSize: 13.sp,
                        color: Colors.white.withValues(alpha: 0.6),
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 35.h),

                    // Feature List
                    _buildFeatureItem(Icons.crop_free, "Unlimited Workout Logs"),
                    SizedBox(height: 20.h),
                    _buildFeatureItem(Icons.analytics_outlined, "Advanced Analytics"),
                    SizedBox(height: 20.h),
                    _buildFeatureItem(Icons.timer_outlined, "Custom Rest Timers"),
                  ],
                ),
              ),

              Spacer(),

              // Bottom Buttons
              Button(
                label: 'Go Pro Now',
                icon: Icons.play_arrow_rounded,
                onTap: () {
                  Get.to(UpgradePlan());
                },
                height: 65.h,
              ),
              SizedBox(height: 10.h),
              Center(
                child: TextButton(
                  onPressed: () => Get.back(),
                  child: Text(
                    "MAY BE LATER",
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primaryRed.withValues(alpha: 1.2), size: 24.sp),
        SizedBox(width: 12.w),
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}