import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iron_log/Widgets/Glasseffect.dart';
import 'package:iron_log/Widgets/onboardingbutton.dart';
import '../../../Models/Onboarding/onboarding_data.dart';
import '../../../core/theme/app_color.dart';
import '../Sign_Up/sign_up.dart';
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int currentIndex = 0;

  double _dragOffset = 0;
  double _maxDrag = 0;
  bool _isNavigating = false;

  void _onDragUpdate(DragUpdateDetails details) {
    if (_isNavigating) return;
    setState(() {
      _dragOffset += details.delta.dx;
      if (_dragOffset < 0) _dragOffset = 0;
      if (_dragOffset > _maxDrag) _dragOffset = _maxDrag;
    });
  }

  void _onDragEnd(DragEndDetails details) {
    if (_isNavigating) return;

    if (_dragOffset >= _maxDrag - 10.w || (details.primaryVelocity ?? 0) > 800) {
      if (currentIndex == onboardingData.length - 1) {
        setState(() => _isNavigating = true);

        Get.off(() => const SignUpScreen(),
            transition: Transition.cupertino,
            duration: const Duration(milliseconds: 300));
      } else {
        _controller.nextPage(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutQuart,
        );
      }
    }
    setState(() => _dragOffset = 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        controller: _controller,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: onboardingData.length,
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
            _dragOffset = 0;
          });
        },
        itemBuilder: (context, index) {
          final data = onboardingData[index];

          // final swipeProgress =
          // _maxDrag > 0 ? (_dragOffset / _maxDrag).clamp(0.0, 1.0) : 0.0;

          return Stack(
            children: [
              Positioned.fill(
                child: Opacity(
                  opacity: 1,
                  child: Image.asset(
                    data.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      // Neeche se dark shuru hoga aur upar transparent hota jayega
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        const Color(0xFF131313).withValues(alpha: 0.9), // 0% par 100% Opacity
                        const Color(0xFF131313).withValues(alpha: 0.5), // 55% par 50% Opacity
                        const Color(0xFF131313).withValues(alpha: 0.0), // 100% par 0% Opacity
                      ],
                      // Figma ke "Stops" percentage ko yahan decimal mein likha hai
                      stops: const [0.0, 0.6, 1],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                top: 290.h,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Opacity(
                        opacity: 0.9,
                        child: Text(
                          data.phase,
                          style: GoogleFonts.inter(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            //letterSpacing: 2.0.w,
                          ),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Opacity(
                        opacity: 0.9,
                        child: Text(
                          data.title,
                          style: GoogleFonts.quattrocento(
                            fontSize: 48.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            height: 1.05,
                            //letterSpacing: -0.5.w,
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Opacity(
                        opacity: 0.8,
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: data.description,
                                style: GoogleFonts.inter(
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white,
                                    height: 1.5.h
                                ),
                              ),
                              if (data.text != null)
                                TextSpan(
                                  text: data.text,
                                  style: GoogleFonts.inter(
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),

                      // Dynamic indicators
                      Row(
                        children: List.generate(
                          onboardingData.length,
                              (i) => Container(
                            margin: EdgeInsets.only(right: 3.w),
                            width: i == currentIndex ? 45.w : 28.w,
                            height: 4.h,
                            decoration: BoxDecoration(
                              color: i == currentIndex
                                  ? AppColors.primaryRed
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(2.r),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 90.h),

                      // Bottom buttons row
                      LayoutBuilder(
                        builder: (context, constraints) {
                          // 1. Calculate available width
                          // Agar currentIndex > 0 hai toh back button (46) + gap (6) minus hoga
                          double backBtnSpace = currentIndex > 0 ? 52.w : 0;
                          double availableWidth = constraints.maxWidth - backBtnSpace;
                          double maxDragLimit = availableWidth - 46.w - 12.w;
                          if (_maxDrag != maxDragLimit) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              setState(() {
                                _maxDrag = maxDragLimit;
                              });
                            });
                          }

                          return Row(
                            children: [
                              if (currentIndex > 0) ...[
                                GestureDetector(
                                  onTap: () {
                                    _controller.previousPage(
                                      duration: const Duration(milliseconds: 100),
                                      curve: Curves.easeInOut,
                                    );
                                  },
                                  child: Onboardingbutton(
                                      onTap:(){},

                                  )
                                ),
                                SizedBox(width: 6.w),
                              ],
                              //
                              // // Slider Container
                              // Expanded(
                              //   child: CustomGlassContainer(
                              //     child: Container(
                              //       height: 54.h,
                              //       decoration: BoxDecoration(
                              //
                              //         color: Color(0x66363635).withValues(alpha: 0.7),
                              //         borderRadius: BorderRadius.circular(40.r),
                              //         border: Border.all(
                              //           color: Color(0xFF888888),
                              //           width: 1.w,
                              //         ),
                              //       ),
                              //       child: Stack(
                              //         alignment: Alignment.centerLeft,
                              //         children: [
                              //           // Red Fill Trail
                              //           AnimatedContainer(
                              //             duration: Duration.zero,
                              //             margin: EdgeInsets.all(6.w),
                              //             // Trail width calculation
                              //             width: (46.w + _dragOffset).clamp(46.w, availableWidth - 12.w),
                              //             decoration: BoxDecoration(
                              //               color: AppColors.primaryRed.withValues(alpha: 0.15),
                              //               borderRadius: BorderRadius.circular(40.r),
                              //             ),
                              //           ),
                              //
                              //           // Forward Arrow (The Draggable part)
                              //           Positioned(
                              //             left: 6.w + _dragOffset,
                              //             top: 0,
                              //             bottom: 0,
                              //             child: GestureDetector(
                              //                 onHorizontalDragUpdate: (details) {
                              //                   if (_isNavigating) return;
                              //                   setState(() {
                              //                     _dragOffset += details.delta.dx;
                              //
                              //                     // Limits check
                              //                     if (_dragOffset < 0) _dragOffset = 0;
                              //                     if (_dragOffset > _maxDrag) _dragOffset = _maxDrag;
                              //                   });
                              //                 },
                              //                 onHorizontalDragEnd: (details) {
                              //                   if (_isNavigating) return;
                              //
                              //                   if (_dragOffset >= _maxDrag * 0.8 || (details.primaryVelocity ?? 0) > 800) {
                              //                     if (currentIndex == onboardingData.length - 1) {
                              //                       Get.off(() => const SignUpScreen(), transition: Transition.cupertino);
                              //                     } else {
                              //                       _controller.nextPage(
                              //                         duration: const Duration(milliseconds: 400),
                              //                         curve: Curves.easeOutQuart,
                              //                       );
                              //                     }
                              //                   }
                              //                   setState(() => _dragOffset = 0);
                              //                 },
                              //               child: Onboardingbutton(
                              //                   onTap: (){},
                              //                 icon: Icons.arrow_forward_rounded,
                              //               )
                              //             ),
                              //           ),
                              //
                              //           Positioned(
                              //             right: 16.w,
                              //             top: 0,
                              //             bottom: 0,
                              //             child: Opacity(
                              //               opacity: (1 - (_dragOffset / (maxDragLimit > 0 ? maxDragLimit : 1)) * 1.5).clamp(0.0, 1.0),
                              //               child: Row(
                              //                 mainAxisSize: MainAxisSize.min,
                              //                 children: [
                              //                   Text(
                              //                     data.text1,
                              //                     style: GoogleFonts.quattrocento(
                              //                       fontSize: 18.sp,
                              //                       fontWeight: FontWeight.w400,
                              //                       color: Colors.white,
                              //                     ),
                              //                   ),
                              //                   SizedBox(width: currentIndex == 0 ? 45.w : 15.w),
                              //
                              //                   Row(
                              //                     children: [
                              //                       Icon(Icons.arrow_forward_ios, size: 12.sp, color: Colors.white30),
                              //                       Icon(Icons.arrow_forward_ios, size: 14.sp, color: Colors.white70),
                              //                       Icon(Icons.arrow_forward_ios, size: 18.sp, color: Colors.white),
                              //                     ],
                              //                   ),
                              //                 ],
                              //               ),
                              //             ),
                              //           ),
                              //         ],
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              // Slider Container
                              Expanded(
                                child: CustomGlassContainer(
                                  child: Container(
                                    height: 54.h,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      // Aapki background image yahan set hai
                                      image: const DecorationImage(
                                        image: AssetImage('assets/images/onboardingScreen0.png'),
                                        fit: BoxFit.fill,
                                      ),
                                      borderRadius: BorderRadius.circular(40.r),
                                    ),
                                    child: Stack(
                                      alignment: Alignment.centerLeft,
                                      children: [
                                        // 1. Red Fill Trail (Logic remains same)
                                        AnimatedContainer(
                                          duration: Duration.zero,
                                          margin: EdgeInsets.all(6.w),
                                          // Trail width calculation
                                          width: (46.w + _dragOffset).clamp(46.w, availableWidth - 12.w),
                                          decoration: BoxDecoration(
                                            color: AppColors.primaryRed.withValues(alpha: 0.15),
                                            borderRadius: BorderRadius.circular(40.r),
                                          ),
                                        ),

                                        // 2. Text aur Arrows (Right Positioned - Jaisa aapke pehle code mein tha)
                                        Positioned(
                                          right: 16.w,
                                          top: 0,
                                          bottom: 0,
                                          child: Center( // Isse vertically center rahega
                                            child: Opacity(
                                              // _maxDrag ki safety check ke saath opacity logic
                                              opacity: (1 - (_dragOffset / (_maxDrag > 0 ? _maxDrag : 1)) * 1.5).clamp(0.0, 1.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    data.text1,
                                                    style: GoogleFonts.quattrocento(
                                                      fontSize: 18.sp,
                                                      fontWeight: FontWeight.w400,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  // Dynamic spacing based on index jaisa aapne original code mein rakha tha
                                                  SizedBox(width: currentIndex == 0 ? 45.w : 15.w),

                                                  // Animated Arrows
                                                  Row(
                                                    children: [
                                                      Icon(Icons.arrow_forward_ios, size: 12.sp, color: Colors.white30),
                                                      Icon(Icons.arrow_forward_ios, size: 14.sp, color: Colors.white70),
                                                      Icon(Icons.arrow_forward_ios, size: 18.sp, color: Colors.white),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),

                                        // 3. The Draggable Handle (Forward Arrow)
                                        Positioned(
                                          left: 6.w + _dragOffset,
                                          top: 0,
                                          bottom: 0,
                                          child: GestureDetector(
                                            onHorizontalDragUpdate: (details) {
                                              if (_isNavigating) return;
                                              setState(() {
                                                _dragOffset += details.delta.dx;

                                                // Limits check
                                                if (_dragOffset < 0) _dragOffset = 0;
                                                if (_dragOffset > _maxDrag) _dragOffset = _maxDrag;
                                              });
                                            },
                                            onHorizontalDragEnd: (details) {
                                              if (_isNavigating) return;

                                              // 80% threshold logic
                                              if (_dragOffset >= _maxDrag * 0.8 || (details.primaryVelocity ?? 0) > 800) {
                                                if (currentIndex == onboardingData.length - 1) {
                                                  Get.off(() => const SignUpScreen(), transition: Transition.cupertino);
                                                } else {
                                                  _controller.nextPage(
                                                    duration: const Duration(milliseconds: 400),
                                                    curve: Curves.easeOutQuart,
                                                  );
                                                }
                                              }
                                              setState(() => _dragOffset = 0);
                                            },
                                            child: Onboardingbutton(
                                              onTap: () {},
                                              icon: Icons.arrow_forward_rounded,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
//
// class _GlassBorderPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final center = Offset(size.width / 2, size.height / 2);
//     final radius = (size.width / 2) - 0.8;
//
//     canvas.drawArc(
//       Rect.fromCircle(center: center, radius: radius),
//       -2.9,
//       1.2,
//       false,
//       Paint()
//         ..style = PaintingStyle.stroke
//         ..strokeWidth = 1.w // Added .w for responsive border width
//         ..strokeCap = StrokeCap.round
//         ..color = Colors.white.withValues(alpha: 0.55),
//     );
//
//     canvas.drawArc(
//       Rect.fromCircle(center: center, radius: radius),
//       0.1,
//       1.3,
//       false,
//       Paint()
//         ..style = PaintingStyle.stroke
//         ..strokeWidth = 1.w // Added .w for responsive border width
//         ..strokeCap = StrokeCap.round
//         ..color = Colors.white.withValues(alpha: 0.55),
//     );
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }