import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iron_log/Screens/auth/Login/changepassword.dart';
import 'package:iron_log/Widgets/button.dart';
import 'package:iron_log/Widgets/custom_button.dart';
import 'package:iron_log/Widgets/custom_text.dart';
import 'package:iron_log/Widgets/custom_text2.dart';
import 'package:iron_log/Widgets/textfield_codescreen.dart';

class SendCode extends StatelessWidget {
  const SendCode({super.key});

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
                  Padding(
                    padding:  EdgeInsets.only(right: 110.w),
                    child: CustomText(
                      text: "Enter Code",
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 28.sp,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  SizedBox(height: 5.h,),
                  Padding(
                    padding:  EdgeInsets.only(right: 30.w),
                    child: CustomText2(
                      text:"Enter code to verify your Identity",
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h,),
            Row(
              spacing: 9,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 46.w,height: 48.h,
                    child: Textfield(
                    )
                ),
                SizedBox(width: 46.w,height: 48.h,
                    child: Textfield(
                    )
                ),
                SizedBox(width: 46.w,height: 48.h,
                    child: Textfield(
                    )
                ),
                SizedBox(width: 46.w,height: 48.h,
                    child: Textfield(
                    )
                ),
                SizedBox(width: 46.w,height: 48.h,
                    child: Textfield(
                    )
                ),
                SizedBox(width: 46.w,height: 48.h,
                    child: Textfield(
                    )
                ),
              ],
            ),
            SizedBox(height: 30.h,),
            Center(
              child: Text(
                "Resend in 00:30",style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: Colors.white
              ),),
            ),
            SizedBox(height: 40.h,),
            Button(
                label: "Veirfy Code",
                onTap: (){
                  Get.to(Changepassword());
                }
            ),
          ],
        ),
      ),
    );
  }
}
