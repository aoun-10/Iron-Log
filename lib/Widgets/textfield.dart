import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iron_log/core/theme/app_color.dart';

class TextfieldScreen extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final  Icon? icon;
  final Icon? icon1;
  final TextInputType? keyboardType;

  const TextfieldScreen({
    super.key,
    this.hintText,
    this.controller,
    this.icon,
    this.icon1,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: Color(0xFFA90907),
      cursorHeight: 18,
      style: GoogleFonts.inter(color: Colors.white),
      keyboardType: keyboardType,
      decoration: InputDecoration(
        fillColor: AppColors.darkBackground,
        filled: true,
        hintText:  hintText!,hintStyle: GoogleFonts.inter(
          fontSize: 13.sp,
          fontWeight: FontWeight.w400,
          color: Color(0xFF767575),
      ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.r),
          borderSide: BorderSide(color: Colors.grey.shade900),
        ),
        suffixIcon: icon,
        prefixIcon: icon1,
        prefixIconColor: Colors.grey,
        suffixIconColor:Colors.grey ,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.r),
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
    );
  }
}