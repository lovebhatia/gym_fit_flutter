import 'package:flutter/material.dart';

class Workout {
  final String name;
  final String imageUrl;
  final List<String> exercises;

  Workout({
    required this.name,
    required this.imageUrl,
    required this.exercises,
  });
}

class WorkoutCard extends StatelessWidget {
  final Workout workout;

  WorkoutCard({required this.workout});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200, // Adjust as needed
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        color: Colors.black87,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12.0)),
              child: Image.network(
                workout.imageUrl,
                height: 150,
                width: 200,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              color: Colors.black.withOpacity(0.5),
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                workout.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            ),
            Divider(
              color: Colors.white,
              thickness: 2.0,
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Exercises:',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: workout.exercises.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      workout.exercises[index],
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HorizontalScrollableList extends StatelessWidget {
  final List<Workout> workouts;

  HorizontalScrollableList({required this.workouts});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250, // Adjust as needed
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: workouts.length,
        itemBuilder: (context, index) {
          return WorkoutCard(workout: workouts[index]);
        },
      ),
    );
  }
}
