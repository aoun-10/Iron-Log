import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iron_log/Screens/Dashboard/work_hub/Exercise/exercise_library.dart';
import '../../../../Widgets/button.dart';
import '../../../../Widgets/custom_button.dart';
import '../../../../Widgets/custom_paint.dart';
import '../../../../core/theme/app_color.dart'; // Aapka purana custom paint import

class EditExerciseScreen extends StatefulWidget {
  const EditExerciseScreen({super.key});

  @override
  State<EditExerciseScreen> createState() => _EditExerciseScreenState();
}

class _EditExerciseScreenState extends State<EditExerciseScreen> {
  // Logic Variables
  File? _image;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _nameController = TextEditingController(text: "Bulgarian Split Squats");

  String selectedCategory = "Legs";
  String selectedEquipment = "Dumbbell";

  final List<String> categories = ["Chest", "Back", "Legs", "Shoulders", "Arms"];
  final List<String> equipmentList = ["Barbell", "Dumbbell", "Machine", "Cable", "Kettlebell"];

  // Image Picking Logic
  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
    if (mounted) Get.back();
  }

  // Premium Bottom Sheet for Image
  void _showPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1A0505),
            borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
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
                'Change Cover Image',
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
            padding: EdgeInsets.all(15.w),
            decoration: BoxDecoration(
              color: AppColors.primaryRed.withValues(alpha: 0.1),
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primaryRed.withValues(alpha: 0.5)),
            ),
            child: Icon(icon, color: Colors.white, size: 30.sp),
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
        leading: _buildBackButton(),
        title: Padding(
          padding: EdgeInsets.only(top: 15.h),
          child: Text(
            "Excericse Management",
            style: GoogleFonts.inter(fontSize: 12.sp, fontWeight: FontWeight.w500, color: Colors.white),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 7.h),
              Text(
                "EDIT EXCERCISE",
                style: GoogleFonts.quattrocento(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20.h),

              // 1. Workable Cover Image Container
              GestureDetector(
                onTap: () => _showPicker(context),
                child: CustomPaint(
                  child: Container(
                    width: double.infinity,
                    height: 143.h,
                    decoration: BoxDecoration(
                      border: _image != null ? Border.all(color: Colors.white12) : null,
                      image: _image != null
                          ? DecorationImage(image: FileImage(_image!), fit: BoxFit.cover)
                          : const DecorationImage(
                        image: AssetImage('assets/images/shadow.png'),
                        fit: BoxFit.contain,
                        opacity: 1,
                      ),
                    ),
                    child: _image == null
                        ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Camera Icon with Red Color #A90907
                        Icon(Icons.camera_alt_outlined, color: AppColors.primaryRed, size: 45.sp),
                        SizedBox(height: 10.h),
                        Text(
                          "CHANGE COVER IMAGE",
                          style: GoogleFonts.inter(
                            color: Colors.white60,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    )
                        :  SizedBox.shrink(),
                  ),
                ),
              ),
              SizedBox(height: 25.h),

              // 2. Workable Exercise Name Field
              _buildLabel("Excercise Name"),
              _buildTextField(_nameController, "e.g. Squats"),

              SizedBox(height: 20.h),

              // 3. Workable Category Dropdown
              _buildLabel("Category"),
              _buildDropdownCustom(
                value: selectedCategory,
                items: categories,
                onChanged: (val) => setState(() => selectedCategory = val!),
              ),

              SizedBox(height: 20.h),

              // 4. Workable Equipment Dropdown
              _buildLabel("Equipment"),
              _buildDropdownCustom(
                value: selectedEquipment,
                items: equipmentList,
                onChanged: (val) => setState(() => selectedEquipment = val!),
              ),

              SizedBox(height: 40.h),

              // 5. Save Button
              _buildSaveButton(),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _buildBackButton() {
    return Padding(
      padding: EdgeInsets.only(left: 20.w, top: 10.h),
      child: CustomButton(
        onTap: (){
          Get.back();
        },),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(text, style: GoogleFonts.inter(color: Colors.white60, fontSize: 13.sp)),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint) {
    return Container(
      decoration: BoxDecoration(color: const Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(15.r)),
      child: TextField(
        controller: controller,
        cursorColor: AppColors.primaryRed,
        style: GoogleFonts.inter(color: Colors.white, fontSize: 15.sp),
        decoration: InputDecoration(
          hintText: hint,

          hintStyle: TextStyle(color: Colors.white24),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
        ),
      ),
    );
  }

  Widget _buildDropdownCustom({required String value, required List<String> items, required Function(String?) onChanged}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(color: const Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(15.r)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          dropdownColor: const Color(0xFF1E1E1E),
          icon: const Icon(Icons.arrow_drop_down, color: AppColors.primaryRed),
          items: items.map((e) => DropdownMenuItem(value: e, child: Text(e, style: const TextStyle(color: Colors.white)))).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildSaveButton() {
    return Button(
      label: 'Save Changes',
      onTap: () {
        Get.to(ExerciseLibraryScreen());
      },
    );
  }
}