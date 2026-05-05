import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iron_log/Screens/Dashboard/home_state.dart';
import '../../../../Widgets/button.dart';
import '../../../../Widgets/custom_button.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../Widgets/custom_paint.dart';

class UpgradePlan extends StatefulWidget {
  const UpgradePlan({super.key});

  @override
  State<UpgradePlan> createState() => _UpgradePlanState();
}

class _UpgradePlanState extends State<UpgradePlan> {
  // 0: Free Plan, 1: Monthly, 2: Yearly, 3: Life-Time
  int selectedIndex = 0;

  final List<Map<String, String>> plans = [
    {"title": "Free Plan", "price": ""},
    {"title": "\$4.99", "price": "/ Monthly"},
    {"title": "\$39.99", "price": "/ Year"},
    {"title": "\$79.99", "price": "/ Life-Time"},
  ];

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
            "Maximum Output",
            style: GoogleFonts.inter(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 7.h),
              Text(
                "UPGRADE YOUR PLAN",
                style: GoogleFonts.quattrocento(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20.h),

              // Plans List
              Expanded(
                child: ListView.builder(
                  itemCount: plans.length,
                  itemBuilder: (context, index) {
                    return _buildPlanCard(
                      index,
                      plans[index]['title']!,
                      plans[index]['price']!,
                    );
                  },
                ),
              ),

              // Upgrade Button
              Padding(
                padding: EdgeInsets.only(bottom: 110.h),
                child: Button(
                  label: 'Upgrade Now',
                  onTap: () {
                    Get.to(HomeState(initialIndex: 0,));
                  },
                  height: 65.h,
                )
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlanCard(int index, String title, String price) {
    bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: EdgeInsets.only(bottom: 6.h),
        padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 22.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryRed.withValues(alpha: 0.9) : const Color(0xFF1C1C1E),
          borderRadius: BorderRadius.circular(40.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                if (price.isNotEmpty) SizedBox(width: 5.w),
                if (price.isNotEmpty)
                  Text(
                    price,
                    style: GoogleFonts.inter(
                      fontSize: 10.sp,
                      color: isSelected ? Colors.white70 : Colors.grey,
                    ),
                  ),
              ],
            ),
            Container(
              width: 24.w,
              height: 24.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? Colors.white : Colors.white24,
                  width: 2,
                ),
                color: isSelected ? Colors.white : Colors.transparent,
              ),
              child: isSelected
                  ? Icon(Icons.check, size: 16.sp, color: AppColors.primaryRed)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}