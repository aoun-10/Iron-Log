import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../Widgets/custom_button.dart';
import '../../../Widgets/custom_paint.dart';
import '../../../core/theme/app_color.dart';

class Measurement extends StatefulWidget {
  const Measurement({super.key});

  @override
  State<Measurement> createState() => _MeasurementState();
}

class _MeasurementState extends State<Measurement> {

  static const Color customRed = AppColors.primaryRed;

  double currentWeight = 82.5;
  void _toggleWeight() {
    setState(() {
      if (currentWeight == 82.5) {
        currentWeight = 83.2;
      } else {
        currentWeight = 82.5;
      }
    });
  }

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
            "Analytical Insights",
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
              Text(
                "MEASUREMENTS",
                style: GoogleFonts.quattrocento(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 15.h),

              // --- CURRENT BODYWEIGHT CONTAINER (SAME AS YOUR UI) ---
              GestureDetector(
                onTap: _toggleWeight,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(22.w),
                  decoration: BoxDecoration(
                      color: AppColors.darkBackground, // Dark Grey Background
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "CURRENT BODYWEIGHT",
                            style: GoogleFonts.inter(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[600],
                            ),
                          ),
                          // Specific Icon from your UI
                          Icon(Icons.hourglass_empty_rounded, color: customRed, size: 22.sp),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            "$currentWeight",
                            style: GoogleFonts.inter(
                              fontSize: 36.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            "kg",
                            style: GoogleFonts.inter(
                              fontSize: 18.sp,
                              color: Colors.grey[400],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5.h),
                      Row(
                        children: [
                          Icon(Icons.trending_down, color: customRed, size: 14.sp),
                          SizedBox(width: 5.w),
                          Text(
                            "-0.5 kg",
                            style: GoogleFonts.inter(
                              fontSize: 13.sp,
                              color: customRed,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            "since last week",
                            style: GoogleFonts.inter(
                              fontSize: 13.sp,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 25.h),

                      // Bar Graph (Same as your UI)
                      SizedBox(
                        height: 55.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            _buildBar(0.6, false),
                            _buildBar(0.5, false),
                            _buildBar(0.7, false),
                            _buildBar(0.45, false),
                            _buildBar(0.4, false),
                            _buildBar(0.35, false),
                            _buildBar(0.3, true), // Last Bar is Red
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 35.h),

              // Body Parts Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Body Parts",
                    style: GoogleFonts.quattrocento(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Last Updated: March 12",
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),

              // Grid for Body Parts
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 15.h,
                crossAxisSpacing: 15.w,
                childAspectRatio: 1.5,
                children: [
                  _buildPartCard("Chest", "110"),
                  _buildPartCard("Arms", "42"),
                  _buildPartCard("Waist", "85"),
                  _buildPartCard("Legs", "62"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper Widget for Graph Bars
  Widget _buildBar(double heightFactor, bool isLast) {
    return Container(
      width: 38.w,
      height: 80.h * heightFactor,
      decoration: BoxDecoration(
        color: isLast ? customRed : customRed.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(4.r),
      ),
    );
  }

  // Helper Widget for Body Part Cards
  Widget _buildPartCard(String label, String value) {
    return Container(
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: AppColors.darkBackground,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(color: Colors.grey[600], fontSize: 13.sp),
          ),
          SizedBox(height: 5.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                value,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 4.w),
              Text(
                "cm",
                style: GoogleFonts.inter(color: customRed, fontSize: 12.sp),
              ),
            ],
          ),
        ],
      ),
    );
  }
}