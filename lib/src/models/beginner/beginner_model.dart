import 'dart:ffi';

class ExerciseDay {
  final int id;
  final String workout;
  final String createdTime;
  final String imageName;
  final String showSequence;

  ExerciseDay(
      {required this.id,
      required this.workout,
      required this.createdTime,
      required this.imageName,
      required this.showSequence});

  factory ExerciseDay.fromJson(Map<String, dynamic> json) {
    return ExerciseDay(
        id: json['id'],
        workout: json['workout'] ?? "",
        createdTime: json['createdTime'] ?? "",
        imageName: json['imageName'] ?? "",
        showSequence: json['showSequence']);
  }
}

class ExercisesPerDay {
  final int id;
  final String exerciseName;
  final String createdTime;
  final String setRange;
  final String gifName;
  final String exerciseDescription;

  ExercisesPerDay(
      {required this.id,
      required this.exerciseName,
      required this.createdTime,
      required this.setRange,
      required this.gifName,
      required this.exerciseDescription});

  factory ExercisesPerDay.fromJson(Map<String, dynamic> json) {
    return ExercisesPerDay(
      id: json['id'],
      exerciseName: json['exerciseName'] ?? "",
      createdTime: json['createdTime'] ?? "",
      setRange: json['setRange'] ?? "",
      gifName: json['gifName'] ?? "",
      exerciseDescription: json['exerciseDescription'] ?? "",
    );
  }
}

class WorkoutProgram {
  final int id;
  final String workoutProgramName;
  final String createdTime;
  final String publishedBy;
  final String level;
  final String mainGoal;
  final String daysPerWeek;
  final String durationRange;
  final String description;
  final double rating;
  final int sequence;
  final String imageName;
  final String icon;

  WorkoutProgram(
      {required this.id,
      required this.workoutProgramName,
      required this.createdTime,
      required this.publishedBy,
      required this.level,
      required this.mainGoal,
      required this.daysPerWeek,
      required this.durationRange,
      required this.description,
      required this.rating,
      required this.sequence,
      required this.imageName,
      required this.icon});

  factory WorkoutProgram.fromJson(Map<String, dynamic> json) {
    return WorkoutProgram(
        id: json['id'],
        workoutProgramName: json['workoutProgramName'] ?? "",
        createdTime: json['createdTime'] ?? "",
        publishedBy: json['publishedBy'] ?? "",
        level: json['level'] ?? "",
        mainGoal: json['mainGoal'] ?? "",
        daysPerWeek: json['daysPerWeek'] ?? "",
        durationRange: json['durationRange'] ?? "",
        description: json['description'] ?? "",
        rating: json['rating'] ?? "",
        sequence: json['sequence'] ?? "",
        imageName: json['imageName'] ?? "",
        icon: json['icon'] ?? "");
  }
}
