import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:iron_log/Widgets/button.dart';
import 'package:iron_log/Widgets/custom_text.dart';
import 'package:iron_log/Widgets/custom_text2.dart';
import 'package:iron_log/Widgets/passwordtextfield_custom.dart';

import '../../../Widgets/custom_button.dart';
import '../../Dashboard/home_state.dart';

class Changepassword extends StatelessWidget {
  const Changepassword({super.key});

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
          child:CustomButton(
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
                child: Image.asset("assets/images/lock_changepass.png",
                  width: 200.w,height: 200.h,)
            ),
            SizedBox(height: 20.h,),
            Padding(
              padding: EdgeInsets.only(right: 60.w),
              child: Column(
                children: [
                  Padding(
                    padding:  EdgeInsets.only(right: 30.w),
                    child: CustomText(
                      text: "Change Password",
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 28.sp,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  SizedBox(height: 5.h,),
                  Padding(
                    padding:  EdgeInsets.only(right: 110.w),
                    child: CustomText2(
                      text:"Enter New password",
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 25.h,),
            SizedBox(width: 315.w,height: 45.h,
                child: PasswordTextfieldScreen(
                  controller: TextEditingController(),
                  hintText: "Enter Password",
                )
            ),
            SizedBox(height: 8.h,),
            SizedBox(width: 315.w,height: 45.h,
                child: PasswordTextfieldScreen(
                  controller: TextEditingController(),
                  hintText: "Confirm Password",
                )
            ),
            SizedBox(height: 50.h,),
            Button(
                label: "Save Changes",
                onTap: (){
                  Get.to(HomeState()
                  );
            }
            )
          ],
        ),
      ),
    );
  }
}
