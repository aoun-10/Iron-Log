import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iron_log/Screens/Dashboard/Work_Hub/Start_Routine/routine_list.dart';
import 'package:iron_log/Screens/Dashboard/work_hub/Training/block_builder.dart';
import 'package:iron_log/Screens/Dashboard/work_hub/Exercise/exercise_library.dart';
import 'package:iron_log/Screens/Dashboard/work_hub/pr_notification.dart';
import 'package:iron_log/Screens/Dashboard/work_hub/rm_calculator.dart';

import '../../../Widgets/button.dart';
import '../../../core/theme/app_color.dart';
import 'Start_Routine/start_workout.dart';
import 'Training/plan_screen.dart';

class WorkoutHubScreen extends StatefulWidget {
  const WorkoutHubScreen({super.key});

  @override
  State<WorkoutHubScreen> createState() => _WorkoutHubScreenState();
}

class _WorkoutHubScreenState extends State<WorkoutHubScreen> {
  // Colors based on your design
  final Color brandRed = AppColors.primaryRed;
  final Color darkCard = AppColors.darkBackground;
  final Color deepRedBg = const Color(0xFF420808);
  final Color toolTileBg = const Color(0xFF120505);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBody: true,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 70.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15.h),
              Text(
                "Plan and start your workouts",
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                "WORKOUT HUB",
                style: GoogleFonts.quattrocento(
                  color: Colors.white,
                  fontSize: 30.sp,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),

              SizedBox(height: 25.h),

              // START WORKOUT CARD
              _buildStartCard(),

              SizedBox(height: 20.h),

              // ROUTINES HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Your Routines",
                      style: GoogleFonts.quattrocento(
                          color: Colors.white,
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold
                      )),
                  TextButton(
                      onPressed: () {
                        Get.to(RoutineList());
                      },
                      child: Text("See More",
                          style: GoogleFonts.inter(
                              color: brandRed,
                              decoration: TextDecoration.underline,
                              decorationColor: brandRed,
                              decorationThickness: 1,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600
                          ))
                  ),
                ],
              ),

              SizedBox(height: 11.h),

              // ROUTINE CARDS
              _buildRoutineCard("Power",
                  "DEADLIFT DAY", "04",
                  "LIFTS", "Pure posterior chain dominance and heavy singles.",
                  "assets/images/routine1.png"
              ),
              _buildRoutineCard("Power",
                  "CHEST DAY", "12",
                  "LIFTS", "High intensity circuit training with minimal rest intervals.",
                  "assets/images/routine2.png"
              ),
              _buildRoutineCard("Mobility",
                  "ACTIVE RECOVERY", "06",
                  "FLOWS", "Join health and dynamic streching flow.",
                  "assets/images/routine3.png"
              ),

              SizedBox(height: 20.h),

              // QUICK ACCESS TOOLS
              Text("Quick Access Tools",
                  style: GoogleFonts.quattrocento(
                      color: Colors.white,
                      fontSize: 23.sp,
                      fontWeight: FontWeight.bold
                  )),
              SizedBox(height: 15.h),
              InkWell(
                  onTap: (){
                    Get.to(RmCalculator());
                  },
                  child: _buildToolButton(
                  Icons.calculate_outlined, "1 RM Calculator")
              ),
              InkWell(
                  onTap: (){
                    Get.to(PrNotification());
                  },
                  child: _buildToolButton(
                      Icons.emoji_events_outlined, "PR Notification")
              ),
              InkWell(
                onTap: (){
                  Get.to(ExerciseLibraryScreen());
                },
                  child: _buildToolButton(
                      Icons.library_books_outlined, "Exercise Library")
              ),

              SizedBox(height: 25.h),

              // TRAINING PLAN SECTION
              _buildPlanCard(),

            ],
          ),
        ),
      ),
    );
  }

  // --- Start Workout Card ---
  Widget _buildStartCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.r),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF535050).withValues(alpha: 0.5),
            Color(0xFF201F1F).withValues(alpha: 0.5),
            Color(0xFF868282).withValues(alpha: 0.3),
          ],
        ),
        color: darkCard,
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("START WORKOUT",
              style: GoogleFonts.quattrocento(
                  color: Colors.white,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold
              )),
          Text("Begin your training session",
              style: GoogleFonts.inter(color: Colors.grey, fontSize: 13.sp)
          ),
          SizedBox(height: 20.h),
          Button(
            label: 'Start',
            icon: Icons.play_arrow_outlined,
            onTap: () {
              Get.to(StartWorkout());
            },
            imagePath: "assets/images/Button3.png",
            width: 110.w,
            height: 39.h,
          ),
        ],
      ),
    );
  }

  // Routine Card
  Widget _buildRoutineCard(String tag, String title, String count, String unit, String desc, String img, {double? height}) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      width: double.infinity,
      height: height ?? 188.h,
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFF181818),width: 1.5),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Stack(
        children: [
          // 1. Background Image
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: Image.asset(
                img,
                fit: BoxFit.cover,
              ),
            ),
          ),

          // 2. Linear Gradient Overlay (#202020 aur #000000)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                // Figma ki Shadow: Blur 10, Spread 0, Color 25%, X:0, Y:0
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF000000).withOpacity(0.25),
                    blurRadius: 10,
                    spreadRadius: 0,
                    offset: const Offset(0, 0),
                  ),
                ],
                // Gradient Overlay
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFF202020).withOpacity(0.7), // Light dark top
                    const Color(0xFF000000).withOpacity(0.7), // Solid dark bottom for text clarity
                  ],
                ),
              ),
            ),
          ),

          // 3. Content Layer (Wahi purana content jo aapne diya tha)
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.all(19.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // Content ko top aur bottom mein divide karne ke liye
                children: [
                  // Top Content: Tag, Title, Desc
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(tag, style: GoogleFonts.inter(
                          color: brandRed,
                          fontWeight: FontWeight.w500,
                          fontSize: 11.sp,
                          letterSpacing: 1)
                      ),
                      SizedBox(height: 13.h),
                      Text(title, style: GoogleFonts.quattrocento(
                          color: Colors.white,
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold)
                      ),
                      Text(desc,
                          style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 13.sp)
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: "$count ",
                                style: GoogleFonts.inter(
                                    fontSize: 23.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white
                                )
                            ),
                            TextSpan(
                                text: unit,
                                style: GoogleFonts.inter(
                                    fontSize: 10.sp,
                                    color: brandRed,
                                    fontWeight: FontWeight.w500
                                )
                            ),
                          ],
                        ),
                      ),

                      // Glassy Play Button
                      Container(
                        width: 25.w,
                        height: 25.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.r),
                          border: Border.all(
                            color: Colors.red.withOpacity(0.2),
                          ),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              AppColors.primaryRed.withOpacity(0.4),
                              AppColors.primaryRed.withOpacity(0.2),
                            ],
                          ),
                        ),
                        child: Icon(
                          Icons.play_arrow_outlined,
                          color: Colors.white,
                          size: 16.sp,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  // --- Tool Button ---
  Widget _buildToolButton(IconData icon, String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Material(
        color: Colors.red.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(18.r),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 20.h),
          child: Row(
            children: [
              Icon(icon, color: Colors.white70, size: 22.sp),
              SizedBox(width: 15.w),
              Text(label, style: GoogleFonts.inter(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w500)),
              const Spacer(),
              Icon(Icons.chevron_right, color: Colors.white, size: 20.sp),
            ],
          ),
        ),
      ),
    );
  }

  // --- Training Plan Card ---
  Widget _buildPlanCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.r),
      decoration: BoxDecoration(
        color: darkCard,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Training Plan",
              style: GoogleFonts.quattrocento(
                  color: Colors.white,
                  fontSize: 23.sp,
                  fontWeight: FontWeight.bold)
          ),
          SizedBox(height: 10.h),
          Text(
            "Organize your workouts into progressive cycles. Track volume trends and recovery metrics over 4-12 week periods.",
            style: GoogleFonts.inter(color: Colors.white60, fontSize: 16.sp, height: 1.5),
          ),
          SizedBox(height: 17.h),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.primaryRed.withValues(alpha: 0.3),
                  AppColors.primaryRed.withValues(alpha: 0.2),
                  AppColors.primaryRed.withValues(alpha: 0.2),
                ],
              ),
              borderRadius: BorderRadius.circular(25.r)
            ),
            child: MaterialButton(
              onPressed: () {
                Get.to(BlockBuilderScreen());
              },
              height: 45.h,
              minWidth: 139.w,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.r),
                  side: BorderSide(color: brandRed.withValues(alpha: 0.5))
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Setup Plan ", style: GoogleFonts.quattrocento(
                      color: Colors.white,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600)
                  ),
                  SizedBox(width: 5.w,),
                  Icon(Icons.settings_outlined,
                      size: 16.sp, color: Colors.white),
                ],
              ),
            ),
          ),
          SizedBox(height: 15.h),
          GestureDetector(
            onTap: () {
              Get.to(TrainingPlanScreen());
            },
            child: Text("View Plan",
                style: GoogleFonts.inter(
                    color: brandRed,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                    decorationColor: brandRed,
                    decorationThickness: 1,
                )),
          ),
        ],
      ),
    );
  }
}