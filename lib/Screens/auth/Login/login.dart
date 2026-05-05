import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iron_log/Screens/Dashboard/home_state.dart';
import 'package:iron_log/Screens/auth/Sign_Up/sign_up.dart';
import 'package:iron_log/Widgets/custom_text.dart';
import 'package:iron_log/Widgets/custom_text2.dart';
import 'package:iron_log/core/theme/app_color.dart';
import '../../../Widgets/button.dart';
import '../../../Widgets/custom_checkbox.dart';
import '../../../Widgets/passwordtextfield_custom.dart';
import '../../../Widgets/textfield.dart';
import 'forget_password.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool ischecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body:SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: 200.w,
                height: 200.h,
                child: Image.asset("assets/images/Logo1.png"),
              ),
              Padding(
                padding: EdgeInsets.only(right: 85.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "Log In",
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 28.sp,
                      textAlign: TextAlign.start,
                    ),
                    CustomText2(
                      text:"Enter Your Username & Password",
                      color: Colors.white,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15.h,),
              SizedBox(width: 315.w,height: 45.h,
                  child: TextfieldScreen(
                    controller: TextEditingController(),
                    hintText: "Username",
                  )
              ),
              SizedBox(height: 8.h,),
              SizedBox(width: 315.w,height: 45.h,
                  child: PasswordTextfieldScreen(
                    controller: TextEditingController(),
                    hintText: "Password",
                  )
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 24.w),
                    child: CustomCheckbox(
                      value: ischecked,
                      text: "Remember Me",
                      onChanged: (value) {
                        setState(() {
                          ischecked = value;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 15.w),
                    child: TextButton(
                      onPressed: () {
                        Get.to(ForgetPassword());
                      },
                      child: Text(
                        "Forget Password",
                        style: GoogleFonts.manrope(
                          fontSize: 11.sp,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.primaryRed,
                          decorationThickness: 2,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryRed
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 23.h,),
              Button(
                label: 'Sign In',
                onTap: () {
                  Get.to(HomeState());
                },),
              SizedBox(height:30.h,),
              SizedBox(
                width:258.w,
                height: 35.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?",style: GoogleFonts.inter(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                        color: Colors.white
                    ),),
                    TextButton(
                        onPressed:(){
                          Get.to(SignUpScreen());
                        },
                        child: Text("Sign Up",style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.primaryRed,
                            decorationThickness: 1,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryRed
                        ),)
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}