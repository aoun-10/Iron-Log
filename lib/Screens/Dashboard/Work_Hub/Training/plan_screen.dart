import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../Widgets/custom_button.dart';
import '../../../../Widgets/custom_paint.dart';
import '../../../../core/theme/app_color.dart';

class TrainingPlanScreen extends StatelessWidget {
  const TrainingPlanScreen({super.key});

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
            "Your Weekly Workout Structure",
            style: GoogleFonts.inter(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20.w,0.h, 20.w, 0.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 7.h),
            Text(
              "TRAINING PLAN",
              style: GoogleFonts.quattrocento(
                fontSize: 28.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20.h),

            // Active Cycle Main Card
            _buildActiveCycleCard(),

            SizedBox(height: 30.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "BLOCK ROADMAP",
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  "4 Weeks Total",
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    color: AppColors.primaryRed,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15.h),

            // Roadmap List
            Expanded(
              child: ListView(
                children: [
                  _buildRoadmapTile(
                    index: "01",
                    week: "Week 01",
                    title: "Hypertrophy",
                    status: "completed",
                  ),
                  _buildRoadmapTile(
                    index: "02",
                    week: "Week 02",
                    title: "Strength",
                    status: "current",
                  ),
                  _buildRoadmapTile(
                    index: "03",
                    week: "Week 03",
                    title: "Heavy",
                    status: "locked",
                  ),
                  _buildRoadmapTile(
                    index: "04",
                    week: "Week 04",
                    title: "Deload",
                    status: "locked",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActiveCycleCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white12,
            Colors.black26,
            Colors.white10,
          ],
        ),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Active Cycle",
            style: GoogleFonts.inter(
              fontSize: 10.sp,
              color: AppColors.primaryRed,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            "Current Week : Week 2",
            style: GoogleFonts.quattrocento(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 7.h),
          Text(
            "Follow this week's plan to hit your strength benchmarks.",
            style: GoogleFonts.inter(
              fontSize: 13.sp,
              color: Colors.grey[500],
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoadmapTile({
    required String index,
    required String week,
    required String title,
    required String status,
  }) {
    bool isCurrent = status == "current";
    bool isCompleted = status == "completed";
    bool isLocked = status == "locked";

    return Container(
      margin: EdgeInsets.only(bottom: 9.h),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      decoration: BoxDecoration(
        color: isLocked ? const Color(0xFF0F0F0F) : const Color(0xFF1A1A1A),
        gradient: (isCurrent || isCompleted) ? LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF201F1F),
            Color(0xFF201F1F),
          ],
        ) : null,
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(
          color: isCurrent
              ? Colors.white.withValues(alpha: 0.1)
              : Colors.white.withValues(alpha: 0.02),
        ),
      ),
      child: Row(
        children: [
          Text(
            index,
            style: GoogleFonts.quattrocento(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: isCurrent ? AppColors.primaryRed : (isLocked ? Colors.grey[800] : Colors.grey[700]),
            ),
          ),
          SizedBox(width: 20.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isCurrent ? "Current" : week,
                  style: GoogleFonts.inter(
                    fontSize: 11.sp,
                    color: isCurrent ? AppColors.primaryRed : Colors.grey[700],
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  title,
                  style: GoogleFonts.quattrocento(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: isLocked ? Colors.grey[800] : Colors.white,
                  ),
                ),
              ],
            ),
          ),
          _getStatusIcon(status),
        ],
      ),
    );
  }

  Widget _getStatusIcon(String status) {
    if (status == "completed") {
      return Icon(Icons.check_circle, color: AppColors.primaryRed, size: 22.sp);
    } else if (status == "current") {
      return Icon(Icons.timer_outlined, color: AppColors.primaryRed, size: 22.sp);
    } else {
      return Icon(Icons.lock_outline, color: Colors.red.withValues(alpha: 0.1), size: 22.sp);
    }
  }
}