import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iron_log/Screens/Dashboard/work_hub/Exercise/edit_exercise.dart';

import '../../../../Widgets/button.dart';
import '../../../../Widgets/custom_button.dart';
import '../../../../Widgets/custom_paint.dart';
import '../../../../core/theme/app_color.dart';

class CreateExerciseScreen extends StatefulWidget {
  const CreateExerciseScreen({super.key});

  @override
  State<CreateExerciseScreen> createState() => _CreateExerciseScreenState();
}

class _CreateExerciseScreenState extends State<CreateExerciseScreen> {

  final Map<String, List<String>> muscleToExercises = {
    "Chest": ["Bench Press", "Incline Flyes", "Pushups", "Dips"],
    "Back": ["Deadlift", "Pullups", "Lat Pulldown", "Bent Over Row"],
    "Legs": ["Squat", "Leg Press", "Lunges", "Calf Raises"],
    "Shoulders": ["Military Press", "Lateral Raise", "Shrugs"],
    "Arms": ["Bicep Curl", "Tricep Extension", "Hammer Curl"],
  };

  final List<String> equipmentList = ["Barbell", "Dumbbell", "Machine", "Cable", "Kettlebell", "Bodyweight"];

  String selectedMuscle = "Chest";
  String? selectedExercise;
  String selectedEquipment = "Barbell";
  final ScrollController _muscleScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {

    final List<String> sectionTitles = ["Muscle Group", "Exercise Name", "Equipment"];
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
            "New Entry",
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
                "CREATE EXERCISE",
                style: GoogleFonts.quattrocento(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20.h),
              _buildSearchField(),
              SizedBox(height: 25.h),

              // ListView.builder for the 3 cards
              Expanded(
                child: ListView.builder(
                  itemCount: sectionTitles.length,
                  padding: EdgeInsets.only(bottom: 20.h),
                  itemBuilder: (context, index) {
                    String title = sectionTitles[index];

                    return Padding(
                      padding: EdgeInsets.only(bottom: 20.h),
                      child: _buildSectionCard(
                        title: title,
                        index: index,
                        child: _buildCardContent(index),
                      ),
                    );
                  },
                ),
              ),

              // Bottom Buttons (Save & Cancel)
              _buildGradientButton("Save Exercise"),
              Center(
                child: TextButton(
                  onPressed: () => Get.back(),
                  child: Text(
                    "CANCEL",
                    style: GoogleFonts.inter(
                        color: Color(0xFFB1B1B1),
                        fontSize: 12.sp, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper function to return the specific widget for each card index
  Widget _buildCardContent(int index) {
    if (index == 0) {
      // Muscle Group Content
      return Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios, size: 16.sp, color: Colors.grey),
            onPressed: () => _muscleScrollController.animateTo(
                _muscleScrollController.offset - 100,
                duration: const Duration(milliseconds: 300),
                curve: Curves.linear),
          ),
          Expanded(
            child: SizedBox(
              height: 45.h,
              child: ListView(
                controller: _muscleScrollController,
                scrollDirection: Axis.horizontal,
                children: muscleToExercises.keys.map((muscle) {
                  bool isSelected = selectedMuscle == muscle;
                  return GestureDetector(
                    onTap: () => setState(() {
                      selectedMuscle = muscle;
                      selectedExercise = null;
                    }),
                    child: Container(
                      margin: EdgeInsets.only(right: 10.w),
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFF1E1E1E) : Colors.transparent,
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(color: isSelected ? Colors.white24 : Colors.transparent),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        muscle,
                        style: GoogleFonts.inter(
                          color: isSelected ? Colors.white : Colors.grey,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.arrow_forward_ios, size: 16.sp, color: Colors.grey),
            onPressed: () => _muscleScrollController.animateTo(
                _muscleScrollController.offset + 100,
                duration: const Duration(milliseconds: 300),
                curve: Curves.bounceInOut),
          ),
        ],
      );
    } else if (index == 1) {
      // Exercise Name Content
      return _buildDropdownCustom(
        hint: "e.g. Barbell Bench Press....",
        value: selectedExercise,
        items: muscleToExercises[selectedMuscle]!,
        onChanged: (val) => setState(() => selectedExercise = val),
      );
    } else {
      // Equipment Content
      return _buildDropdownCustom(
        hint: "Select Equipment",
        value: selectedEquipment,
        items: equipmentList,
        onChanged: (val) => setState(() => selectedEquipment = val!),
      );
    }
  }

  Widget _buildSearchField() {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF201F1F),
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: TextField(
        style: const TextStyle(color: Colors.white),
        cursorColor: AppColors.primaryRed,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          hintText: "Search movements...",
          hintStyle: GoogleFonts.inter(color: Color(0xFF767575), fontSize: 13.sp),
          prefixIcon: Icon(Icons.search, color: Color(0xFF767575), size: 22.sp),
          suffixIcon: Icon(Icons.menu, color: AppColors.primaryRed, size: 22.sp),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 10.h),
        ),
      ),
    );
  }

  Widget _buildSectionCard({required String title, required Widget child, required int index}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        gradient: index == 0
            ? const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white12,
            Colors.black26,
            Colors.white10,
          ],
        )
            : null,
        color: index != 0 ? const Color(0xFF121212) : null,
        border: index == 0 ? Border.all(color: Colors.white.withValues(alpha: 0.05)) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              title,
              style: GoogleFonts.inter(
                  color: Colors.grey,
                  fontSize: 14.sp
              )
          ),
          SizedBox(height: 15.h),
          child,
        ],
      ),
    );
  }


  Widget _buildDropdownCustom({
    required String hint,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          hint: Text(hint, style: GoogleFonts.inter(color: Colors.grey, fontSize: 14.sp)),
          isExpanded: true,
          dropdownColor: const Color(0xFF1E1E1E),
          icon: Icon(Icons.arrow_drop_down, color: AppColors.primaryRed),
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item, style: GoogleFonts.inter(color: Colors.white)),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildGradientButton(String label) {
    return Button(
      label: 'Save Excercise',
      onTap: () {
        Get.to(EditExerciseScreen());
      },
    );
  }
}