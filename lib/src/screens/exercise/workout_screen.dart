import 'package:flutter/material.dart';
import 'package:gym_fit/src/models/beginner/beginner_model.dart';
import 'package:gym_fit/src/resources/app_colors.dart';
import 'package:gym_fit/src/resources/app_constant.dart';
import 'package:gym_fit/src/screens/beginner/beginner_day_screen.dart';
import 'package:gym_fit/src/screens/beginner/beginner_workout_screen.dart';
import 'package:gym_fit/src/screens/exercise/exercise_lib_screen.dart';
import 'package:gym_fit/src/service/exercise_service.dart';

class WorkoutGrid extends StatefulWidget {
  @override
  _WorkoutGridState createState() => _WorkoutGridState();
}

class _WorkoutGridState extends State<WorkoutGrid> {
  late List<ExerciseDay> displayedExcerciseDays = [];

  @override
  void initState() {
    super.initState();
    _fetchExerciseDays();
  }

  Future<void> _fetchExerciseDays() async {
    print('in fetch exercise');
    try {
      final fetchedExerciseDayList = await ExerciseService().fetchExerciseDay();
      print(fetchedExerciseDayList);
      setState(() {
        displayedExcerciseDays = fetchedExerciseDayList;
      });
      print("display exercise -> " + displayedExcerciseDays.toString());
    } catch (error) {
      print("Error: $error");
    }
  }

  @override
Widget build(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Text(
          'Exercises',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      const SizedBox(height: 10.0),
      GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: displayedExcerciseDays.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // Display 3 items in each row
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          childAspectRatio: 0.9, // Adjust the aspect ratio as needed
        ),
        itemBuilder: (context, index) {
          final exercise = displayedExcerciseDays[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DayWorkoutScreen(
                    selectedDay: exercise.workout!,
                    id: exercise.id.toString()!,
                  ),
                ),
              );
              print('Exercise ${exercise.workout} tapped');
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: AppColors
                          .LIGHT_BLACK, // Background color for the rounded container
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image.network(
                        '${AppConst.imageBaseUrl}${exercise.workout.toLowerCase().trim().replaceAll(' ', '')}/${exercise.imageName}',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  exercise.workout,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      ),
    ],
  );
}
}