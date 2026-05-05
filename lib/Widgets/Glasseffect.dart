import 'dart:ui'; // ImageFilter ke liye zaroori hai
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomGlassContainer extends StatelessWidget {
  final Widget child;
  final double? height;
  final double? width;
  final double borderRadius;

  const CustomGlassContainer({
    super.key,
    required this.child,
    this.height,
    this.width,
    this.borderRadius = 40.0, // Default roundness
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius.r),
      child: BackdropFilter(
        // Frost effect (sigma 4 matches your Figma settings)
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: Container(
          height: 54.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius.r),
            // Glass ki edge (Refraction effect)
            // border: Border.all(
            //   color: Colors.white.withOpacity(0.2),
            //   width: 1.5.w,
            // ),
            // Light source -45 degree (Top-Left to Bottom-Right)
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withOpacity(0.5), // Subtle light highlight
                Colors.white.withOpacity(0.5), // Very transparent base
              ],
              stops: const [0.0, 0.6],
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}