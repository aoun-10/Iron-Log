import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../Widgets/button.dart';
import '../../../../Widgets/custom_button.dart';
import '../../../../Widgets/custom_paint.dart';
import '../../../../core/theme/app_color.dart';

class BlockBuilderScreen extends StatefulWidget {
  const BlockBuilderScreen({super.key});

  @override
  State<BlockBuilderScreen> createState() => _BlockBuilderScreenState();
}

class _BlockBuilderScreenState extends State<BlockBuilderScreen> {
  int numberOfWeeks = 4;
  List<String> phaseNames = ["Hypertrophy", "Strength", "Heavy", "Deload"];
  final List<String> options = ["Hypertrophy", "Strength", "Heavy", "Deload"];

  void _increment() {
    setState(() {
      numberOfWeeks++;
      phaseNames.add("Hypertrophy");
    });
  }

  void _decrement() {
    if (numberOfWeeks > 1) {
      setState(() {
        numberOfWeeks--;
        phaseNames.removeLast();
      });
    }
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
            "Create Your Training Plan",
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
              "BLOCK BUILDER",
              style: GoogleFonts.quattrocento(
                fontSize: 28.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 15.h),

            // Week Selector Card
            _buildWeekCounterCard(),

            SizedBox(height: 25.h),
            Text(
              "PHASE ALLOCATION",
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
                letterSpacing: 1.0,
              ),
            ),
            SizedBox(height: 15.h),

            // Scrollable List of Weeks
            Expanded(
              child: ListView.builder(
                itemCount: numberOfWeeks,
                itemBuilder: (context, index) {
                  return _buildPhaseCard(index);
                },
              ),
            ),

            // Save Button
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: Button(
                label: 'Save Plan',
                onTap: () {
                  Get.back();
                },),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeekCounterCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1C),
        borderRadius: BorderRadius.circular(15.r),
        border: Border(
          left: BorderSide(color: AppColors.primaryRed, width: 5.w),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "NUMBER OF WEEKS",
                style: GoogleFonts.inter(
                  fontSize: 10.sp,
                  color: AppColors.primaryRed,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                numberOfWeeks.toString().padLeft(2, '0'),
                style: GoogleFonts.inter(
                  fontSize: 40.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Row(
            children: [
              _circleButton(Icons.remove, _decrement),
              SizedBox(width: 15.w),
              _circleButton(Icons.add, _increment),
            ],
          )
        ],
      ),
    );
  }

  Widget _circleButton(IconData icon, VoidCallback onTap) {
    return CustomButton(
      onTap: onTap,
      icon: icon,
  );
}

  Widget _buildPhaseCard(int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.h),
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1C),
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text((index + 1).toString().padLeft(2, '0'),
                      style: GoogleFonts.inter(color: AppColors.primaryRed, fontWeight: FontWeight.bold)),
                  SizedBox(width: 10.w),
                  Text("Week ${(index + 1).toString().padLeft(2, '0')}",
                      style: GoogleFonts.inter(color: Colors.grey, fontSize: 12.sp)),
                ],
              ),
              const Icon(Icons.drag_handle, color: AppColors.primaryRed, size: 20),
            ],
          ),
          SizedBox(height: 10.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: phaseNames[index],
                dropdownColor: Colors.black,
                icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
                isExpanded: true,
                style: GoogleFonts.inter(color: Colors.white, fontSize: 14.sp),
                items: options.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    phaseNames[index] = newValue!;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}