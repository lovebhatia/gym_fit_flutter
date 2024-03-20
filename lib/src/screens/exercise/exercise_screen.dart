import 'package:flutter/material.dart';

class ExerciseGrid extends StatelessWidget {
  final List<Map<String, String>> exercises = [
    {
      'name': 'Exercise 1',
      'description': 'Description for Exercise 1',
      'image':
          'https://storage.googleapis.com/gym_fit_buck/images/tricep/tricep_home.jpg',
    },
    {
      'name': 'Exercise 2',
      'description': 'Description for Exercise 2',
      'image':
          'https://storage.googleapis.com/gym_fit_buck/images/biceps/bicep_home.jpg',
    },
    {
      'name': 'Exercise 3',
      'description': 'Description for Exercise 3',
      'image':
          'https://storage.googleapis.com/gym_fit_buck/gif/back/BarLateralPullDown.gif',
    },
    {
      'name': 'Exercise 4',
      'description': 'Description for Exercise 4',
      'image':
          'https://storage.googleapis.com/gym_fit_buck/images/chest/chest_home.jpg',
    },
    {
      'name': 'Exercise 5',
      'description': 'Description for Exercise 5',
      'image':
          'https://storage.googleapis.com/gym_fit_buck/gif/back/BarLateralPullDown.gif',
    },
    {
      'name': 'Exercise 6',
      'description': 'Description for Exercise 6',
      'image':
          'https://storage.googleapis.com/gym_fit_buck/gif/back/BarLateralPullDown.gif',
    },
    {
      'name': 'Exercise 7',
      'description': 'Description for Exercise 7',
      'image':
          'https://storage.googleapis.com/gym_fit_buck/gif/back/BarLateralPullDown.gif',
    },
    {
      'name': 'Exercise 8',
      'description': 'Description for Exercise 8',
      'image':
          'https://storage.googleapis.com/gym_fit_buck/gif/back/BarLateralPullDown.gif',
    },
    {
      'name': 'Exercise 9',
      'description': 'Description for Exercise 9',
      'image':
          'https://storage.googleapis.com/gym_fit_buck/gif/back/BarLateralPullDown.gif',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Exercises',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 10.0),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: exercises.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // Display 3 items in each row
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            childAspectRatio: 1.0,
          ),
          itemBuilder: (context, index) {
            final exercise = exercises[index];
            return GestureDetector(
              onTap: () {
                // Handle onTap event, e.g., show more details about the exercise
                print('Exercise ${exercise['name']} tapped');
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: Colors.grey[
                            300], // Background color for the rounded container
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Image.network(
                          exercise['image']!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Center(
                    child: Text(
                      exercise['name']!,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
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
