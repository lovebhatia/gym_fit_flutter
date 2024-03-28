import 'package:flutter/material.dart';
import 'package:gym_fit/src/models/beginner/beginner_model.dart';
import 'package:gym_fit/src/resources/app_colors.dart';
import 'package:gym_fit/src/resources/app_constant.dart';
import 'package:gym_fit/src/service/exercise_service.dart';

class ExerciseGrid extends StatefulWidget {
  @override
  _ExerciseGridState createState() => _ExerciseGridState();
}

class _ExerciseGridState extends State<ExerciseGrid> {
  late List<ExerciseDay> displayedExerciseDays = [];

  @override
  void initState() {
    super.initState();
    _fetchExerciseDays();
  }

  Future<void> _fetchExerciseDays() async {
    try {
      final fetchedExerciseDayList = await ExerciseService().fetchExerciseDay();
      setState(() {
        displayedExerciseDays = fetchedExerciseDayList;
      });
    } catch (error) {
      print("Error: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercises'),
      ),
      body: GridView.count(
        crossAxisCount: 2, // 2 cards in each row
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        children: displayedExerciseDays.map((exercise) {
          return ExerciseCard(exercise: exercise);
        }).toList(),
      ),
      backgroundColor: AppColors.LIGHT_BLACK,
    );
  }
}

class ExerciseCard extends StatelessWidget {
  final ExerciseDay exercise;

  const ExerciseCard({Key? key, required this.exercise}) : super(key: key);

  @override
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ExerciseDetailsScreen(exercise: exercise),
          ),
        );
      },
      child: Padding(
        padding:
            const EdgeInsets.only(top: 10.0), // Add padding only to the top
        child: AspectRatio(
          aspectRatio: 8.0,
          child: Container(
            decoration: BoxDecoration(
              color: Colors
                  .black, // Set the background color of the container to black
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(
                  color:
                      Colors.white), // Add a white border around the container
            ),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 4,
              color: Colors.transparent, // Set the card color to transparent
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Image.network(
                          '${AppConst.imageBaseUrl}${exercise.name_of_day.toLowerCase().trim().replaceAll(' ', '')}/${exercise.image}',
                          height: double
                              .infinity, // Make the image fill the available height
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        IconButton(
                          onPressed: () {
                            // Implement functionality to save or mark as favorite
                            print('Exercise ${exercise.name_of_day} saved');
                          },
                          icon: Icon(Icons.star_border),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      exercise.name_of_day!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white, // Set the text color to white
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      'Workout Name',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ExerciseDetailsScreen extends StatelessWidget {
  final ExerciseDay exercise;

  const ExerciseDetailsScreen({Key? key, required this.exercise})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(exercise.name_of_day!),
      ),
      body: Center(
        child: Text('Exercise details go here'),
      ),
    );
  }
}
