import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iron_log/Screens/Dashboard/Home/Profile_Screen/account_setting.dart';
import 'package:iron_log/core/theme/app_color.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w,70.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40.h),

              // Profile Image
              Center(
                child: CircleAvatar(
                  radius: 60.r,
                  backgroundColor: Colors.grey[900],
                  backgroundImage: AssetImage("assets/images/Onboarding1.png"),
                ),
              ),

              SizedBox(height: 20.h),

              Text(
                'BRAVO CHARLEY',
                style: GoogleFonts.quattrocento(
                  fontSize: 23.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.2,
                ),
              ),

              Text(
                'bravocharley121@gmail.com',
                style: GoogleFonts.inter(
                  fontSize: 13.sp,
                  color: Colors.white70,
                ),
              ),

              SizedBox(height: 12.h),

              // Status Tag
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.circle, color: AppColors.primaryRed, size: 10.r),
                  SizedBox(width: 4.w),
                  Text(
                    'Strength Specialist',
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      color: AppColors.primaryRed,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 40.h),

              // Stats Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStatCard('Total Workouts', '142', null),
                  _buildStatCard('Weight Lifted', '1.2M', 'KG'),
                  _buildStatCard('Current Streak', '14', '🔥'),
                ],
              ),

              SizedBox(height: 30.h),

              // Account Settings Button
              GestureDetector(
                onTap: (){
                  Get.to(AccountSettingsScreen());
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
                  decoration: BoxDecoration(
                    color: Colors.red.withValues(alpha: 0.2), // Dark reddish tint
                    borderRadius: BorderRadius.circular(25.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Account Settings',
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          color: Colors.white,
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16.r),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method for Stats Cards
  Widget _buildStatCard(String title, String value, String? unit) {
    return Container(
      width: 100.w,
      height: 106.h,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.darkBackground,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 10.sp,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 12.h),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: value,
                  style: GoogleFonts.inter(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryRed,
                  ),
                ),
                if (unit != null)
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: ColorFiltered(
                      colorFilter: const ColorFilter.mode(
                        Colors.grey,
                        BlendMode.srcIn,
                      ),
                      child: Text(
                        ' $unit',
                        style: GoogleFonts.inter(
                          fontSize: 10.sp,
                        ),
                      ),
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