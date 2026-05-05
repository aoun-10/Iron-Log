import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iron_log/Widgets/custom_paint.dart';

import '../../../Widgets/button.dart';
import '../../../Widgets/custom_button.dart';
import '../../../core/theme/app_color.dart';

class RmCalculator extends StatefulWidget {
  const RmCalculator({super.key});

  @override
  State<RmCalculator> createState() => _RmCalculatorState();
}

class _RmCalculatorState extends State<RmCalculator> {
  final TextEditingController _weightController = TextEditingController(text: "100");
  final TextEditingController _repsController = TextEditingController(text: "5");

  double _oneRmResult = 116.7;
  final double _maxGoal = 300.0; // Is value par progress bar 100% fill hogi

  void _calculateMax() {
    double weight = double.tryParse(_weightController.text) ?? 0;
    int reps = int.tryParse(_repsController.text) ?? 0;

    if (weight > 0 && reps > 0) {
      setState(() {
        // Epley Formula implementation
        _oneRmResult = weight * (1 + (reps / 30));
      });
    }
  }

  void _updateWeight(int delta) {
    int current = int.tryParse(_weightController.text) ?? 0;
    if (current + delta >= 0) {
      setState(() {
        _weightController.text = (current + delta).toString();
      });
    }
  }

  void _updateReps(int delta) {
    int current = int.tryParse(_repsController.text) ?? 0;
    if (current + delta >= 0) {
      setState(() {
        _repsController.text = (current + delta).toString();
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
        leading: _buildBackButton(),
        title: Padding(
          padding: EdgeInsets.only(top: 15.h),
          child: Text(
            "Calculate Your Strength",
            style: GoogleFonts.inter(
              fontSize: 12.sp,
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
                "1RM CALCULATOR",
                style: GoogleFonts.quattrocento(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 25.h),

              // Input Card
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: AppColors.darkBackground,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Column(
                  children: [
                    _buildInputSection("WEIGHT (KG)", _weightController, _updateWeight),
                    SizedBox(height: 20.h),
                    _buildInputSection("REPS", _repsController, _updateReps),
                    SizedBox(height: 30.h),

                    // Calculate Button
                    Opacity(
                      opacity: 0.7,
                      child: Button(
                        label: 'Calculate Max',
                        onTap: _calculateMax,
                        height: 55.h,
                        width: 260.w,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20.h),

              // Result Card with Functional Red Line
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(25.w),
                decoration: BoxDecoration(
                  color: AppColors.darkBackground,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "ESTIMATED CALCULATION",
                      style: GoogleFonts.inter(
                        color: AppColors.primaryRed,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          _oneRmResult.toStringAsFixed(1),
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 48.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          "KG",
                          style: GoogleFonts.inter(
                            color: Colors.grey,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15.h),

                    // Functional Progress Bar
                    Stack(
                      children: [
                        Container(
                          height: 4.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 600),
                          curve: Curves.easeOutCubic,
                          height: 4.h,
                          // Percentage calculation logic
                          width: (_oneRmResult / _maxGoal).clamp(0.0, 1.0) * (MediaQuery.of(context).size.width - 90.w),
                          decoration: BoxDecoration(
                              color: AppColors.primaryRed,
                              borderRadius: BorderRadius.circular(2),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primaryRed.withValues(alpha: 0.4),
                                  blurRadius: 4,
                                )
                              ]
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputSection(String label, TextEditingController controller, Function(int) onUpdate) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: Colors.grey.shade500,
            fontSize: 12.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          height: 50.h,
          width: 280.w,
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  cursorColor: AppColors.primaryRed,
                  cursorHeight: 20,
                  keyboardType: TextInputType.number,
                  style: GoogleFonts.inter(color: Colors.white, fontSize: 20.sp),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                  ),
                  onChanged: (val) => setState(() {}),
                ),
              ),
              _buildRoundButton(Icons.remove, () => onUpdate(-1)),
              SizedBox(width: 9.w),
              _buildRoundButton(Icons.add, () => onUpdate(1)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRoundButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 30.w,
        height: 27.h,
        padding: EdgeInsets.all(6.w),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Center(child: Icon(icon, color: AppColors.primaryRed, size: 18.sp)),
      ),
    );
  }

  Widget _buildBackButton() {
    return Padding(
      padding: EdgeInsets.only(left: 20.w, top: 10.h),
      child: CustomButton(
        onTap: (){
          Get.back();
        },),
    );
  }
}