import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym_fit/src/screens/exercise/exercise_screen.dart';

import '../../animations/transitions.dart';
import '../../resources/app_colors.dart';
import '../beginner/beginner_workout_screen.dart';
import '../intermediate/intermediate_workout_screen.dart';
import '../advanced/advanced_workout_screen.dart';
import '../BMI/BMIScreen.dart';

class WorkoutAtGymScreen extends StatefulWidget {
  @override
  _WorkoutAtGymScreenState createState() => _WorkoutAtGymScreenState();
}

class _WorkoutAtGymScreenState extends State<WorkoutAtGymScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BLACK,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: AppColors.BLACK,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
          color: AppColors.BLACK,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ExerciseGrid(),
              SizedBox(height: 20.h),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    SlideLeftTransition(
                      BeginnerWorkout(),
                    ),
                  );
                },
                child: Container(
                  height: 0.2.sh, // Set height as 20% of screen height
                  padding: EdgeInsets.all(10.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      colors: [
                        Color(0xff8E2DE2),
                        Color(0xff4A00E0),
                      ],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                    ),
                  ),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Beginner',
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            fontSize: 22.sp,
                          ),
                        ),
                      ),
                      Text(
                        'For Fat Loss',
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontSize: 18.sp,
                          ),
                        ),
                      ),
                      Text(
                        '30 Days',
                        style: GoogleFonts.teko(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontSize: 25.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    SlideLeftTransition(
                      IntermediateScreen(),
                    ),
                  );
                },
                child: Container(
                  height: 0.2.sh, // Set height as 20% of screen height
                  padding: EdgeInsets.all(10.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      colors: [
                        Color(0xff8E2DE2),
                        Color(0xff4A00E0),
                      ],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                    ),
                  ),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'INTERMEDIATE',
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            fontSize: 22.sp,
                          ),
                        ),
                      ),
                      Text(
                        'For Fat Loss',
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontSize: 18.sp,
                          ),
                        ),
                      ),
                      Text(
                        '30 Days',
                        style: GoogleFonts.teko(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontSize: 25.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    SlideLeftTransition(
                      AdvancedScreen(),
                    ),
                  );
                },
                child: Container(
                  height: 0.2.sh, // Set height as 20% of screen height
                  padding: EdgeInsets.all(10.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      colors: [
                        Color(0xff8E2DE2),
                        Color(0xff4A00E0),
                      ],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                    ),
                  ),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'ADVANCED',
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            fontSize: 22.sp,
                          ),
                        ),
                      ),
                      Text(
                        'For Toned Body',
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontSize: 18.sp,
                          ),
                        ),
                      ),
                      Text(
                        '30 Days',
                        style: GoogleFonts.teko(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontSize: 25.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
