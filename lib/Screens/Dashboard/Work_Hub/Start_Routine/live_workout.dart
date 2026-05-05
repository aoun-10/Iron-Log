import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iron_log/Screens/Dashboard/Work_Hub/Start_Routine/workout_summary.dart';
import 'package:iron_log/Widgets/button.dart'; 
import '../../../../Widgets/custom_button.dart';
import '../../../../Widgets/custom_paint.dart';
import '../../../../core/theme/app_color.dart';

class LiveWorkout extends StatefulWidget {
  const LiveWorkout({super.key});

  @override
  State<LiveWorkout> createState() => _LiveWorkoutState();
}

class _LiveWorkoutState extends State<LiveWorkout> {
  // --- Styling ---
  static const Color customRed = AppColors.primaryRed;
  static const Color cardBg = Color(0xFF161616);
  static const Color inputBg = Color(0xFF0F0F0F);
  static const Color textGrey = Color(0xFF8E8E8E);

  // --- Timer & Workout State ---
  Timer? _timer;
  int _seconds = 90;
  bool _isRunning = false;
  final int _targetSeconds = 120;

  List<WorkoutSet> sets = [];
  List<TextEditingController> weightControllers = [];
  List<TextEditingController> repsControllers = [];

  // --- Calculator State ---
  List<double> availablePlates = [45, 35, 25, 10, 5, 2.5];
  List<Map<String, dynamic>> customBars = [
    {"name": "Standard Bar", "weight": 45.0},
    {"name": "EZ Bar", "weight": 25.0},
  ];
  double selectedBarWeight = 45.0;

  @override
  void initState() {
    super.initState();
    _initializeDefaultSets();
  }

  void _initializeDefaultSets() {
    _addNewSetEntry("185 × 10", weight: 185, reps: 10, done: true);
    _addNewSetEntry("185 × 10", weight: 185, reps: 8, done: false);
  }

  void _addNewSetEntry(String prev, {int? weight, int? reps, bool done = false}) {
    sets.add(WorkoutSet(
      setNumber: sets.length + 1,
      previous: prev,
      weight: weight,
      reps: reps,
      isDone: done,
    ));
    weightControllers.add(TextEditingController(text: weight?.toString() ?? ""));
    repsControllers.add(TextEditingController(text: reps?.toString() ?? ""));
  }

  void _addSet() {
    setState(() {
      String lastWeight = weightControllers.isNotEmpty ? weightControllers.last.text : "";
      String lastReps = repsControllers.isNotEmpty ? repsControllers.last.text : "";
      _addNewSetEntry(
        weightControllers.isNotEmpty ? "$lastWeight × $lastReps" : "---",
        weight: int.tryParse(lastWeight),
        reps: int.tryParse(lastReps),
        done: false,
      );
    });
  }

