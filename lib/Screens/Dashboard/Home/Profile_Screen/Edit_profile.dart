import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iron_log/core/theme/app_color.dart';
import '../../../../Widgets/custom_button.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  // Controllers to handle text editing
  final TextEditingController _nameController = TextEditingController(text: "Bravo Charley");
  final TextEditingController _emailController = TextEditingController(text: "bravocharley121@gmail.com");
  final TextEditingController _specialistController = TextEditingController(text: "Strength Specialist");

  // Image Picking Logic
  Future<void> _pickImage(ImageSource source) async {
    final XFile? selectedImage = await _picker.pickImage(source: source);
    if (selectedImage != null) {
      setState(() {
        _image = File(selectedImage.path);
      });
    }
    if (mounted) Get.back();
  }

  // Upgraded Premium Bottom Sheet
  void _showPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent, // For custom design
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1A0505),
            borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
            //border: Border.all(color: Colors.red.withValues(alpha: 0.2), width: 1),
          ),
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                'Profile Picture',
                style: GoogleFonts.quattrocento(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 25.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildPickerOption(
                    icon: Icons.photo_library_rounded,
                    label: 'Gallery',
                    onTap: () => _pickImage(ImageSource.gallery),
                  ),
                  _buildPickerOption(
                    icon: Icons.camera_alt_rounded,
                    label: 'Camera',
                    onTap: () => _pickImage(ImageSource.camera),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPickerOption({required IconData icon, required String label, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(15.r),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white10),
            ),
            child: Icon(icon, color: Colors.red[700], size: 30.r),
          ),
          SizedBox(height: 10.h),
          Text(label, style: GoogleFonts.inter(color: Colors.white, fontSize: 14.sp)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leadingWidth: 70.w,
        toolbarHeight: 80.h,
        leading: Padding(
          padding: EdgeInsets.only(left: 20.w, top: 10.h),
          child: CustomButton(
            onTap: (){
              Get.back();
            },),
        ),
        title:
          Padding(
            padding: EdgeInsets.only(top: 10.h),
            child: Text(
              'Edit Profile',
              style: GoogleFonts.quattrocento(
                fontSize: 28.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0),
          child: Column(
            children: [
              SizedBox(height: 7.h),

              // Profile Image
              Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    radius: 75.r,
                    backgroundColor: Colors.grey[900],
                    backgroundImage: _image != null
                        ? FileImage(_image!)
                        : AssetImage("assets/images/Onboarding1.png") as ImageProvider,
                  ),
                  Positioned(
                    bottom: 5.r,
                    right: 5.r,
                    child: GestureDetector(
                      onTap: ()=>_showPicker(context),
                      child: Container(
                        width: 30.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/backbutton.png"),
                            fit: BoxFit.contain,
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 16.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 50.h),

              // Workable Input Fields
              _buildWorkableTile(controller: _nameController, icon: Icons.person_outline),
              SizedBox(height: 10.h),
              _buildWorkableTile(controller: _emailController, icon: Icons.email_outlined),
              SizedBox(height: 10.h),
              _buildWorkableTile(controller: _specialistController, icon: Icons.workspace_premium_outlined),
            ],
          ),
        ),
      ),
    );
  }

  // Workable Tile with TextField
  Widget _buildWorkableTile({required TextEditingController controller, required IconData icon}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 13.w,),
      decoration: BoxDecoration(
        color: AppColors.darkBackground,
        borderRadius: BorderRadius.circular(25.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: TextField(
        controller: controller,
        textAlignVertical: TextAlignVertical.center,
        cursorColor: AppColors.primaryRed,
        style: GoogleFonts.inter(fontSize: 13.sp, color: Colors.grey),
        decoration: InputDecoration(
          border: InputBorder.none,
          //icon: Icon(icon, color: Colors.white38, size: 20.r),
          suffixIcon: Icon(Icons.edit, color: AppColors.primaryRed, size: 20.r),
        ),
      ),
    );
  }
}