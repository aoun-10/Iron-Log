import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Button extends StatefulWidget {
  final String label;
  final IconData? icon;
  final VoidCallback onTap;
  final double? width;
  final double? height;
  final String imagePath;
  final Color textColor; // Naya parameter
  final Color iconColor; // Naya parameter

  const Button({
    super.key,
    required this.label,
    required this.onTap,
    this.icon,
    this.width,
    this.height,
    this.imagePath = 'assets/images/Button.png',
    this.textColor = Colors.white, // Default white
    this.iconColor = Colors.white, // Default white
  });

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
      lowerBound: 0.0,
      upperBound: 1.0,
    );
    _scaleAnim = Tween<double>(begin: 1.0, end: 0.96).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails _) => _controller.forward();
  void _handleTapUp(TapUpDetails _) {
    _controller.reverse();
    widget.onTap();
  }

  void _handleTapCancel() => _controller.reverse();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: AnimatedBuilder(
        animation: _scaleAnim,
        builder: (context, child) => Transform.scale(
          scale: _scaleAnim.value,
          child: child,
        ),
        child: Container(
          width: (widget.width ?? 315).w,
          height: (widget.height ?? 54).h,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(widget.imagePath),
              fit: BoxFit.fill,
            ),
          ),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.label,
                  style: GoogleFonts.quattrocento(
                    color: widget.textColor,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                if (widget.icon != null) ...[
                  SizedBox(width: 6.w),
                  Icon(
                    widget.icon,
                    color: widget.iconColor,
                    size: 20.sp,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}