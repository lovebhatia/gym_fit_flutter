import 'package:flutter/material.dart';
import 'package:gym_fit/src/models/custom_workout.dart';
import 'package:gym_fit/src/resources/app_colors.dart';

class CustomWorkoutCard extends StatelessWidget {
  final CustomWorkoutModel workout;

  const CustomWorkoutCard({super.key, required this.workout});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 5,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: Colors.white.withOpacity(
                0.5), // Set white color with opacity for the overlay
            backgroundBlendMode: BlendMode.overlay,
            /*
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(125, 144, 134, 134), // Faded black
                Color.fromARGB(255, 237, 204, 204), // Black
              ],
            ),
            */
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 100,
                child: Center(
                  child: Image.network(
                    workout.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  workout.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.black, // Black color for list background
                  child: ListView.separated(
                    itemCount: workout.exercises.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider(
                        color: Colors.white, // Adjust divider color as needed
                        thickness: 1.0, // Adjust divider thickness as needed
                        height: 1.0, // Adjust divider height as needed
                      );
                    },
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Image.network(
                          'https://storage.googleapis.com/gym_fit_buck/images/back/back_home.jpg', //workout.exercises[index].imageUrl,
                          fit: BoxFit.cover,
                          width: 50, // Adjust as needed
                        ),
                        title: const Text(
                          '', //workout.exercises[index].name,
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
