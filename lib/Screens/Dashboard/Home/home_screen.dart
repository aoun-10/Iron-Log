import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iron_log/Screens/Dashboard/Home/Upgrade/upgrade.dart';
import 'package:iron_log/Screens/Dashboard/Home/notification_screen.dart';
import 'package:iron_log/Screens/Dashboard/Home/Profile_Screen/profile_screen.dart';
import 'package:iron_log/core/theme/app_color.dart';
import '../../../Widgets/button.dart';
import '../../../Widgets/custom_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBody: true,

      // AppBar
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        toolbarHeight: 80.h,
        leadingWidth: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            // Avatar
            GestureDetector(
              onTap: (){
                Get.to(ProfileScreen());
              },
              child: Container(
                width: 44.w,
                height: 44.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: const DecorationImage(
                    image: AssetImage('assets/images/Onboarding1.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: (){
                    Get.to(ProfileScreen());
                  },
                  child: Text(
                    'Welcome Bravo',
                    style: GoogleFonts.quattrocento(
                      fontSize: 23.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
                Text(
                  'Ready to log your workout.',
                  style: GoogleFonts.inter(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const Spacer(),
            CustomButton(
              icon: Icons.notifications,
              onTap: () {
                Get.to(NotificationScreen());
              },
            )
          ],
        ),
      ),
      // Body
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 70.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Push the Limits
            Text(
              'PUSH THE LIMITS',
              style: GoogleFonts.quattrocento(
                fontSize: 28.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),

            SizedBox(height: 10.h),

            // Start Workout Button
            Button(
              label: 'Start Workout',
              icon: Icons.play_arrow_rounded,
              onTap: () {
                Get.to(Upgrade());
              },
              width: 335.w,
              height: 56.h,
              imagePath: "assets/images/Button2.png",
            ),
            SizedBox(height: 15.h),

            // Today's Focus Card
            LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      width: 320.w,
                      height: 233.h,
                      padding: EdgeInsets.all(18.w),
                      decoration: BoxDecoration(
                        //color: const Color(0xFF111111),
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(color: Color(0xFF181818),width: 1.5),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF535050).withValues(alpha: 0.5),
                            Color(0xFF201F1F).withValues(alpha: 0.5),
                            Color(0xFF868282).withValues(alpha: 0.3),
                          ],
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Today’s Focus",
                            style: GoogleFonts.quattrocento(
                              fontSize: 23.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 14.h),

                          Wrap(
                            spacing: 40.w,
                            runSpacing: 10.h,
                            children: [
                              _buildFocusStat('Estimated Time', '75 ', 'MIN'),
                              _buildFocusStat('Target Volume', '12.4 ', 'K LBS'),
                            ],
                          ),
                          SizedBox(height: 16.h),
                          const Divider(color: Colors.white12, thickness: 1),
                          SizedBox(height: 12.h),
                          // Exercises list ko scrollable banaya hai taake screen width se bahar na nikal jaye
                          Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              child: Row(
                                children: [
                                  'Bench Press',
                                  'Shoulder Press',
                                  'Incline Flyes',
                                ].map((exercise) => Container(
                                  width: 87.w,
                                  height: 45.h,
                                  margin: EdgeInsets.only(right: 6.w),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 4.w,
                                    vertical: 5.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.darkBackground,
                                    borderRadius: BorderRadius.circular(12.r),
                                    border: Border.all(
                                      color: Colors.white12,
                                      width: 1,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      exercise,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.inter(
                                        fontSize: 9.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                )).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
            ),

            SizedBox(height: 20.h),

            // Recent PR Card
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFF181818),width: 1.5),
                borderRadius: BorderRadius.circular(17.r),
              ),
              width: 333.w,
              height: 188.h,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: Stack(
                  children: [
                    // Background image
                    SizedBox(
                      width: double.infinity,
                      height: 200.h,
                      child: Image.asset(
                        'assets/images/homepng.png',
                        fit: BoxFit.cover,
                        //color: Colors.black.withValues(alpha: 0.55),
                        colorBlendMode: BlendMode.darken,
                      ),
                    ),
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          // 1. BoxShadow (Figma: Blur 10, Spread 0, Color 25%, X:0, Y:0)
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF000000).withOpacity(0.25),
                              blurRadius: 10,
                              spreadRadius: 0,
                              offset: const Offset(0, 0),
                            ),
                          ],
                          // 2. Linear Gradient (#202020 aur #000000)
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              const Color(0xFF202020).withOpacity(0.4), // Top Color
                              const Color(0xFF000000).withOpacity(0.4), // Bottom Color
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Red left border
                    Positioned(
                      left: 0,
                      top: 0,
                      bottom: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.primaryRed,
                          border: Border.all(color: Color(0xFF181818),width: 0.3),
                        ),
                        width: 6.w,
                      ),
                    ),
                    // Content
                    Positioned.fill(
                      child: Padding(
                        padding: EdgeInsets.all(16.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.emoji_events_rounded,
                              color: AppColors.primaryRed,
                              size: 20.sp,
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              'Recent PR',
                              style: GoogleFonts.inter(
                                fontSize: 11.sp,
                                color: Colors.white60,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              'DEADLIFT',
                              style: GoogleFonts.quattrocento(
                                fontSize: 22.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: 1,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: '405 ',
                                    style: GoogleFonts.quattrocento(
                                      fontSize: 28.sp,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'LBS',
                                    style: GoogleFonts.inter(
                                      fontSize: 11.sp,
                                      color:AppColors.primaryRed,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              'Achieved 2 days ago',
                              style: GoogleFonts.inter(
                                fontSize: 10.sp,
                                color: AppColors.primaryRed,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 22.h),

            // Weekly Output
            Text(
              'Weekly Output',
              style: GoogleFonts.quattrocento(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),

            SizedBox(height: 14.h),

            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Color(0xFF111111),
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: Color(0xFF181818),width: 1.5),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF535050).withValues(alpha: 0.5),
                    Color(0xFF201F1F).withValues(alpha: 0.5),
                    Color(0xFF868282).withValues(alpha: 0.3),
                  ],
                ),
              ),
              child: Column(
                children: [
                  // Bar chart
                  SizedBox(
                    height: 160.h,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _BarItem(label: 'M', heightFactor: 0.20, isActive: false),
                        _BarItem(label: 'T', heightFactor: 0.30, isActive: false),
                        _BarItem(label: 'W', heightFactor: 0.45, isActive: false),
                        _BarItem(label: 'T', heightFactor: 1.0,  isActive: true),
                        _BarItem(label: 'F', heightFactor: 0.55, isActive: false),
                        _BarItem(label: 'S', heightFactor: 0.25, isActive: false),
                        _BarItem(label: 'S', heightFactor: 0.40, isActive: false),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.h),
                  Row(
                    children: [
                      Container(
                        width: 12.w,
                        height: 12.h,
                        decoration: BoxDecoration(
                          color: AppColors.primaryRed,
                          borderRadius: BorderRadius.circular(3.r),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        'Active Week',
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          color: Colors.white54,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '9.2 Hours Total',
                        style: GoogleFonts.quattrocento(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
Widget _buildFocusStat(String label, String value, String unit) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 13.sp,
          color: const Color(0xFFB1B1B1),
        ),
      ),
      SizedBox(height: 12.h),
      RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: value,
              style: GoogleFonts.inter(
                fontSize: 26.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            TextSpan(
              text: unit,
              style: GoogleFonts.inter(
                fontSize: 11.sp,
                color: AppColors.primaryRed,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

// Bar chart item
class _BarItem extends StatelessWidget {
  final String label;
  final double heightFactor;
  final bool isActive;

  const _BarItem({
    required this.label,
    required this.heightFactor,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (isActive)
          Padding(
            padding: EdgeInsets.only(bottom: 4.h),
            child: Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 10.sp,
                color: AppColors.primaryRed,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        if (!isActive)
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 10.sp,
            color: Colors.white38,
          ),
        ),
        Container(
          width: 35.w,
          height: 130.h * heightFactor,
          decoration: BoxDecoration(
            color: isActive
                ? AppColors.primaryRed
                : Color(0xFF2A2A2A),
            //borderRadius: BorderRadius.circular(6.r),
          ),
        ),
        SizedBox(height: 6.h),
      ],
    );
  }
}
