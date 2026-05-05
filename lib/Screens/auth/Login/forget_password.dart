import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:iron_log/Screens/auth/Login/send_code.dart';
import 'package:iron_log/Widgets/custom_button.dart';
import 'package:iron_log/Widgets/custom_text.dart';
import 'package:iron_log/Widgets/custom_text2.dart';
import 'package:iron_log/Widgets/textfield.dart';

import '../../../Widgets/button.dart';


class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        toolbarHeight: 80.h,
        leadingWidth: 70.w,
        backgroundColor: Colors.black,
        elevation: 0,

        leading: Padding(
          padding: EdgeInsets.only(left: 15.w, top: 20.h),
          child: CustomButton(
            onTap: (){
              Get.back();
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
                child: Image.asset("assets/images/Forgetshield.png",
                  width: 200.w,height: 200.h,)
            ),
            SizedBox(height: 20.h,),
            Padding(
              padding: EdgeInsets.only(right: 60.w),
              child: Column(
                children: [
                  CustomText(
                    text: "Verify Your Identity",
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 28.sp,
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 5.h,),
                  Padding(
                    padding:  EdgeInsets.only(right: 30.w),
                    child: CustomText2(
                      text:"Enter email to find your account",
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.h,),
            SizedBox(width: 315.w,height: 45.h,
                child: TextfieldScreen(
                  controller: TextEditingController(),
                  hintText: "Enter Email Address",
                )
            ),
            SizedBox(height: 30.h,),
            Button(
              label: 'Send Code',
              onTap: () {
                Get.to(SendCode());
              },),
          ],
        ),
      ),
    );
  }
}
