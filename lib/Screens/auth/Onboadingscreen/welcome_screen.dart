import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iron_log/Screens/auth/Login/login.dart';

import '../../../Widgets/custom_text.dart';
import '../../../core/theme/app_color.dart';
import 'onboardingscreen.dart';

class WelcomeScreen  extends StatefulWidget {
  const WelcomeScreen ({super.key});

  @override
  State<WelcomeScreen > createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  double _dragOffset = 0;
  bool _isNavigating = false;

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    if (_isNavigating) return;
    setState(() {
      _dragOffset += details.delta.dx;
      if (_dragOffset < 0) _dragOffset = 0;
    });
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    if (_isNavigating) return;

    if (_dragOffset > 80 || (details.primaryVelocity ?? 0) > 200) {
      setState(() => _isNavigating = true);
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              OnboardingScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 400),
        ),
      );
    } else {
      setState(() => _dragOffset = 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF5A0000),
      body: Opacity(
        opacity: 1,
        child: Stack(
          fit: StackFit.expand,
          children: [
            //  Base dark red gradient background
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF2E0000),

                    Color(0xFF2E0000),
                    Color(0xFF2E0000),
                  ],
                  stops: [0.0, 0.3, 1.0],
                ),
              ),
            ),
            Positioned(
              top: -90.h,
              left: -50.w,
              right: -160.w,
              bottom: 120.h,
              child: Opacity(
                opacity: 0.078,
                child: Transform.rotate(
                  angle: -0.1,
                  child: Image.asset(
                    'assets/images/Subtract.png',
                    width: 480.w,
                    height: 580.h,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Positioned(
              child: Opacity(
                opacity: 0.9,
                child: SizedBox(
                  width: 462.w,
                  height: 693.h,
                  child: Image.asset(
                    'assets/images/welc 1.png',
                    fit: BoxFit.contain,
                    alignment: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 70.h,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.50),
                      Colors.black.withValues(alpha: 0.3),
                      Colors.transparent,
                    ],
                    stops: [0.0, 0.5, 1.0],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: 150.h,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.50),
                      Colors.black.withValues(alpha: 0.75),
                      Colors.transparent,
                    ],
                    stops: const [0.0, 0.55, 1.0],
                  ),
                ),
              ),
            ),
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 100.h),

                  // ── Title ─────────────────────────────────
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Text(
                      'WELCOME TO\nIRON LOG',
                      style: GoogleFonts.quattrocento(
                        fontSize: 46.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        height: 1.08,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  SizedBox(height: 360.h,),
                  Padding(
                    padding: EdgeInsets.only(right: 30.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onHorizontalDragUpdate: _onHorizontalDragUpdate,
                          onHorizontalDragEnd: _onHorizontalDragEnd,
                          child: Transform.translate(
                            offset: Offset(_dragOffset.clamp(0, 60), 0),
                            child: ClipOval(
                              child: SizedBox(
                                width: 90.w,
                                height: 90.h,
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Colors.red.withValues(alpha: 0.5),
                                        width: 1
                                    ),
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        AppColors.primaryRed.withValues(
                                            alpha: 0.3),
                                        AppColors.primaryRed.withValues(
                                            alpha: 0.2),
                                        AppColors.primaryRed.withValues(
                                            alpha: 0.2),
                                      ],
                                      stops: [0.0, 0.5, 1.0],
                                    ),
                                  ),
                                  child: Center(
                                    child: CustomText(
                                      textAlign: TextAlign.center,
                                      text: "Get\nStarted",
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        AnimatedOpacity(
                          opacity: _dragOffset > 10 ? 0.0 : 0.6,
                          duration: Duration(milliseconds: 200),
                          child: Padding(
                            padding: EdgeInsets.only(left: 3.w),
                            child: Row(
                              children: [
                                Icon(Icons.arrow_forward_ios,
                                    size: 14.sp, color: Colors.white30),
                                Icon(Icons.arrow_forward_ios,
                                    size: 16.sp, color: Colors.white70),
                                Icon(Icons.arrow_forward_ios,
                                    size: 20.sp, color: Colors.white),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(height: 26.h,),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Text("Already have an account",style: GoogleFonts.inter(
                  //         fontWeight: FontWeight.w400,
                  //         color: Colors.white,
                  //         fontSize: 16.sp
                  //     ),),
                  //     TextButton(
                  //         onPressed:(){
                  //          Get.to(LoginScreen());
                  //         },
                  //         child: Text("Sign In",style: GoogleFonts.inter(
                  //             fontSize: 16.sp,
                  //             decoration: TextDecoration.underline,
                  //             decorationColor: AppColors.primaryRed,
                  //             decorationThickness: 1,
                  //             fontWeight: FontWeight.bold,
                  //             color: AppColors.primaryRed
                  //         ),)
                  //     ),
                  //   ],
                  // )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}