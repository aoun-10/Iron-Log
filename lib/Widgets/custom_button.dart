import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final IconData icon;
  final double size;
  final VoidCallback onTap;
  final String imagePath;
  final double width;
  final double height;

  const CustomButton({
    super.key,
    this.icon = Icons.arrow_back_ios_new,
    required this.onTap,
    this.imagePath = 'assets/images/backbutton.png',
    // Default values yahan set kar di hain
    this.width = 45,
    this.height = 45,
    this.size = 20,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width.w,
        height: height.h,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.contain,
          ),
        ),
        child: Center(
          child: Icon(
            icon,
            color: Colors.white,
            size: size.sp,
          ),
        ),
      ),
    );
  }
}