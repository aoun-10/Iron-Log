import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iron_log/Screens/Dashboard/home_state.dart';

import '../../../../Widgets/button.dart';
import '../../../../Widgets/custom_button.dart';
import '../../../../Widgets/custom_paint.dart';
import '../../../../core/theme/app_color.dart';

class CreateRoutine extends StatefulWidget {
  const CreateRoutine({super.key});

  @override
  State<CreateRoutine> createState() => _CreateRoutineState();
}

class _CreateRoutineState extends State<CreateRoutine> {
  // Logic Variables
  String selectedExercise = "e.g. Barbell Bench Press....";
  String selectedWeight = "100";
  String selectedReps = "09";
  String selectedSets = "10";

  final Color customRed = AppColors.primaryRed;

  // Gradient for containers
  final LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Colors.white24,
      Colors.black26,
      Colors.white24
    ],
  );

  // Dummy Data for Dropdowns
  final List<String> exercises = ["BARBELL BENCH PRESS", "INCLINED DUMBBLE", "DEADLIFT", "SQUATS"];
  final List<String> weights = ["60", "80", "100", "120", "140"];
  final List<String> counts = List.generate(20, (index) => (index + 1).toString().padLeft(2, '0'));

  @override
  Widget build(BuildContext context) {
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
                "CREATE ROUTINE",
                style: GoogleFonts.quattrocento(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 15.h),

              // Main Input Container
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  gradient: cardGradient,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLabel("Exercise Name"),
                    _buildExerciseDropdown(),
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        Expanded(child: _buildValueSelector("Weight (kg)", selectedWeight, weights, (v) => setState(() => selectedWeight = v!))),
                        SizedBox(width: 10.w),
                        Expanded(child: _buildValueSelector("Reps", selectedReps, counts, (v) => setState(() => selectedReps = v!))),
                        SizedBox(width: 10.w),
                        Expanded(child: _buildValueSelector("Sets", selectedSets, counts, (v) => setState(() => selectedSets = v!))),
                      ],
                    )
                  ],
                ),
              ),

              SizedBox(height: 15.h),
              Text(
                "Suggested Workout",
                style: GoogleFonts.quattrocento(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 15.h),

              // Suggested List
              _buildSuggestedCard("BARBELL BENCH PRESS", "COMPOUND • BARBELL", "assets/images/Create_Routine1.png"),
              _buildSuggestedCard("INCLINED DUMBBLE", "COMPOUND • BARBELL", "assets/images/Create_routine2.png"),
              _buildSuggestedCard("DEADLIFT", "COMPOUND • BARBELL", "assets/images/Create_routine3.png"),

              SizedBox(height: 10.h),

              // Save Button
              Button(
                label: "Save Routine",
                onTap: (){
                  Get.to(HomeState(initialIndex: 1,));
                },
              ),
              SizedBox(height: 10.h),
            ],
          ),
        ),
      ),
    );
  }

  // --- Sub-Widgets ---

  Widget _buildLabel(String text) => Padding(
    padding: EdgeInsets.only(bottom: 8.h, left: 5.w),
    child: Text(text, style: GoogleFonts.inter(color: Colors.white70, fontSize: 13.sp)),
  );

  Widget _buildExerciseDropdown() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      decoration: BoxDecoration(color: Color(0xFF201F1F),
          borderRadius: BorderRadius.circular(12.r)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: exercises.contains(selectedExercise) ? selectedExercise : null,
          hint: Text(selectedExercise, style: GoogleFonts.inter(color: Color(0xFF767575), fontSize: 14.sp)),
          isExpanded: true,
          icon: Icon(Icons.arrow_drop_down, color: customRed),
          dropdownColor: Color(0xFF201F1F),
          items: exercises.map((e) => DropdownMenuItem(value: e, child: Text(e, style: TextStyle(fontSize: 14.sp,color: Color(0xFF767575))))).toList(),
          onChanged: (val) => setState(() => selectedExercise = val!),
        ),
      ),
    );
  }

  Widget _buildValueSelector(String label, String value, List<String> list, ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildLabel(label),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          decoration: BoxDecoration(color: Color(0xFF201F1F), borderRadius: BorderRadius.circular(12.r)),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              icon: Icon(Icons.arrow_drop_down, color: customRed),
              dropdownColor: Color(0xFF201F1F),
              items: list.map((e) => DropdownMenuItem(value: e, child: Text(e, style: TextStyle(fontSize: 14.sp,color: Color(0xFF767575))))).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSuggestedCard(String title, String subtitle, String imgUrl) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedExercise = title;
        });
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 6.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r), color: Color(0xFF201F1F)),
        child: Row(
          children: [
            CircleAvatar(radius: 25.r, backgroundImage: AssetImage(imgUrl)),
            SizedBox(width: 15.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: GoogleFonts.quattrocento(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Colors.white)),
                  Text(subtitle, style: GoogleFonts.inter(fontSize: 11.sp, color: Colors.white38)),
                ],
              ),
            ),
            CustomButton(
              onTap: (){},
              icon: Icons.add,
              size: 14.sp,
              height: 23.h,
              width: 23.w,
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
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
          "Create Your New Routine",
          style: GoogleFonts.inter(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}