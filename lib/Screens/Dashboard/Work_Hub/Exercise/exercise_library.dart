import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iron_log/Screens/Dashboard/work_hub/Exercise/create_exercise.dart';

import '../../../../Widgets/button.dart';
import '../../../../Widgets/custom_button.dart';
import '../../../../Widgets/custom_paint.dart';
import '../../../../core/theme/app_color.dart';

class ExerciseLibraryScreen extends StatefulWidget {
  const ExerciseLibraryScreen({super.key});

  @override
  State<ExerciseLibraryScreen> createState() => _ExerciseLibraryScreenState();
}

class _ExerciseLibraryScreenState extends State<ExerciseLibraryScreen> {
  // Default Data
  final List<Exercise> allExercises = [
    Exercise(title: "Bench Press", category: "Chest", equipment: "Barbell,Flat Bench", record: "120kg"),
    Exercise(title: "Squat", category: "Legs", equipment: "Barbell,High Bar", record: "165kg"),
    Exercise(title: "Deadlift", category: "Back", equipment: "Barbell,Conventional", record: "210kg"),
    Exercise(title: "Shoulder Press", category: "Shoulders", equipment: "Dumbbell,Seated", record: "45kg"),
  ];

  List<Exercise> displayedExercises = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    displayedExercises = allExercises;
  }

  void _filterExercises(String query) {
    setState(() {
      displayedExercises = allExercises
          .where((exercise) =>
      exercise.title.toLowerCase().contains(query.toLowerCase()) ||
          exercise.category.toLowerCase().contains(query.toLowerCase()))
          .toList();
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
            "Performance Lab",
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
          padding: EdgeInsets.fromLTRB(20.w,0.h, 20.w, 0.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 7.h),
              Text(
                "EXERCISE LIBRARY",
                style: GoogleFonts.quattrocento(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20.h),
              // Workable Search Field
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFF201F1F),
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: _filterExercises,
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
              ),
              SizedBox(height: 20.h),
              // Exercise List
              Expanded(
                child: ListView.builder(
                  itemCount: displayedExercises.length,
                  itemBuilder: (context, index) {
                    final item = displayedExercises[index];
                    return _buildExerciseCard(item);
                  },
                ),
              ),
              // Bottom Action Button
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child:
                Button(
                  label: 'Create Excercise +',
                  onTap: () {
                    Get.to(CreateExerciseScreen());
                  },)
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExerciseCard(Exercise exercise) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.h),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF201F1F),
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                exercise.category,
                style: GoogleFonts.inter(color: AppColors.primaryRed, fontSize: 12.sp),
              ),
              SizedBox(height: 4.h),
              Text(
                exercise.title,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                exercise.equipment,
                style: GoogleFonts.inter(color: Color(0xFF767575), fontSize: 13.sp),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(height: 15.h),
              Text(
                exercise.record,
                style: GoogleFonts.inter(
                  color: AppColors.primaryRed,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                "Personal Record",
                style: GoogleFonts.inter(color: Color(0xFF767575), fontSize: 10.sp),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
class Exercise {
  final String title;
  final String category;
  final String equipment;
  final String record;

  Exercise({
    required this.title,
    required this.category,
    required this.equipment,
    required this.record,
  });
}
