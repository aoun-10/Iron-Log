import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iron_log/core/theme/app_color.dart';

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final Function(bool) onChanged;
  final String? text;
  final bool showTermsLine;
  final VoidCallback? termsTap;
  final VoidCallback? privacyTap;

  const CustomCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.text,
    this.showTermsLine = false,
    this.termsTap,
    this.privacyTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            onChanged(!value);
          },
          child: Container(
            width: 20.w,
            height: 20.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey),
              color: value ? Colors.grey.shade900 : Colors.transparent,
            ),
            child: value
                ? Icon(Icons.check, size: 16.sp, color: AppColors.primaryRed)
                : null,
          ),
        ),
        SizedBox(width: 7.w),
        showTermsLine
            ? RichText(
          text: TextSpan(
            style: GoogleFonts.inter(
              fontSize: 9.sp,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
            children: [
             TextSpan(text: "I agree with all "),

              WidgetSpan(
                child: GestureDetector(
                  onTap: termsTap,
                  child: Text(
                    "Terms & Conditions",
                    style: GoogleFonts.inter(
                      fontSize: 9.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryRed, // ✅ red only here
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.primaryRed,
                    ),
                  ),
                ),
              ),

              TextSpan(text: " and "),

              WidgetSpan(
                child: GestureDetector(
                  onTap: privacyTap,
                  child: Text(
                    "Privacy Policy",
                    style: GoogleFonts.inter(
                      fontSize: 9.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryRed,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.primaryRed,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
            : Text(
          text ?? "",
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w700,
            fontSize: 10.sp,
            color: Colors.white,
            decoration: TextDecoration.underline,
            decorationColor: Colors.white,
          ),
        ),
      ],
    );
  }
}