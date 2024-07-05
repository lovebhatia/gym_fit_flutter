import 'dart:convert';
import 'package:gym_fit/src/helpers/consts.dart';
import 'package:gym_fit/src/models/exercise_set_model.dart';
import 'package:gym_fit/src/providers/baseProvider.dart';
import 'package:http/http.dart' as http;
import 'package:gym_fit/src/models/beginner/beginner_model.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExerciseService {
  late BaseProvider _baseProvider;

  Future<List<ExerciseDay>> fetchExerciseDay() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final extractedUserData = json.decode(prefs.getString('userData')!);
    String token = extractedUserData['token'];
    final response = await http.get(
      Uri.parse('$DEFAULT_SERVER_PROD1/workout/allWorkouts'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<ExerciseDay> exerciseDayList =
          data.map((json) => ExerciseDay.fromJson(json)).toList();
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
      List<ExercisesPerDay> exercises =
          data.map((json) => ExercisesPerDay.fromJson(json)).toList();
      return exercises;
    } else {
      throw Exception('Failed to load exerciseDay');
    }
  }

  Future<List<WorkoutProgram>> fetchWorkoutProgram() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final extractedUserData = json.decode(prefs.getString('userData')!);
    String token = extractedUserData['token'];
    final response = await http.get(
      Uri.parse('$DEFAULT_SERVER_PROD1/program/allPrograms'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<WorkoutProgram> workoutProgramList =
          data.map((json) => WorkoutProgram.fromJson(json)).toList();
      return workoutProgramList;
    } else {
      throw Exception('Failed to load exerciseDay');
    }
  }

  Future<void> createExerciseSet(Map<String, dynamic> data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final extractedUserData = json.decode(prefs.getString('userData')!);
    String token = extractedUserData['token'];
    final body = json.encode(data);
    print(body);

    final response = await http.post(
        Uri.parse('$DEFAULT_SERVER_PROD1/save-exercise-per-user'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: body);

    if (response.statusCode == 200) {
      print('Exercise set created successfully');
    } else {
      print('Failed to create exercise set: ${response.body}');
    }
  }

  Future<List<ExercisePerUserModel>> fetchExerciseSets(exerciseName, userID) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final extractedUserData = json.decode(prefs.getString('userData')!);
    String token = extractedUserData['token'];
    var userId = extractedUserData['userId'];
    print(userId);

    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);

    try {
      final response = await http.get(
        Uri.parse('$DEFAULT_SERVER_PROD1/exercise-per-user')
            .replace(queryParameters: {
          'userId': userId.toString(),
          'exerciseName': exerciseName,
          'date': formattedDate,
        }),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // Check if response body is not null and not empty
        if (response.body != null && response.body.isNotEmpty) {
          // Parse the response body
          List<dynamic> data = jsonDecode(response.body);
          print(response.body);
          // Check if data is a List
          if (data is List) {
            List<ExercisePerUserModel> exerciseSets = data
                .map((json) => ExercisePerUserModel.fromJson(json))
                .toList();
            print('in exercise sets');
            return exerciseSets;
          } else {
            throw Exception('Invalid response format');
          }
        } else {
          throw Exception('Empty response body');
        }
      } else {
        throw Exception('Failed to load exercise sets: ${response.statusCode}');
      }
    } catch (e) {
      print('Failed to fetch data: $e');
      throw Exception('Failed to fetch data: $e');
    }
  }
}
