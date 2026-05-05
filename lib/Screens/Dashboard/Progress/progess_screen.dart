import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iron_log/Screens/Dashboard/Progress/measurement.dart';
import 'package:iron_log/Screens/Dashboard/Progress/pr_tracker.dart';
import 'package:iron_log/Screens/Dashboard/Progress/recovery.dart';
import 'package:iron_log/Screens/Dashboard/Progress/strenght_graph.dart';
import 'package:iron_log/Screens/Dashboard/Progress/volume_over_time.dart';

import '../../../core/theme/app_color.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 65.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15.h),
              Text(
                "PERFORMANCE ANALYTICS",
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.2,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                "PROGRESS",
                style: GoogleFonts.quattrocento(
                  color: Colors.white,
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.h),

              // Time Filters Row
              Row(
                children: [
                  _buildFilterChip("Last 30 Days", false),
                  SizedBox(width: 7.w),
                  _buildFilterChip("All Time", true),
                  SizedBox(width: 7.w),
                  _buildIconButton(Icons.calendar_month_outlined, context),
                ],
              ),
              SizedBox(height: 25.h),

              // Improvement Card
              _buildBigCard(),
              SizedBox(height: 16.h),

              // Grid Stats
              Row(
                children: [
                  Expanded(child: _buildStatCard("Total Workouts",
                      "142", subText: "+12%",
                      subTextColor: AppColors.primaryRed)
                  ),
                  SizedBox(width: 16.w),
                  Expanded(child: _buildStatCard("Last Workout", "Yesterday")),
                ],
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  Expanded(child: _buildStatCard("Best lifts", "180 kg",
                      isHighlight: true)),
                  SizedBox(width: 16.w),
                  Expanded(child: _buildStatCard("Current Streak", "5",
                      subText: "Days", subTextColor: AppColors.primaryRed)
                  ),
                ],
              ),

              SizedBox(height: 30.h),
              Text(
                "Analytics Modules",
                style: GoogleFonts.quattrocento(
                  color: Colors.white,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.h),

              // Module List
              GestureDetector(
                onTap: (){
                  Get.to(StrengthGraph());
                },
                  child: _buildModuleTile(Icons.trending_up, "Strength Trend Graph")
              ),
              GestureDetector(
                  onTap: (){
                    Get.to(VolumeOverTime());
                  },
                  child: _buildModuleTile(Icons.bar_chart, "Volume Over Time")
              ),
              GestureDetector(
                  onTap: (){
                    Get.to(PRTracker());
                  },
                  child: _buildModuleTile(Icons.emoji_events_outlined, "PR Tracker")
              ),
              GestureDetector(
                  onTap: (){
                    Get.to(Recovery());
                  },
                  child: _buildModuleTile(Icons.favorite_border, "Recovery")
              ),
              GestureDetector(
                  onTap: (){
                    Get.to(Measurement());
                  },
                  child: _buildModuleTile(Icons.straighten, "Measurements")
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper Widgets
  Widget _buildFilterChip(String label, bool isActive) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: isActive ? null : const Color(0xFF201F1F),
        gradient: isActive
            ? LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primaryRed.withValues(alpha: 0.3),
            AppColors.primaryRed.withValues(alpha: 0.3),
            AppColors.primaryRed.withValues(alpha: 0.3),
          ],
        ) : null,
        borderRadius: BorderRadius.circular(12.r),
        border: isActive ? Border.all(color: Colors.red.withValues(alpha: 0.5))
            :Border.all(color: Color(0xFF181818),width: 1.5),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(color: Colors.white, fontSize: 13.sp),
      ),
    );
  }

  Widget _buildIconButton(IconData icon, BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // Date Picker open karne ke liye logic
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.dark(
                  primary: AppColors.primaryRed, // Selected date color
                  onPrimary: Colors.white,
                  surface: Color(0xFF1E1E1E), // Background color
                  onSurface: Colors.white,
                ),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.primaryRed, // Button text color

                  ),
                ),
                textTheme: const TextTheme(
                  bodyLarge: TextStyle(color: Colors.white),)
              ),
              child: child!,
            );
          },
        );

        if (picked != null) {
          print("Selected Date: $picked");
          // Yahan aap selected date ko state mein save kar sakte hain
        }
      },
      child: Container(
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(50.r),
          border: Border.all(color: Color(0xFF181818),width: 1.5),
        ),
        child: Icon(icon, color: Colors.white, size: 20.sp),
      ),
    );
  }

  Widget _buildBigCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 20.w,top: 20.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white12,
            Colors.black38,
            Colors.white12,
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Color(0xFF181818),width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text("IMPROVEMENT", style: GoogleFonts.inter(color: Colors.grey, fontSize: 12.sp)),
              SizedBox(width: 4.w),
              Icon(Icons.trending_up, color: AppColors.primaryRed, size: 14.sp),
            ],
          ),
          Row(
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "+10KG ",
                      style: GoogleFonts.inter(color: Colors.white, fontSize: 36.sp, fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: "Increase",
                      style: GoogleFonts.inter(color: Colors.grey, fontSize: 16.sp),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 25.w,),
              SizedBox(
                width: 80.w,
                height: 80.h,
                child: Image.asset("assets/icons/progressicon.png"),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, {String? subText, Color? subTextColor, bool isHighlight = false}) {
    return Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isHighlight ? null : AppColors.darkBackground,
          gradient: isHighlight
              ?LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF3D0000),
              Color(0xFF3D0000),
              Color(0xFF3D0000),
            ],
          ) : null,
          borderRadius: BorderRadius.circular(16.r),
          border: isHighlight
              ? Border.all(color: const Color(0xFFA90000), width: 1.5)
              : Border.all(color: Color(0xFF181818),width: 1.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          Text(title, style: GoogleFonts.inter(color: Colors.grey, fontSize: 12.sp)),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                value,
                style: isHighlight
                    ? GoogleFonts.quattrocento(color: Colors.white,
                    fontSize: 24.sp, fontWeight: FontWeight.bold)
                    : GoogleFonts.quattrocento(color: Colors.white,
                    fontSize: 24.sp, fontWeight: FontWeight.bold
                ),
              ),
              if (subText != null) ...[
                SizedBox(width: 4.w),
                Text(subText,
                    style: GoogleFonts.inter(
                        color: subTextColor ?? Colors.grey,
                        fontSize: 10.sp)
                ),
              ]
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildModuleTile(IconData icon, String title) {
    return Container(
      margin: EdgeInsets.only(bottom: 6.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: Colors.red.withValues(alpha: 0.2), // Dark reddish black
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 20.sp),
          SizedBox(width: 16.w),
          Text(title, style: GoogleFonts.inter(color: Colors.white, fontSize: 14.sp)),
          const Spacer(),
          Icon(Icons.arrow_forward_ios, color: Colors.white, size: 14.sp),
        ],
      ),
    );
  }
}