  // --- 1. PLATE CALCULATOR BOTTOM SHEET ---
  void _showPlateCalculator(double targetWeight) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setSheetState) {
          double weightToMakeUp = (targetWeight - selectedBarWeight) / 2;
          List<double> platesNeeded = [];
          double tempWeight = weightToMakeUp;

          for (double plate in availablePlates) {
            while (tempWeight >= plate && tempWeight > 0) {
              platesNeeded.add(plate);
              tempWeight -= plate;
            }
          }

          return Container(
            height: 400.h, // Super Compact Height
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            decoration: BoxDecoration(color: cardBg, borderRadius: BorderRadius.vertical(top: Radius.circular(30.r))),
            child: Column(
              children: [
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 40.w),
                    Text("Plate Calculator", style: GoogleFonts.inter(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.bold)),
                    IconButton(onPressed: () => Get.back(), icon: Icon(Icons.check_circle, color: customRed, size: 28.sp)),
                  ],
                ),
                Text("${targetWeight.toInt()} lbs", style: GoogleFonts.inter(color: customRed, fontSize: 13.sp, fontWeight: FontWeight.w600)),
                SizedBox(height: 15.h),
                _buildDumbbellVisual(platesNeeded),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Available Equipment", style: GoogleFonts.inter(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w600)),
                    GestureDetector(
                      onTap: () => _showManageEquipment(setSheetState),
                      child: Text("Manage", style: GoogleFonts.inter(color: const Color(0xFF4A90E2), fontSize: 12.sp)),
                    ),
                  ],
                ),
                SizedBox(height: 15.h),
                _buildEquipmentRow("Plates:", availablePlates.map((p) => _buildPlateCircle(p)).toList()),
                SizedBox(height: 12.h),
                _buildEquipmentRow("Bar:", customBars.map((bar) => _buildBarCapsule(bar, setSheetState)).toList()),
              ],
            ),
          );
        },
      ),
    );
  }

  // --- 2. MANAGE EQUIPMENT SHEET ---
  void _showManageEquipment(StateSetter parentState) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setManageState) => Container(
          height: 460.h,
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(color: cardBg, borderRadius: BorderRadius.vertical(top: Radius.circular(30.r))),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(onTap: () => Get.back(), child: Icon(Icons.arrow_back_ios, color: Colors.white, size: 18.sp)),
                  Text("Manage Equipment", style: GoogleFonts.inter(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.bold)),
                  IconButton(onPressed: () => Get.back(), icon: Icon(Icons.check_circle, color: customRed, size: 26.sp)),
                ],
              ),
              Expanded(
                child: ListView(
                  children: [
                    _manageHeader("Bars", () => _showAddCustom("Bar", setManageState, parentState)),
                    ...customBars.map((bar) => _manageItemTile(bar['name'], "${bar['weight']} lbs", () {
                      setState(() => customBars.remove(bar));
                      setManageState(() {}); parentState(() {});
                    })),
                    SizedBox(height: 15.h),
                    _manageHeader("Plates", () => _showAddCustom("Plate", setManageState, parentState)),
                    ...availablePlates.map((p) => _manageItemTile("$p lbs", "Standard Plate", () {
                      setState(() => availablePlates.remove(p));
                      setManageState(() {}); parentState(() {});
                    })),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- 3. ADD CUSTOM ITEM SHEET ---
  void _showAddCustom(String type, StateSetter manageState, StateSetter calcState) {
    TextEditingController nC = TextEditingController();
    TextEditingController wC = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 30.h),
          decoration: BoxDecoration(color: inputBg, borderRadius: BorderRadius.vertical(top: Radius.circular(30.r))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 30.w),
                  Text("Add New $type", style: GoogleFonts.inter(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.bold)),
                  IconButton(
                    onPressed: () {
                      double? w = double.tryParse(wC.text);
                      if (w != null) {
                        setState(() {
                          if (type == "Bar") {
                            customBars.add({"name": nC.text.isEmpty ? "Custom Bar" : nC.text, "weight": w});
                          } else { availablePlates.add(w); availablePlates.sort((a, b) => b.compareTo(a)); }
                        });
                        manageState(() {}); calcState(() {}); Get.back();
                      }
                    },
                    icon: Icon(Icons.check_circle, color: customRed, size: 28.sp),
                  ),
                ],
              ),
              _customInput("Name (Optional)", nC),
              SizedBox(height: 12.h),
              _customInput("Weight (lbs)", wC, isNum: true),
            ],
          ),
        ),
      ),
    );
  }

  // --- UI WIDGETS ---

  Widget _buildEquipmentRow(String label, List<Widget> items) {
    return Row(
      children: [
        Text(label, style: GoogleFonts.inter(color: textGrey, fontSize: 11.sp)),
        SizedBox(width: 10.w),
        Expanded(child: SizedBox(height: 35.h, child: ListView(scrollDirection: Axis.horizontal, children: items))),
      ],
    );
  }

  Widget _buildDumbbellVisual(List<double> plates) {
    return SizedBox(
      height: 70.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(width: 35.w, height: 5.h, decoration: BoxDecoration(color: const Color(0xFF333333), borderRadius: BorderRadius.circular(2))),
          Container(width: 5.w, height: 35.h, color: const Color(0xFF444444)),
          ...plates.map((p) => Container(
            margin: EdgeInsets.symmetric(horizontal: 1.w),
            width: 10.w,
            height: (35 + (p * 0.6)).h.clamp(25.h, 60.h),
            decoration: BoxDecoration(color: customRed, borderRadius: BorderRadius.circular(3.r)),
            child: Center(child: RotatedBox(quarterTurns: 1, child: Text("${p.toInt()}", style: TextStyle(color: Colors.white, fontSize: 7.sp, fontWeight: FontWeight.bold)))),
          )),
          Container(width: 15.w, height: 5.h, decoration: BoxDecoration(color: const Color(0xFF333333), borderRadius: BorderRadius.circular(2))),
        ],
      ),
    );
  }

  Widget _buildPlateCircle(double weight) {
    return Container(
      margin: EdgeInsets.only(right: 8.w),
      width: 35.w,
      height: 35.w,
      decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: customRed.withValues(alpha:0.4)), color: customRed.withValues(alpha:0.05)),
      child: Center(child: Text("${weight.toInt()}", style: TextStyle(color: Colors.white, fontSize: 10.sp, fontWeight: FontWeight.bold))),
    );
  }

  Widget _buildBarCapsule(Map<String, dynamic> bar, StateSetter setState) {
    bool isSelected = selectedBarWeight == bar['weight'];
    return GestureDetector(
      onTap: () => setState(() => selectedBarWeight = bar['weight']),
      child: Container(
        margin: EdgeInsets.only(right: 10.w),
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        decoration: BoxDecoration(color: isSelected ? customRed : Colors.transparent, borderRadius: BorderRadius.circular(20.r), border: Border.all(color: isSelected ? customRed : Colors.white12)),
        child: Center(child: Text("${bar['name']} (${bar['weight'].toInt()})", style: TextStyle(color: Colors.white, fontSize: 10.sp))),
      ),
    );
  }

  Widget _manageItemTile(String title, String sub, VoidCallback onDel) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(color: Colors.white.withValues(alpha:0.03), borderRadius: BorderRadius.circular(10.r)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: TextStyle(color: Colors.white, fontSize: 13.sp, fontWeight: FontWeight.w500)),
            Text(sub, style: TextStyle(color: textGrey, fontSize: 10.sp)),
          ]),
          GestureDetector(onTap: onDel, child: Icon(Icons.close, color: customRed.withValues(alpha:0.7), size: 18.sp)),
        ],
      ),
    );
  }

  Widget _manageHeader(String title, VoidCallback onAdd) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(color: customRed, fontWeight: FontWeight.bold, fontSize: 14.sp)),
          GestureDetector(onTap: onAdd, child: Text("+ Add Custom", style: TextStyle(color: const Color(0xFF4A90E2), fontSize: 11.sp))),
        ],
      ),
    );
  }

  Widget _customInput(String hint, TextEditingController c, {bool isNum = false}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      decoration: BoxDecoration(color: cardBg, borderRadius: BorderRadius.circular(12.r), border: Border.all(color: Colors.white10)),
      child: TextField(
        controller: c,
        keyboardType: isNum ? TextInputType.number : TextInputType.text,
        style: TextStyle(color: Colors.white, fontSize: 14.sp),
        decoration: InputDecoration(hintText: hint, hintStyle: TextStyle(color: Colors.white24, fontSize: 13.sp), border: InputBorder.none),
      ),
    );
  }

  // --- TIMER & MAIN SCREEN LOGIC ---
  void _toggleTimer() {
    if (_isRunning) { _timer?.cancel(); }
    else { _timer = Timer.periodic(const Duration(seconds: 1), (timer) { setState(() => _seconds++); }); }
    setState(() => _isRunning = !_isRunning);
  }

  void _resetTimer() { _timer?.cancel(); setState(() { _seconds = 0; _isRunning = false; }); }

  String _formatTime(int seconds) {
    int h = seconds ~/ 3600;
    int m = (seconds % 3600) ~/ 60;
    int s = seconds % 60;
    return "${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}";
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var c in weightControllers) {c.dispose();}
    for (var c in repsControllers) {c.dispose();}
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double progressPercent = (_seconds / _targetSeconds).clamp(0.0, 1.0);

    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leadingWidth: 70.w,
        toolbarHeight: 80.h,
        leading: Padding(
          padding: EdgeInsets.only(left: 20.w, top: 10.h),
          child:CustomButton(
            onTap: (){
              Get.back();
            },),
        ),
        title: Padding(
          padding: EdgeInsets.only(top: 15.h),
          child: Text("Start Your Workout", style: GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.w500, color: Colors.white)),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 5.h),
            Text("LIVE WORKOUT", style: GoogleFonts.quattrocento(fontSize: 30.sp, fontWeight: FontWeight.bold, color: Colors.white)),
            SizedBox(height: 15.h),
            _buildTimerCard(progressPercent),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Set Log", style: GoogleFonts.quattrocento(fontSize: 22.sp, fontWeight: FontWeight.bold, color: Colors.white)),
                Row(
                  children: [
                    _buildTopActionBtn(Icons.add, "Add Set", _addSet, isPrimary: true),
                    SizedBox(width: 8.w),
                    _buildTopActionBtn(Icons.calculate_outlined, "Calculate", () {
                      double target = weightControllers.isNotEmpty ? (double.tryParse(weightControllers.last.text) ?? 135.0) : 135.0;
                      _showPlateCalculator(target);
                    }),
                  ],
                ),
              ],
            ),
            SizedBox(height: 15.h),
            _buildTableHeader(),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(top: 10.h, bottom: 20.h),
                itemCount: sets.length,
                itemBuilder: (context, index) => _buildSetRow(index),
              ),
            ),
            Button(
                onTap: () => Get.to(WorkoutSummary()), label: "Finish"),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }

  // --- Main Screen Sub-Widgets ---
  Widget _buildTopActionBtn(IconData icon, String label, VoidCallback onTap, {bool isPrimary = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
        decoration: BoxDecoration(
            color: isPrimary ? customRed.withValues(alpha:0.15)
                : customRed.withValues(alpha:0.15),
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: customRed.withValues(alpha:0.4))),
        child: Row(children: [Icon(icon,
            color: isPrimary ? Colors.white : customRed,
            size: 14.sp), SizedBox(width: 4.w),
          Text(label, style: GoogleFonts.inter(color: isPrimary ? Colors.white : Colors.white,
              fontSize: 11.sp, fontWeight: FontWeight.w600))]),
      ),
    );
  }

  Widget _buildTableHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Row(
        children: [
          Expanded(flex: 1, child: Text("SET", style: _headerStyle())),
          Expanded(flex: 2, child: Text("PREVIOUS", style: _headerStyle())),
          Expanded(flex: 2, child: Text("LBS", style: _headerStyle(), textAlign: TextAlign.center)),
          Expanded(flex: 2, child: Text("REPS", style: _headerStyle(), textAlign: TextAlign.center)),
          Expanded(flex: 1, child: Text("DONE", style: _headerStyle(), textAlign: TextAlign.right)),
        ],
      ),
    );
  }

  Widget _buildTimerCard(double progress) {
    return Container(
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(color: cardBg,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: Colors.white.withValues(alpha: 0.05))),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("REST TIMER", style: GoogleFonts.inter(color: customRed, fontSize: 10.sp, fontWeight: FontWeight.w900)),
                  Text(_formatTime(_seconds), style: GoogleFonts.inter(fontSize: 32.sp, fontWeight: FontWeight.bold, color: Colors.white)),
                ],
              ),
              Column(
                children: [
                  _timerButton(_isRunning ? "STOP" : "START", _isRunning ? Icons.stop : Icons.play_arrow, _isRunning ? [customRed, const Color(0xFF5A0504)] : [Colors.green, const Color(0xFF0E3211)], _toggleTimer),
                  SizedBox(height: 8.h),
                  _timerButton("RESET", null, [const Color(0xFF252525), const Color(0xFF252525)], _resetTimer),
                ],
              )
            ],
          ),
          SizedBox(height: 12.h),
          LinearProgressIndicator(value: progress, backgroundColor: Colors.white12, color: customRed, minHeight: 4.h, borderRadius: BorderRadius.circular(10.r)),
        ],
      ),
    );
  }

  Widget _timerButton(String label, IconData? icon, List<Color> colors, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 90.w, padding: EdgeInsets.symmetric(vertical: 6.h),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.r), gradient: LinearGradient(colors: colors, begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [if (icon != null) Icon(icon, color: Colors.white, size: 12.sp), SizedBox(width: 4.w), Text(label, style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11.sp))]),
      ),
    );
  }

  Widget _buildSetRow(int index) {
    final set = sets[index];
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      decoration: BoxDecoration(color: cardBg,
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(color: set.isDone ? customRed.withValues(alpha: 0.4) : Colors.white.withValues(alpha: 0.05))),
      child: Row(
        children: [
          Expanded(flex: 1, child: Text("${index + 1}", style: GoogleFonts.inter(color: set.isDone ? customRed : Colors.white, fontWeight: FontWeight.w900, fontSize: 16.sp))),
          Expanded(flex: 2, child: Text(set.previous, style: GoogleFonts.inter(color: Colors.white38, fontSize: 11.sp))),
          Expanded(flex: 2, child: _buildDataInput(weightControllers[index])),
          SizedBox(width: 8.w),
          Expanded(flex: 2, child: _buildDataInput(repsControllers[index])),
          SizedBox(width: 12.w),
          GestureDetector(
            onTap: () => setState(() => set.isDone = !set.isDone),
            child: Container(
              width: 26.w, height: 26.h,
              decoration: BoxDecoration(color: set.isDone ? customRed : inputBg, borderRadius: BorderRadius.circular(8.r), border: Border.all(color: set.isDone ? customRed : Colors.white10)),
              child: set.isDone ? Icon(Icons.check, color: Colors.white, size: 16.sp) : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataInput(TextEditingController controller) {
    return Container(
      height: 30.h,
      decoration: BoxDecoration(color: inputBg, borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: Colors.white.withValues(alpha: 0.08))),
      child: Center(child: TextField(controller: controller,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          cursorColor: customRed,
          style: GoogleFonts.inter(color: Colors.white,
              fontWeight: FontWeight.bold, fontSize: 13.sp),
          decoration: InputDecoration(isDense: true,
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
              hintText: "---", hintStyle: TextStyle(color: Colors.white24, fontSize: 12.sp)))),
    );
  }

  TextStyle _headerStyle() => GoogleFonts.inter(color: customRed,
      fontSize: 9.sp, fontWeight: FontWeight.w800, letterSpacing: 0.5);
}

class WorkoutSet {
  final int setNumber;
  final String previous;
  int? weight;
  int? reps;
  bool isDone;
  WorkoutSet({required this.setNumber, required this.previous, this.weight, this.reps, this.isDone = false});
}