import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Widgets/custom_button.dart';
import '../../../Widgets/custom_paint.dart';
import '../../../core/theme/app_color.dart';

class Recovery extends StatefulWidget {
  const Recovery({super.key});

  @override
  State<Recovery> createState() => _RecoveryState();
}

class _RecoveryState extends State<Recovery> {
  static const Color customRed = AppColors.primaryRed;

  // --- Workable State ---
  String selectedFilter = "All Time";
  String selectedStatus = "Full"; // For Heat Map Selectable Text

  final Map<String, Map<String, dynamic>> recoveryData = {
    "Year": {"sets": "780", "rec": 140, "mod": 60, "sore": 30, "crit": 5},
    "Month": {"sets": "65", "rec": 22, "mod": 12, "sore": 5, "crit": 2},
    "Week": {"sets": "15", "rec": 8, "mod": 4, "sore": 2, "crit": 1},
    "All Time": {"sets": "1250", "rec": 450, "mod": 200, "sore": 80, "crit": 15},
  };

  @override
  Widget build(BuildContext context) {
    var current = recoveryData[selectedFilter]!;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 7.h),
              Text(
                "RECOVERY HEATMAP",
                style: GoogleFonts.quattrocento(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                ),
              ),
              SizedBox(height: 15.h),

              _buildFilterTabs(),

              SizedBox(height: 15.h),

              // --- HEAT MAP STATUS CARD ---
              Container(
                padding: EdgeInsets.only(left: 20.w, top: 20.h, bottom: 10.h, right: 10.w),
                decoration: BoxDecoration(
                  color: AppColors.darkBackground,
                  borderRadius: BorderRadius.circular(24.r),
                  border: Border.all(color: Color(0xFF181818),width: 1.5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "HEAT MAP STATUS",
                            style: GoogleFonts.inter(color: Colors.grey, fontSize: 11.sp, fontWeight: FontWeight.w700)
                        ),
                        SizedBox(height: 20.h),
                        ...["Full", "Good", "Mod", "Sore", "High"].map((status) => _buildSelectableStatus(status)),
                      ],
                    ),
                    // Static and Aligned Body Image
                    _buildBodyUI(),
                  ],
                ),
              ),

              SizedBox(height: 15.h),
              _buildSimpleCard("PAST WEEK", current['sets'], "Sets Logged"),
              SizedBox(height: 15.h),

              // --- STATUS BREAKDOWN (SINGLE CONTAINER WITH GRADIENT) ---
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24.r),
                  border: Border.all(color: Color(0xFF181818),width: 1.5),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.white12, Colors.black38, Colors.white12],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // Txt ko left align karne ke liye
                  children: [
                    Text("STATUS BREAKDOWN", style: GoogleFonts.inter(color: Colors.grey, fontSize: 11.sp, fontWeight: FontWeight.w700)),
                    SizedBox(height: 20.h),
                    _buildBreakdownRow("Recovered", current['rec']),
                    _buildBreakdownRow("Moderate", current['mod']),
                    _buildBreakdownRow("Sore", current['sore']),
                    _buildBreakdownRow("Critical", current['crit'], isLast: true),
                  ],
                ),
              ),
              SizedBox(height: 15.h),
            ],
          ),
        ),
      ),
    );
  }

  // --- Selectable Heat Map Labels ---
  Widget _buildSelectableStatus(String status) {
    bool isSelected = selectedStatus == status;
    return GestureDetector(
      onTap: () => setState(() => selectedStatus = status),
      child: Padding(
        padding: EdgeInsets.only(bottom: 12.h),
        child: Row(
          children: [
            Container(
              height: 10.r, width: 10.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? customRed : customRed.withValues(alpha: 0.3),
                boxShadow: isSelected ? [BoxShadow(color: customRed, blurRadius: 4)] : [],
              ),
            ),
            SizedBox(width: 12.w),
            Text(
              status,
              style: GoogleFonts.inter(
                color: isSelected ? Colors.white : Colors.white38,
                fontSize: 13.sp,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Static Body UI ---
  Widget _buildBodyUI() {
    return Container(
      alignment: Alignment.topCenter,
      child: Image.asset(
        "assets/images/finalbody1.png",
        height: 210.h,
        width: 140.w,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _buildBreakdownRow(String label, int count, {bool isLast = false}) {
    return Container(
      margin: EdgeInsets.only(bottom: isLast ? 0 : 6.h),
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 9.h),
      decoration: BoxDecoration(
        color: AppColors.darkBackground,
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Row(
        children: [
          Container(width: 4.w, height: 24.h, decoration: BoxDecoration(color: customRed,
              borderRadius: BorderRadius.circular(10.r))),
          SizedBox(width: 15.w),
          Text(label, style: GoogleFonts.inter(color: Colors.white,
              fontSize: 16.sp, fontWeight: FontWeight.w500)),
          const Spacer(),
          Text(count.toString(),
              style: GoogleFonts.inter(color: customRed, fontSize: 20.sp, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  // --- Rest of the UI Components ---
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
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
        child: Text("System Analysis", style: GoogleFonts.inter(fontSize: 14.sp, color: Colors.white)),
      ),
    );
  }

  Widget _buildFilterTabs() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: ["Year", "Month", "Weak", "All Time"].map((tab) {
        bool active = selectedFilter == (tab == "Weak" ? "Week" : tab);
        return GestureDetector(
          onTap: () => setState(() => selectedFilter = (tab == "Weak" ? "Week" : tab)),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: active ? Colors.transparent : const Color(0xFF1E1E1E),
              borderRadius: BorderRadius.circular(12.r),
              border: active ? Border.all(color: customRed, width: 1.5) : null,
              boxShadow: active ? [BoxShadow(color: customRed.withValues(alpha: 0.3), blurRadius: 8)] : [],
            ),
            child: Text(tab, style: GoogleFonts.inter(color: Colors.white, fontSize: 13.sp)),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSimpleCard(String title, String val, String sub) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(22.w),
      decoration: BoxDecoration(
          color: AppColors.darkBackground,
          borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Color(0xFF181818),width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: GoogleFonts.inter(color: Colors.grey, fontSize: 11.sp, fontWeight: FontWeight.bold)),
          SizedBox(height: 10.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(val, style: GoogleFonts.inter(fontSize: 44.sp, fontWeight: FontWeight.bold, color: customRed)),
              SizedBox(width: 12.w),
              Text(sub, style: GoogleFonts.inter(fontSize: 14.sp, color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }
}