import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../Widgets/custom_button.dart';
import '../../../../Widgets/custom_paint.dart';
import '../../../../core/theme/app_color.dart';

class History extends StatelessWidget {
  const History({super.key});

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
          child:CustomButton(
            onTap: (){
              Get.back();
            },),
        ),
        title: Padding(
          padding: EdgeInsets.only(top: 15.h),
          child: Text(
            "PERFORMANCE ARCHIVE",
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView( // Added scroll view for history list
            child: Padding(
                padding: EdgeInsets.fromLTRB(20.w, 0.h, 20.w, 0.h),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 7.h),
                      Text(
                        "HISTORY",
                        style: GoogleFonts.quattrocento(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),

                      SizedBox(height: 8.h),
                      Text(
                        "Total Sessions",
                        style: GoogleFonts.inter(
                          fontSize: 13.sp,
                          color: Colors.white54,
                        ),
                      ),
                      Text(
                        "142",
                        style: GoogleFonts.inter(
                          fontSize: 23.sp,
                          fontWeight: FontWeight.bold,
                          color: customRed,
                        ),
                      ),
                      SizedBox(height: 15.h),
                      // March Section
                      _buildMonthHeader("MARCH 2026"),
                      _buildHistoryCard("March 20, 2026", "Chest Day", "12,450 Kg", "64 m"),
                      _buildHistoryCard("March 19, 2026", "Leg Day", "12,450 Kg", "64 m"),

                      SizedBox(height: 7.h),

                      // February Section
                      _buildMonthHeader("FEBRUARY 2026"),
                      _buildHistoryCard("Feb 20, 2026", "Dead Lift", "12,450 Kg", "64 m"),

                      SizedBox(height: 30.h),

                      // Load More
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Load More Sessions ",
                              style: GoogleFonts.inter(
                                color: customRed,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Icon(Icons.south, color: customRed, size: 16.sp),
                          ],
                        ),
                      ),
                    ]
                )
            ),
          )
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _buildMonthHeader(String month) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15.h),
      child: Text(
        month,
        style: GoogleFonts.inter(
          fontSize: 15.sp,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildHistoryCard(String date, String title, String volume, String time) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.darkBackground,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            date,
            style: GoogleFonts.inter(color: Colors.white38, fontSize: 11.sp),
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: GoogleFonts.quattrocento(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  _buildStatColumn("Volume", volume),
                  SizedBox(width: 25.w),
                  _buildStatColumn("Time", time),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatColumn(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(color: Colors.white38, fontSize: 13.sp),
        ),
        SizedBox(height: 7.h,),
        Text(
          value,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 13.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}