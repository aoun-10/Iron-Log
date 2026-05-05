import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iron_log/Screens/Dashboard/home_state.dart';
import 'package:iron_log/Screens/auth/Login/login.dart';
import 'package:iron_log/Screens/auth/Sign_Up/privacy_policy.dart';
import 'package:iron_log/Screens/auth/Sign_Up/terms_conditional.dart';
import 'package:iron_log/Widgets/custom_text.dart';
import 'package:iron_log/Widgets/custom_text2.dart';
import 'package:iron_log/core/theme/app_color.dart';
import '../../../Widgets/button.dart';
import '../../../Widgets/custom_checkbox.dart';
import '../../../Widgets/passwordtextfield_custom.dart';
import '../../../Widgets/textfield.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
                padding: EdgeInsets.only(right: 70.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                        text: "Sign Up",
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 28.sp,
                      textAlign: TextAlign.start,
                    ),
                    CustomText2(
                      text:"Enter Details to Create Your Account!",
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
                    hintText: "Full Name",
                  )
              ),
              SizedBox(height: 6.h,),
              SizedBox(width: 315.w,height: 45.h,
                  child: TextfieldScreen(
                    controller: TextEditingController(),
                    hintText: "Email Address",
                  )
              ),
              SizedBox(height: 6.h,),
              SizedBox(width: 315.w,height: 45.h,
                  child: PasswordTextfieldScreen(
                    controller: TextEditingController(),
                    hintText: "Create Password",
                  )
              ),
              SizedBox(height: 6.h,),
              SizedBox(width: 315.w,height: 45.h,
                  child: PasswordTextfieldScreen(
                    controller: TextEditingController(),
                    hintText: "Confirm Password",
                  )
              ),
              SizedBox(height: 17.h,),
              Align(alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(left:24.w),
                  child: CustomCheckbox(
                    value: ischecked,
                    onChanged: (value) {
                      setState(() {
                        ischecked = value;
                      });
                    },
                    privacyTap: (){
                      Get.to(PrivacyPolicyScreen());
                    },
                    termsTap: (){
                      Get.to(TermsConditional());
                    },
                    showTermsLine: true,
                  ),
                ),
              ),
              SizedBox(height: 23.h,),
              Button(
                label: 'Create Account',
                onTap: () {
                  Get.to(HomeState());
                },
              ),
              SizedBox(height:40.h,),
              SizedBox(
                width:258.w,
                height: 35.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?",style: GoogleFonts.inter(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                      color: Colors.white
                    ),),
                    TextButton(
                        onPressed:(){
                          Get.to(LoginScreen());
                        },
                        child: Text("Sign In",style: GoogleFonts.inter(
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