import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iron_log/Screens/auth/Login/login.dart';

import '../../../Widgets/custom_text.dart';
import '../../../core/theme/app_color.dart';
import 'onboardingscreen.dart';
// Center(
// child: CustomPaint(
// painter: _GlassBorderPainter(),
// child: Container(
// width: 46.w,
// height: 46.h,
// decoration: BoxDecoration(
// gradient: LinearGradient(
// begin: Alignment.topLeft,
// end: Alignment.bottomRight,
// colors: [
// AppColors.primaryRed.withValues(alpha: 0.3),
// AppColors.primaryRed.withValues(alpha: 0.2),
// AppColors.primaryRed.withValues(alpha: 0.2),
// ],
// ),
// color: AppColors.primaryRed,
// shape: BoxShape.circle,
// ),
// child: Icon(
// Icons.arrow_forward_rounded,
// color: Colors.white,
// size: 20.sp,
// ),
// ),
// ),
// ),

class Welcome  extends StatefulWidget {
  const Welcome ({super.key});

  @override
  State<Welcome > createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
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
      //backgroundColor: Colors.black, // 👈 ye zaroor lagao
      body: SizedBox.expand(
        child: Image.asset(
          "assets/images/WelcomeScreen.png",
          fit: BoxFit.cover,
          alignment: Alignment.center,
        ),
      ),
    );
  }
}