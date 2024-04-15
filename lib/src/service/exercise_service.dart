import 'dart:convert';
import 'package:gym_fit/src/helpers/consts.dart';
import 'package:gym_fit/src/providers/baseProvider.dart';
import 'package:http/http.dart' as http;
import 'package:gym_fit/src/models/beginner/beginner_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExerciseService {
  late BaseProvider _baseProvider;

  Future<List<ExerciseDay>> fetchExerciseDay() async {
    print(1);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(2);
    final extractedUserData = json.decode(prefs.getString('userData')!);
    print(3);

    String token = extractedUserData['token'];
    print(4);
    final response = await http.get(
      Uri.parse('$DEFAULT_SERVER_PROD1/workout/allWorkouts'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      print(data);
      List<ExerciseDay> exerciseDayList =
          data.map((json) => ExerciseDay.fromJson(json)).toList();
      print(exerciseDayList);
      return exerciseDayList;
    } else {
      throw Exception('Failed to load exerciseDay');
    }
  }

  Future<List<ExercisesPerDay>> fetchExercisesPerDay(exerciseId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final extractedUserData = json.decode(prefs.getString('userData')!);

    String token = extractedUserData['token'];
    final response = await http.get(
      Uri.parse('$DEFAULT_SERVER_PROD1/exercise-day/$exerciseId/exercises/'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      print('response --> ' + response.toString());
      List<ExercisesPerDay> exercises =
          data.map((json) => ExercisesPerDay.fromJson(json)).toList();
      print('lenght' + exercises.length.toString());
      return exercises;
    } else {
      throw Exception('Failed to load exerciseDay');
    }
  }

  Future<List<WorkoutProgram>> fetchWorkoutProgram() async {
    print(1);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(2);
    final extractedUserData = json.decode(prefs.getString('userData')!);
    print(3);

    String token = extractedUserData['token'];
    print(4);
    final response = await http.get(
      Uri.parse('$DEFAULT_SERVER_PROD1/program/allPrograms'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      print(data);
      List<WorkoutProgram> workoutProgramList =
          data.map((json) => WorkoutProgram.fromJson(json)).toList();
      print(workoutProgramList);
      return workoutProgramList;
    } else {
      throw Exception('Failed to load exerciseDay');
    }
  }
}
