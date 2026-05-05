// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// class CustomBottomNavBar extends StatefulWidget {
//   final int currentIndex;
//   final Function(int) onTap;
//
//   const CustomBottomNavBar({
//     super.key,
//     required this.currentIndex,
//     required this.onTap,
//   });
//
//   static const List<IconData> _icons = [
//     Icons.home_filled,            // Home
//     Icons.fitness_center_rounded, // Workout
//     Icons.bar_chart_rounded,   // Stats
//     Icons.calendar_today_rounded, // Calendar
//     Icons.settings_outlined,       // Settings
//   ];
//
//   @override
//   State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
// }
//
// class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(left: 40.w, right: 40.w, bottom: 12.h),
//       child: SizedBox(
//         height: 48.h,
//         child: Row(
//           children: [
//             // 1. Red Selected Circle (Left Side)
//             AnimatedContainer(
//               duration: const Duration(milliseconds: 300),
//               width: 60.w,
//               height: 60.w,
//               decoration: const BoxDecoration(
//                 color: Color(0xFFA90000), // Dark Red color
//                 shape: BoxShape.circle,
//               ),
//               child: Icon(
//                 CustomBottomNavBar._icons[widget.currentIndex],
//                 color: Colors.white,
//                 size: 28.sp,
//               ),
//             ),
//
//             SizedBox(width: 2.w), // Gap between circle and bar
//
//             // White Capsule Bar (Remaining Icons)
//             Expanded(
//               child: Container(
//                 height: 48.h,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(30.r),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: List.generate(CustomBottomNavBar._icons.length, (index) {
//                     // Agar icon selected hai to yahan hide kar dein kyunki wo red circle mein hai
//                     if (index == widget.currentIndex) return const SizedBox.shrink();
//
//                     return GestureDetector(
//                       onTap: () => widget.onTap(index),
//                       behavior: HitTestBehavior.opaque,
//                       child: Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 10.w),
//                         child: Icon(
//                           CustomBottomNavBar._icons[index],
//                           color: Colors.black, // Non-selected icons black
//                           size: 24.sp,
//                         ),
//                       ),
//                     );
//                   }),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/theme/app_color.dart';

class CustomBottomNavBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static const List<IconData> _icons = [
    Icons.home_filled,
    Icons.fitness_center_rounded,
    Icons.bar_chart_rounded,
    Icons.calendar_today_rounded,
    Icons.settings_outlined,
  ];

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 40.w, right: 40.w, bottom: 12.h),
      child: SizedBox(
        height: 48.h,
        child: Row(
          children: [
            // 1. Red Selected Circle (Left Side) WITH ANIMATION
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 60.w,
              height: 70.h,
              decoration: BoxDecoration(
                color: AppColors.primaryRed,
                shape: BoxShape.circle,
              ),
              // Yahan AnimatedSwitcher lagaya hai
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                switchInCurve: Curves.easeOutBack, // Bounce effect enter hote waqt
                switchOutCurve: Curves.easeIn,     // Smooth exit
                transitionBuilder: (Widget child, Animation<double> animation) {
                  // Logic: Icon Right side se slide ho kar ayega (Offset 1.5 -> 0)
                  final offsetAnimation = Tween<Offset>(
                    begin: const Offset(1.5, 0.0),
                    end: Offset.zero,
                  ).animate(animation);

                  return SlideTransition(
                    position: offsetAnimation,
                    child: FadeTransition(
                      opacity: animation,
                      child: ScaleTransition(
                          scale: animation,
                          child: child
                      ),
                    ),
                  );
                },
                child: Icon(
                  CustomBottomNavBar._icons[widget.currentIndex],
                  key: ValueKey<int>(widget.currentIndex),
                  color: Colors.white,
                  size: 28.sp,
                ),
              ),
            ),

            SizedBox(width: 2.w),

            // White Capsule Bar (Remaining Icons - No Changes)
            Expanded(
              child: Container(
                height: 48.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(CustomBottomNavBar._icons.length, (index) {
                    if (index == widget.currentIndex) return const SizedBox.shrink();

                    return GestureDetector(
                      onTap: () => widget.onTap(index),
                      behavior: HitTestBehavior.opaque,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Icon(
                          CustomBottomNavBar._icons[index],
                          color: Colors.black,
                          size: 24.sp,
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
