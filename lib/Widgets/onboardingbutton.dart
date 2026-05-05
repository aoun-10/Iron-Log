import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Onboardingbutton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final String imagePath;
  final double iconSize;
  final Color iconColor;

  const Onboardingbutton({
    super.key,
    this.icon = Icons.arrow_back_rounded,
    required this.onTap,
    this.imagePath = 'assets/images/Onboardingbutton.png',
    this.iconSize = 18,
    this.iconColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 46.w,
        height: 46.h,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.contain,
          ),
        ),
        child: Center(
          child: Icon(
            icon,
            color: iconColor,
            size: 24.sp,
          ),
        ),
      ),
    );
  }
}