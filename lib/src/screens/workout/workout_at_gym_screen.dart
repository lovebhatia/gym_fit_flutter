import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym_fit/src/models/beginner/beginner_model.dart';
import 'package:gym_fit/src/models/custom_workout.dart';
import 'package:gym_fit/src/screens/custom_workout_screen.dart';
import 'package:gym_fit/src/screens/exercise/workout_screen.dart';
import 'package:gym_fit/src/service/exercise_service.dart';

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
  late List<WorkoutProgram> displayedWorkoutProgram = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchWorkoutProgram();
  }

  // Define a mapping of workout program names to corresponding methods or routes

  Future<void> _fetchWorkoutProgram() async {
    print('in fetch program');
    try {
      final fetchedWorkoutProgram =
          await ExerciseService().fetchWorkoutProgram();
      setState(() {
        displayedWorkoutProgram = fetchedWorkoutProgram;
      });
      print("Workout Program" + displayedWorkoutProgram.length.toString());
    } catch (error) {
      print("error " + error.toString());
    }
  }

  final Map<String, IconData> backendIconMapping = {
    'Push/Pull/Legs': Icons.fitness_center,
    'Full Body': Icons.accessibility,
    'Upper/Lower Split': Icons.swap_vert,
    'Body Part Split': Icons.filter_frames,
    'Cardiovascular': Icons.directions_run,
    'Flexibility and Mobility': Icons.self_improvement,
    'HIIT': Icons.timer,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BLACK,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: AppColors.BLACK,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 10.h),
          color: AppColors.BLACK,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WorkoutGrid(),
              SizedBox(height: 20.h),
              Column(
                children: displayedWorkoutProgram.asMap().entries.map((entry) {
                  int index = entry.key; // Index of the element
                  WorkoutProgram workout = entry.value; // Element of the list
                  String backendIconName = workout
                      .workoutProgramName; // Use the backend icon name here
                  IconData iconData = backendIconMapping[backendIconName] ??
                      Icons.error; // Retrieve the corresponding IconData
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          SlideLeftTransition(
                            CustomWorkoutScreen(
                              workouts: [
                                CustomWorkoutModel(
                                  name: 'Workout 1',
                                  imageUrl:
                                      'https://storage.googleapis.com/gym_fit_buck/images/back/back_home.jpg',
                                  exercises: [
                                    'Exercise 1',
                                    'Exercise 2',
                                    'Exercise 3'
                                  ],
                                ),
                                CustomWorkoutModel(
                                  name: 'Workout 2',
                                  imageUrl: 'https://example.com/workout2.jpg',
                                  exercises: [
                                    'Exercise A',
                                    'Exercise B',
                                    'Exercise C'
                                  ],
                                ),
                                // Add more workouts as needed
                              ],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: 0.2.sh, // Set height as 20% of screen height
                        padding: EdgeInsets.all(10.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: const LinearGradient(
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
                          mainAxisAlignment: MainAxisAlignment
                              .spaceBetween, // Adjust vertical alignment
                          children: [
                            Row(
                              children: [
                                Icon(iconData, color: Colors.white),
                                // Add main goal icon
                                SizedBox(
                                    width: 10
                                        .w), // Add spacing between icon and text
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      workout
                                          .workoutProgramName, // Display the "Main Goal" label
                                      style: GoogleFonts.lato(
                                        textStyle: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                                height: 6
                                    .h), // Add spacing between title and content
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(Icons.calendar_today,
                                              color: Colors
                                                  .white), // Add calendar icon
                                          SizedBox(
                                              width: 10
                                                  .w), // Add spacing between icon and text
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Days per week', // Display the "Days per week" label
                                                style: GoogleFonts.lato(
                                                  textStyle: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.white,
                                                    fontSize: 14.sp,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                '3', // Display the value of "Days per week"
                                                style: GoogleFonts.lato(
                                                  textStyle: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.white,
                                                    fontSize: 12.sp,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10.h),
                                      Row(
                                        children: [
                                          const Icon(Icons.star,
                                              color: Colors
                                                  .white), // Add main goal icon
                                          SizedBox(
                                              width: 10
                                                  .w), // Add spacing between icon and text
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Main Goal', // Display the "Main Goal" label
                                                style: GoogleFonts.lato(
                                                  textStyle: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.white,
                                                    fontSize: 14.sp,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                workout
                                                    .mainGoal, // Display the value of "Main Goal"
                                                style: GoogleFonts.lato(
                                                  textStyle: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.white,
                                                    fontSize: 12.sp,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                    width: 35
                                        .w), // Add gap between left and right columns
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(Icons.access_time,
                                              color: Colors
                                                  .white), // Add duration icon
                                          SizedBox(
                                              width: 5
                                                  .w), // Add spacing between icon and text
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Duration', // Display the "Duration" label
                                                style: GoogleFonts.lato(
                                                  textStyle: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.white,
                                                    fontSize: 14.sp,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                workout
                                                    .durationRange, // Display the value of "Duration"
                                                style: GoogleFonts.lato(
                                                  textStyle: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.white,
                                                    fontSize: 12.sp,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10.h),
                                      Row(
                                        children: [
                                          const Icon(Icons.bar_chart,
                                              color: Colors
                                                  .white), // Add level icon
                                          SizedBox(
                                              width: 10
                                                  .w), // Add spacing between icon and text
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Level', // Display the "Level" label
                                                style: GoogleFonts.lato(
                                                  textStyle: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.white,
                                                    fontSize: 14.sp,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                workout
                                                    .level, // Display the value of "Level"
                                                style: GoogleFonts.lato(
                                                  textStyle: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.white,
                                                    fontSize: 12.sp,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),

              /*   
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
              */
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
