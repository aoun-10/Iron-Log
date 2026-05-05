import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:iron_log/Screens/Dashboard/Calender/workout_detail.dart';
import 'package:iron_log/Widgets/custom_button.dart';

class CalenderScreen extends StatefulWidget {
  const CalenderScreen({super.key});

  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {

  DateTime _selectedDate = DateTime.now();

  // Fake data for workout dots
  final List<int> _workoutDays = [1, 3, 5, 10, 15, 20, 22, 25, 28];

  void _changeMonth(int add) {
    setState(() {
      _selectedDate = DateTime(_selectedDate.year, _selectedDate.month + add);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 70.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Text(
                "CALENDAR",
                style: GoogleFonts.quattrocento(
                  color: Colors.white,
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30.h),

              // Month Selector with Navigation
              _buildMonthSelector(),
              SizedBox(height: 20.h),

              // Calendar Grid (The working part)
              _buildCalendarGrid(),

              SizedBox(height: 20.h),
              _buildConsistencyCard(),
              SizedBox(height: 25.h),

              InkWell(
                onTap: (){
                  Get.to(WorkoutDetail());
                },
                child: Text(
                  "View Workout Detail",
                  style: GoogleFonts.inter(
                    color: const Color(0xFFA90000),
                    fontSize: 14.sp,
                    decoration: TextDecoration.underline,
                    decorationColor: Color(0xFFA90000),
                    decorationThickness: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMonthSelector() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Color(0xFF181818),
        borderRadius: BorderRadius.circular(40.r),
        border: Border.all(color: Color(0xFF181818),width: 1.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          _navButton(Icons.arrow_back_ios_new, () => _changeMonth(-1)),
          Text(
            DateFormat('MMMM yyyy').format(_selectedDate),
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          _navButton(Icons.arrow_forward_ios, () => _changeMonth(1)),
        ],
      ),
    );
  }

  Widget _navButton(IconData icon, VoidCallback onTap) {
    return CustomButton(
        onTap: onTap,
      icon: icon,
    );
  }

  Widget _buildCalendarGrid() {
    // Logic to calculate days
    final firstDayOfMonth = DateTime(_selectedDate.year, _selectedDate.month, 1);
    final lastDayOfMonth = DateTime(_selectedDate.year, _selectedDate.month + 1, 0);

    // Monday se start karne ke liye adjustment (1 = Mon, 7 = Sun)
    int firstWeekday = firstDayOfMonth.weekday;
    final prevMonthLastDay = DateTime(_selectedDate.year, _selectedDate.month, 0).day;

    final List<String> weekDays = ["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"];

    return Container(
      padding: EdgeInsets.only(top: 16.h,left: 16.w,right: 16.w),
      decoration: BoxDecoration(
        color: Color(0xFF181818),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Color(0xFF181818),width: 1.5),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: weekDays.map((day) => Text(
              day,
              style: GoogleFonts.inter(color: Colors.grey,
                  fontSize: 10.sp, fontWeight: FontWeight.bold),
            )).toList(),
          ),
          SizedBox(height: 20.h),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 10,
              crossAxisSpacing: 5,
            ),
            itemCount: 35, // 6 weeks to cover all months
            itemBuilder: (context, index) {
              int dayDisplay;
              bool isCurrentMonth = false;

              // Previous Month Days (Grey dates)
              if (index < firstWeekday - 1) {
                dayDisplay = prevMonthLastDay - (firstWeekday - 2 - index);
              }
              // Current Month Days
              else if (index < firstWeekday - 1 + lastDayOfMonth.day) {
                dayDisplay = index - (firstWeekday - 2);
                isCurrentMonth = true;
              }
              // Next Month Days (Grey dates)
              else {
                dayDisplay = index - (firstWeekday - 2 + lastDayOfMonth.day);
              }

              // Highlight logic
              bool hasWorkout = isCurrentMonth && _workoutDays.contains(dayDisplay);
              bool isToday = isCurrentMonth &&
                  dayDisplay == DateTime.now().day &&
                  _selectedDate.month == DateTime.now().month;

              return Column(
                children: [
                  Text(
                    dayDisplay.toString(),
                    style: GoogleFonts.inter(
                      color: isToday
                          ? const Color(0xFFA90000)
                          : (isCurrentMonth ? Colors.white : Colors.grey.withValues(alpha: 0.4)),
                      fontSize: 16.sp,
                      fontWeight: isCurrentMonth ? FontWeight.w500 : FontWeight.w300,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  if (hasWorkout)
                    Container(
                      width: 4.w,
                      height: 4.w,
                      decoration: const BoxDecoration(
                        color: Color(0xFFA90000),
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildConsistencyCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
          color: Color(0xFF181818),
        borderRadius: BorderRadius.circular(40.r),
        border: Border.all(color: Color(0xFF181818),width: 1.5),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("MONTHLY CONSISTENCY", style: GoogleFonts.inter(color: Colors.grey, fontSize: 12.sp)),
              Text("84%", style: GoogleFonts.inter(color: const Color(0xFFA90000), fontSize: 14.sp, fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(height: 15.h),
          LinearProgressIndicator(
            value: 0.84,
            backgroundColor: Colors.white10,
            color: const Color(0xFFA90000),
            minHeight: 6.h,
            borderRadius: BorderRadius.circular(10.r),
          ),
        ],
      ),
    );
  }
}