import 'package:flutter/material.dart';

class CustomWorkoutModel {
  final String name;
  final String imageUrl;
  final List<String> exercises;

  CustomWorkoutModel({
    required this.name,
    required this.imageUrl,
    required this.exercises,
  });
}
