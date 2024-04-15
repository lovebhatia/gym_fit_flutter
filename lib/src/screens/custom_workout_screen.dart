import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_fit/src/animations/transitions.dart';
import 'package:gym_fit/src/common/start_workout_card.dart';
import 'package:gym_fit/src/models/custom_workout.dart';
import 'package:gym_fit/src/resources/app_colors.dart';
import 'package:gym_fit/src/widgets/custom_workout_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomWorkoutScreen extends StatelessWidget {
  late final List<CustomWorkoutModel> workouts;

  CustomWorkoutScreen({required this.workouts});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.BLACK,
      child: SafeArea(
        child: Scaffold(
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const StartWorkoutCardWidget(),
                HorizontalScrollableList(workouts: workouts),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HorizontalScrollableList extends StatelessWidget {
  final List<CustomWorkoutModel> workouts;

  HorizontalScrollableList({required this.workouts});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600, // Adjust as needed
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: workouts.length,
        itemBuilder: (context, index) {
          return CustomWorkoutCard(workout: workouts[index]);
        },
      ),
    );
  }
}
