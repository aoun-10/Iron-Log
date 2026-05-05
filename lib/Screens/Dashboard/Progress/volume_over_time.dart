import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../Widgets/custom_button.dart';
import '../../../Widgets/custom_paint.dart';
import '../../../core/theme/app_color.dart';

class VolumeOverTime extends StatefulWidget {
  const VolumeOverTime({super.key});

  @override
  State<VolumeOverTime> createState() => _VolumeOverTimeState();
}

class _VolumeOverTimeState extends State<VolumeOverTime> {
  static const Color customRed = AppColors.primaryRed;

  // Dynamic state values
  String avgWeekly = "12,250";
  String monthlyPeak = "54.2";
  double goalProgress = 0.82; // 82%

  // Mock data for interaction
  final List<Map<String, dynamic>> chartData = [
    {
      "week": "W 24",
      "value": 20.0,
      "avg": "11,500",
      "peak": "50.0",
      "goal": 0.75
    },
    {
      "week": "W 25",
      "value": 25.0,
      "avg": "12,100",
      "peak": "52.5",
      "goal": 0.80
    },
    {
      "week": "W 30",
      "value": 10.0,
      "avg": "10,200",
      "peak": "45.0",
      "goal": 0.65
    },
    {
      "week": "W 35",
      "value": 30.0,
      "avg": "14,500",
      "peak": "60.0",
      "goal": 0.95
    },
    {
      "week": "W 40",
      "value": 20.0,
      "avg": "12,000",
      "peak": "54.0",
      "goal": 0.82
    },
    {
      "week": "W 50",
      "value": 25.0,
      "avg": "13,200",
      "peak": "58.0",
      "goal": 0.88
    },
    {
      "week": "W 55",
      "value": 5.0,
      "avg": "9,800",
      "peak": "40.0",
      "goal": 0.50
    },
  ];
  int selectedBarIndex = 3;

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
                "VOLUME OVER TIME",
                style: GoogleFonts.quattrocento(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 15.h),

              // Top Stat Cards
              Row(
                children: [
                  Expanded(child: _buildTopCard("AVG Weekly", avgWeekly, "Kg")),
                  SizedBox(width: 15.w),
                  Expanded(
                      child: _buildTopCard("Monthly Peak", monthlyPeak, "Kg")),
                ],
              ),
              SizedBox(height: 15.h),

              // Goal Progress Card
              _buildGoalProgressCard(),
              SizedBox(height: 15.h),

              // Main Training Volume Chart Card
              _buildChartCard(),
              SizedBox(height: 15.h),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
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
        child: Text(
          "Analytical Insights",
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildTopCard(String title, String value, String unit) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.darkBackground,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(title,
              style: GoogleFonts.inter(color: Colors.white54, fontSize: 13.sp)),
          SizedBox(height: 12.h),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: value,
                  style: GoogleFonts.inter(fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                TextSpan(
                  text: " $unit",
                  style: GoogleFonts.inter(fontSize: 12.sp,
                      color: customRed,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGoalProgressCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.darkBackground,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Current Goal Progress",
              style: GoogleFonts.inter(color: Colors.white54, fontSize: 13.sp)),
          SizedBox(height: 15.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${(goalProgress * 100).toInt()}%",
                style: GoogleFonts.inter(fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                    color: customRed),
              ),
              SizedBox(
                width: 150.w,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: LinearProgressIndicator(
                    value: goalProgress,
                    backgroundColor: Colors.white12,
                    color: customRed,
                    minHeight: 6.h,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChartCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.darkBackground,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Training Volume",
                      style: GoogleFonts.inter(color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold)),
                  Text("Last 12 weeks of activity",
                      style: GoogleFonts.inter(
                          color: Colors.white38, fontSize: 12.sp)),
                ],
              ),
              Text("VOLUME IN KG",
                  style: GoogleFonts.inter(color: customRed,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(height: 40.h),
          SizedBox(
            height: 200.h,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 35,
                // Background lines ke liye range wahi hai
                barTouchData: BarTouchData(
                  touchCallback: (FlTouchEvent event, barResponse) {
                    if (!event.isInterestedForInteractions ||
                        barResponse == null || barResponse.spot == null) return;
                    setState(() {
                      selectedBarIndex = barResponse.spot!.touchedBarGroupIndex;
                      var data = chartData[selectedBarIndex];
                      avgWeekly = data['avg'];
                      monthlyPeak = data['peak'];
                      goalProgress = data['goal'];
                    });
                  },
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipColor: (group) => Colors.transparent,
                  ),
                ),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 35.w,
                      getTitlesWidget: (value, meta) {
                        // 35KG ko remove karne ke liye condition
                        if (value % 5 == 0 && value != 0 && value < 35) {
                          return Text("${value.toInt()}KG",
                              style: GoogleFonts.inter(
                                  color: Colors.white38, fontSize: 9.sp));
                        }
                        return const SizedBox();
                      },
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        int index = value.toInt();
                        if (index >= 0 && index < chartData.length) {
                          return Padding(
                            padding: EdgeInsets.only(top: 8.h),
                            child: Text(chartData[index]['week'],
                                style: GoogleFonts.inter(
                                  // Selected week ka text bhi thora bright ho jaye
                                  color: selectedBarIndex == index ? Colors
                                      .white : Colors.white38,
                                  fontSize: 10.sp,
                                  fontWeight: selectedBarIndex == index
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                )),
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                  ),
                  rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                ),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  getDrawingHorizontalLine: (value) =>
                      FlLine(
                          color: Colors.white10,
                          strokeWidth: 1,
                          dashArray: [5, 5]
                      ),
                ),
                borderData: FlBorderData(show: false),
                barGroups: chartData
                    .asMap()
                    .entries
                    .map((e) {
                  int index = e.key;
                  bool isSelected = selectedBarIndex == index;

                  return BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(
                        toY: e.value['value'],
                        // Selected: Dark Red | Unselected: Light Grey/White
                        color: isSelected ? customRed : Colors.red.withValues(alpha: 0.1),
                        width: 22.w,
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}