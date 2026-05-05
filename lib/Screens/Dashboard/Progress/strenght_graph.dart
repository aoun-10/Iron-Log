import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../Widgets/custom_button.dart';
import '../../../core/theme/app_color.dart';

class StrengthGraph extends StatefulWidget {
  const StrengthGraph({super.key});

  @override
  State<StrengthGraph> createState() => _StrengthGraphState();
}

class _StrengthGraphState extends State<StrengthGraph> {
  static const Color customRed = AppColors.primaryRed;

  String selectedMonth = "JUL";
  final Map<String, Map<String, dynamic>> monthlyData = {
    "JAN": {"power": "85", "velocity": "+2", "points": [FlSpot(0, 35), FlSpot(1, 60), FlSpot(2, 45)]},
    "FEB": {"power": "90", "velocity": "+3", "points": [FlSpot(0, 40), FlSpot(1, 65), FlSpot(2, 50)]},
    "MAR": {"power": "95", "velocity": "+4", "points": [FlSpot(0, 45), FlSpot(1, 70), FlSpot(2, 55)]},
    "APR": {"power": "98", "velocity": "+4", "points": [FlSpot(0, 50), FlSpot(1, 75), FlSpot(2, 60)]},
    "MAY": {"power": "100", "velocity": "+5", "points": [FlSpot(0, 55), FlSpot(1, 80), FlSpot(2, 65)]},
    "JUN": {"power": "102", "velocity": "+5", "points": [FlSpot(0, 60), FlSpot(1, 85), FlSpot(2, 70)]},
    "JUL": {
      "power": "110",
      "velocity": "+6",
      "points": [
        FlSpot(0, 20),
        FlSpot(1, 35),
        FlSpot(2, 46),
        FlSpot(3, 79),
        FlSpot(4, 95),
        FlSpot(5, 110),
      ]
    },
  };
  @override
  Widget build(BuildContext context) {
    var currentData = monthlyData[selectedMonth]!;
    List<FlSpot> spots = currentData['points'];

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
            "Your Strength Graph",
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView( // Added scroll to prevent overflow on small screens
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.w, 0.h, 20.w, 0.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 7.h),
                Text(
                  "STRENGTH GRAPH",
                  style: GoogleFonts.quattrocento(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20.h),

                Row(
                  children: [
                    Container(width: 12.w, height: 12.h, color: customRed),
                    SizedBox(width: 8.w),
                    Text(
                      "MONTHLY MAX WEIGHT",
                      style: GoogleFonts.inter(color: Colors.white54, fontSize: 10.sp, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),

                SizedBox(height: 20.h),

                // FUNCTIONAL GRAPH
                SizedBox(
                  height: 250.h,
                  width: double.infinity,
                  child: LineChart(
                    LineChartData(
                      lineTouchData: LineTouchData(
                        enabled: false,
                        handleBuiltInTouches: false,
                        touchTooltipData: LineTouchTooltipData(
                          getTooltipColor: (spot) => Colors.transparent,
                          tooltipMargin: 8.h,
                          getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                            return touchedBarSpots.map((barSpot) {
                              return LineTooltipItem(
                                "${barSpot.y.toInt()}KG",
                                GoogleFonts.inter(
                                  color: Colors.white54,
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              );
                            }).toList();
                          },
                        ),
                      ),
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: false,
                        horizontalInterval: 30,
                        getDrawingHorizontalLine: (value) => FlLine(
                          color: Colors.white12,
                          strokeWidth: 1,
                          dashArray: [5, 5],
                        ),
                      ),
                      titlesData: const FlTitlesData(show: false),
                      borderData: FlBorderData(show: false),
                      showingTooltipIndicators: spots.asMap().entries.map((entry) {
                        return ShowingTooltipIndicators([
                          LineBarSpot(LineChartBarData(spots: spots), 0, entry.value),
                        ]);
                      }).toList(),
                      lineBarsData: [
                        LineChartBarData(
                          spots: spots,
                          isCurved: true,
                          curveSmoothness: 0.35,
                          preventCurveOverShooting: true,
                          color: customRed,
                          barWidth: 4.w,
                          isStrokeCapRound: true,
                          dotData: FlDotData(
                            show: true,
                            getDotPainter: (spot, percent, barData, index) =>
                                FlDotCirclePainter(
                                  radius: 3.5.r,
                                  color: Colors.white,
                                  strokeWidth: 0,
                                ),
                          ),
                          belowBarData: BarAreaData(show: false),
                        ),
                      ],
                      minY: 20,
                      maxY: 110,
                    ),
                  ),
                ),

                SizedBox(height: 30.h),

                // MONTH SELECTOR
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: monthlyData.keys.map((month) {
                    bool isSelected = selectedMonth == month;
                    return GestureDetector(
                      onTap: () => setState(() => selectedMonth = month),
                      child: Text(
                        month,
                        style: GoogleFonts.inter(
                          color: isSelected ? customRed : Colors.white,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          fontSize: 12.sp,
                        ),
                      ),
                    );
                  }).toList(),
                ),

                SizedBox(height: 40.h),

                // DYNAMIC CARDS
                Row(
                  children: [
                    Expanded(
                      child: _buildInfoCard("Maximum Power", currentData['power'], "Kg"),
                    ),
                    SizedBox(width: 15.w),
                    Expanded(
                      child: _buildInfoCard("Monthly Velocity", currentData['velocity'], "%", isVelocity: true),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String value, String unit, {bool isVelocity = false}) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.darkBackground,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(color: Colors.white54, fontSize: 12.sp),
          ),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                value,
                style: GoogleFonts.inter(color: Colors.white, fontSize: 24.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 4.w),
              Text(
                unit,
                style: GoogleFonts.inter(color: customRed, fontSize: 12.sp, fontWeight: FontWeight.bold),
              ),
              if (isVelocity) ...[
                SizedBox(width: 10.w),
                // Icon styling to match the red bars in the screenshot
                Icon(Icons.bar_chart, color: customRed, size: 22.sp),
              ]
            ],
          ),
        ],
      ),
    );
  }
}