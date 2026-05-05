import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isKg = true;
  bool notificationsOn = true;
  bool offlineSyncOn = true;

  String barbellWeight = "20";
  bool isEditingWeight = false;
  final TextEditingController _weightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w,0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                Text(
                  "SETTINGS",
                  style: GoogleFonts.quattrocento(
                    color: Colors.white,
                    fontSize: 32.sp,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
                SizedBox(height: 20.h),

                // Settings List
                _buildSettingTile(
                  icon: Icons.hourglass_bottom_rounded,
                  title: "Units",
                  trailing: _buildToggleSwitch(
                    leftLabel: "KG",
                    rightLabel: "LBS",
                    value: isKg,
                    onChanged: (val) => setState(() => isKg = val),
                  ),
                ),
                _buildSettingTile(
                  icon: Icons.fitness_center_rounded,
                  title: "Barbell Weight",
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      isEditingWeight
                          ? SizedBox(
                        width: 60.w,
                        child: TextField(
                          controller: _weightController,
                          autofocus: true,
                          cursorColor: Color(0xFFA90000),
                          keyboardType: TextInputType.number,
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                          ),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            isDense: true,
                          ),
                          onSubmitted: (val) {
                            setState(() {
                              if (val.isNotEmpty) barbellWeight = val;
                              isEditingWeight = false;
                            });
                          },
                        ),
                      )
                          : GestureDetector(
                        onTap: () {
                          setState(() {
                            _weightController.text = barbellWeight;
                            isEditingWeight = true;
                          });
                        },
                        child: Row(
                          children: [
                            Text(
                              "$barbellWeight KG",
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Icon(Icons.edit, color: const Color(0xFFA90000), size: 18.sp),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                _buildSettingTile(
                  icon: Icons.timer_outlined,
                  title: "Rest Timer Presets",
                  trailing: Icon(Icons.arrow_forward_ios, color: const Color(0xFFA90000), size: 16.sp),
                ),
                _buildSettingTile(
                  icon: Icons.build_outlined,
                  title: "Equipment Profiles",
                  trailing: Icon(Icons.arrow_forward_ios, color: const Color(0xFFA90000), size: 16.sp),
                ),
                _buildSettingTile(
                  icon: Icons.notifications_none_rounded,
                  title: "Notifications",
                  trailing: Switch(
                    value: notificationsOn,
                    onChanged: (val) => setState(() => notificationsOn = val),
                    activeThumbColor: Colors.white,
                    activeTrackColor: const Color(0xFFA90000),
                    inactiveThumbColor: Colors.grey,
                    inactiveTrackColor: Colors.white10,
                  ),
                ),
                _buildSettingTile(
                  icon: Icons.cloud_off_rounded,
                  title: "Offline Sync",
                  trailing: _buildToggleSwitch(
                    leftLabel: "ON",
                    rightLabel: "OFF",
                    value: offlineSyncOn,
                    onChanged: (val) => setState(() => offlineSyncOn = val),
                  ),
                ),

                SizedBox(height: 40.h),
                // Export Data Button
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 18.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40.r),
                    border: Border.all(color: const Color(0xFFA90000), width: 1.5),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF3D0000),
                        Color(0xFF3D0000),
                        Color(0xFF3D0000),
                      ],
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Export Data",
                        style: GoogleFonts.quattrocento(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(width: 10.w),
                      Icon(Icons.download_rounded, color: Colors.white, size: 20.sp),
                    ],
                  ),
                ),
                SizedBox(height: 100.h), // Space for bottom nav
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSettingTile({required IconData icon, required String title, required Widget trailing}) {
    return Container(
      height: 65.h,
      margin: EdgeInsets.only(bottom: 7.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: Color(0xFF201F1F),
        borderRadius: BorderRadius.circular(40.r),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFFA90000), size: 22.sp),
          SizedBox(width: 16.w),
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.inter(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w400),
            ),
          ),
          trailing,
        ],
      ),
    );
  }

  Widget _buildToggleSwitch({
    required String leftLabel,
    required String rightLabel,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Container(
        padding: EdgeInsets.all(4.w),
        width: 100.w,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 6.h),
                decoration: BoxDecoration(
                  color: value ? const Color(0xFF450000) : Colors.transparent,
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: Text(leftLabel, style: GoogleFonts.inter(color: Colors.white, fontSize: 10.sp, fontWeight: FontWeight.bold)),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 6.h),
                decoration: BoxDecoration(
                  color: !value ? const Color(0xFF450000) : Colors.transparent,
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: Text(rightLabel, style: GoogleFonts.inter(color: Colors.white, fontSize: 10.sp, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}