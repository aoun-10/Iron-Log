import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iron_log/Widgets/custom_paint.dart';
import '../../../Widgets/custom_button.dart';
import '../../../core/theme/app_color.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

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
            'Notifications',
            style: GoogleFonts.quattrocento(
              color: Colors.white,
              fontSize: 28.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              _buildSectionHeader("TODAY"),
              _buildNotificationCard(
                icon: Icons.emoji_events_outlined,
                tag: "NEW PR",
                time: "2 days ago",
                title: "You Weight 405 LBS On Deadlift",
                subtitle: "Absolute dominance in the rack. That’s a 10 kg increases from your last session",
              ),
              _buildNotificationCard(
                tag: "YOUR TOTAL WORKOUT ROUTINE",
                time: "5 days ago",
                title: "Time For Leg Day Destruction",
                subtitle: "The iron is waiting. Your pre- workout window is closing. Lets get after it.",
              ),
              SizedBox(height: 10.h),
              _buildSectionHeader("YESTERDAY"),
              _buildNotificationCard(
                icon: Icons.local_fire_department,
                tag: "STREAK ALERT",
                time: "Yesterday",
                title: "14 Days And Counting",
                subtitle: "Your discipline is becoming a habit. Two weeks of the consistent logging complete.",
              ),
              _buildNotificationCard(
                icon: Icons.local_fire_department,
                tag: "STREAK ALERT",
                time: "Yesterday",
                title: "14 Days And Counting",
                subtitle: "Your discipline is becoming a habit. Two weeks of the consistent logging complete.",
                isRead: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15.h),
      child: Row(
        children: [
          Text(
            title,
            style: GoogleFonts.quattrocento(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Divider(color: Colors.white24, thickness: 0.5.h),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationCard({
    IconData? icon,
    required String tag,
    required String time,
    required String title,
    required String subtitle,
    bool isRead = false,
  }) {
    return Opacity(
      opacity: isRead ? 0.5 : 1.0,
      child: Container(
        margin: EdgeInsets.only(bottom: 15.h),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(18.r),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18.r),
          child: Stack(
            children: [
              // 1. Red Border Line
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                child: Container(
                  width: 4.5.w,
                  color: AppColors.primaryRed,
                ),
              ),

              // 2. Main Content
              Padding(
                padding: EdgeInsets.fromLTRB(22.w, 16.h, 16.w, 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        if (icon != null) ...[
                          Icon(icon, color: AppColors.primaryRed, size: 18
                              .sp),
                          SizedBox(width: 8.w),
                        ],
                        Text(
                          tag,
                          style: GoogleFonts.inter(
                            color: AppColors.primaryRed,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          time,
                          style: GoogleFonts.inter(
                            color: Colors.grey.shade600,
                            fontSize: 11.sp,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      title,
                      style: GoogleFonts.quattrocento(
                        color: Colors.white,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      subtitle,
                      style: GoogleFonts.inter(
                        color: Colors.grey.shade400,
                        fontSize: 9.sp,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}