import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iron_log/Screens/Dashboard/Home/Profile_Screen/Edit_profile.dart';
import 'package:iron_log/Screens/auth/Login/changepassword.dart';
import 'package:iron_log/Screens/auth/Login/login.dart';
import 'package:iron_log/Screens/auth/Sign_Up/privacy_policy.dart';
import 'package:iron_log/Screens/auth/Sign_Up/terms_conditional.dart';
import 'package:iron_log/Widgets/custom_button.dart';
import 'package:iron_log/core/theme/app_color.dart';

import '../../../../Widgets/button.dart';

class AccountSettingsScreen extends StatelessWidget {
  const AccountSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w,20.h, 20.w, 0.h),
          child: Column(
            children: [
              // Custom AppBar Section
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Back Button with circular gradient background
                  CustomButton(
                    onTap: (){
                      Get.back();
                  },),
                  SizedBox(width: 15.w,),
                  // Header Title - Quattrocento
                  Text(
                    'Settings',
                    style: GoogleFonts.quattrocento(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  // Small Profile Image
                  CircleAvatar(
                    radius: 22.r,
                    backgroundImage: AssetImage("assets/images/Onboarding1.png"),
                  ),
                ],
              ),

              SizedBox(height: 60.h),

              // Settings Options List
              GestureDetector(
                onTap: (){
                  Get.to(EditProfileScreen());
                },
                  child: _buildSettingsTile('Edit Profile')
              ),
              SizedBox(height: 7.h),
              GestureDetector(
                onTap: (){
                  Get.to(Changepassword());
                },
                  child: _buildSettingsTile('Change Password')
              ),
              SizedBox(height: 7.h),
              GestureDetector(
                  onTap: (){
                    Get.to(PrivacyPolicyScreen());
                  },
                  child: _buildSettingsTile('Privacy Policy')
              ),
              SizedBox(height: 7.h),
              GestureDetector(
                  onTap: (){
                    Get.to(TermsConditional());
                  },
                  child: _buildSettingsTile('Terms & Conditions')
              ),

              const Spacer(),

              // Logout Button - Custom Gradient Style
              // Logout Button
              Button(
                label: 'Logout',
                onTap: () {
                  _showLogoutDialog(context);
                },
                textColor: AppColors.primaryRed,
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method for Settings Tiles
  Widget _buildSettingsTile(String title) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
      decoration: BoxDecoration(
        color: Colors.red.withValues(alpha: 0.2),// Dark reddish-black tint
        borderRadius: BorderRadius.circular(25.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 13.sp,
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: Colors.white,
            size: 16.r,
          ),
        ],
      ),
    );
  }
}
// --- Logout Dialog Box ---
void _showLogoutDialog(BuildContext context) {
  Get.dialog(
    Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Color(0xFF1A1A1A), // Dark theme color
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: AppColors.primaryRed.withValues(alpha: 0.5), width: 1),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon
            Icon(Icons.logout_rounded, color: AppColors.primaryRed, size: 50.sp),
            SizedBox(height: 20.h),

            // Title
            Text(
              "Are you sure you want to Quit?",
              textAlign: TextAlign.center,
              style: GoogleFonts.quattrocento(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 30.h),

            // Buttons
            Row(
              children: [
                // No Button
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.white24),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                    onPressed: () => Get.back(),
                    child: Text("No", style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w600)),
                  ),
                ),
                SizedBox(width: 15.w),

                // Yes Button
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryRed,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                    onPressed: () {
                      Get.back();
                      Get.offAll(() => LoginScreen());
                    },
                    child: Text("Yes", style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w600)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
    barrierDismissible: false,
  );
}