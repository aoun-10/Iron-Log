import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iron_log/Screens/Dashboard/work_hub/workout_hub.dart';

import '../../../Widgets/button.dart';
import '../../../Widgets/custom_button.dart';
import '../../../Widgets/custom_paint.dart';
import '../../../core/theme/app_color.dart'; // Ensure this path is correct

class PrNotification extends StatefulWidget {
  const PrNotification({super.key});

  @override
  State<PrNotification> createState() => _PrNotificationState();
}

class _PrNotificationState extends State<PrNotification> {
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
          child:CustomButton(
            onTap: (){
              Get.back();
            },),
        ),
        title: Padding(
          padding: EdgeInsets.only(top: 15.h),
          child: Text(
            "New Achievement",
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(height: 20.h),
            // --- Main Achievement Card ---
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 20.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24.r),
                border: Border.all(color: AppColors.primaryRed, width: 1.5),
                gradient: RadialGradient(
                  center: Alignment.topCenter,
                  radius: 1.5,
                  colors: [
                    AppColors.primaryRed.withValues(alpha: 0.2),
                    Colors.black,
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Badge Icon with Glow
                  Center(
                    child: Container(
                      width: 140.w,
                      height: 140.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primaryRed.withValues(alpha: 0.4),
                            blurRadius: 50,
                            spreadRadius: 5,
                          )
                        ],
                        gradient: RadialGradient(
                          colors: [Color(0xFF2A0202),
                            Color(0xFF2A0202)],
                        ),
                        border: Border.all(color: const Color(0xFFA90909).withValues(alpha: 0.8), width: 6),
                      ),
                      child: Center(
                        child: Icon(Icons.workspace_premium, color: AppColors.primaryRed, size: 50.sp),
                      ),
                    ),
                  ),
                  SizedBox(height: 40.h),
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "PERSONAL RECORD SMASHED",
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w800,
                            color: AppColors.primaryRed,
                          ),
                        ),
                        Text(
                          "DEAD LIFT",
                          style: GoogleFonts.quattrocento(
                            fontSize: 36.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  // Comparison Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildRecordBox("OLD RECORD", "140", Colors.white),
                      SizedBox(width: 20.w),
                      _buildRecordBox("NEW PR", "145", AppColors.primaryRed),
                    ],
                  ),
                ],
              ),
            ),
            Spacer(),
            // Bottom Buttons
            Button(
              label: 'Share Achievement',
              onTap: () {},
            ),
            SizedBox(height: 8.h),
            TextButton(
              onPressed: () {  },
              child: Text(
                "CONTINUE WORKOUT",
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }

  Widget _buildRecordBox(String label, String value, Color valueColor) {
    return Container(
      width: 130.w,
      padding: EdgeInsets.symmetric(vertical: 20.h),
      decoration: BoxDecoration(
        color: AppColors.darkBackground,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 10.sp,
              color: Colors.grey[600],
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.h),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: value,
                  style: GoogleFonts.inter(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                    color: valueColor,
                  ),
                ),
                TextSpan(
                  text: " KG",
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}