import 'dart:convert';
import 'package:gym_fit/src/providers/baseProvider.dart';
import 'package:http/http.dart' as http;
import 'package:gym_fit/src/models/beginner/beginner_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BeginnerService {
  late BaseProvider _baseProvider;
  static const String _baseUrl = 'http://10.0.2.2:8000';
  static const String _authToken =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzEwMTAyMTA4LCJpYXQiOjE3MDk4ODYxMDgsImp0aSI6ImJkYWU3YjBiMGZjNjQ0MDJhMTRiOTc5M2ZkMDViY2YxIiwidXNlcl9pZCI6MSwidXNlcm5hbWUiOiJsb3ZlIiwiZW1haWwiOiJsb3ZlQGdtYWlsLmNvbSJ9.Z7UG-KjD06wuRmAfKp6Ir3inSbCotRsMzWD2tj7-n80';

  Future<List<ExerciseDay>> fetchExerciseDay() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final extractedUserData = json.decode(prefs.getString('userData')!);

    String token = extractedUserData['token'];
    final response = await http.get(
      Uri.parse('$_baseUrl/exerciseDays/'),
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
      Uri.parse('$_baseUrl/exercise-day/$exerciseId/exercises/'),
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
}
