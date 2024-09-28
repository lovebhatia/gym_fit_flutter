import 'package:flutter/material.dart';

import '../../resources/app_colors.dart';


class BeginnerStartWorkoutScreen extends StatelessWidget {
  final List<ExercisePerWorkoutModel> exercisePerWorkoutList;
  final String selectedWorkout;

  BeginnerStartWorkoutScreen({
    required this.exercisePerWorkoutList,
    required this.selectedWorkout,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.DARK_PURPLE,
            AppColors.BRIGHT_PURPLE,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Custom back button and title (instead of AppBar)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    Expanded(
                      child: Text(
                        selectedWorkout,
                        textAlign: TextAlign.center, // Center the title
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 48), // Placeholder to balance the row
                  ],
                ),
                const SizedBox(height: 20),

                // Workout header with icon
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Workout Exercises',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Icon(
                      Icons.fitness_center,
                      color: Colors.white,
                      size: 30,
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Rounded container for the workout list
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1), // Semi-transparent for better visibility
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: BegWorkoutWidget(
                      workoutExercises: exercisePerWorkoutList,
                      selectedWorkout: selectedWorkout,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
