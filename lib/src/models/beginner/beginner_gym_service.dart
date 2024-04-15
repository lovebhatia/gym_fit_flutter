import 'dart:convert';
import 'package:gym_fit/src/helpers/consts.dart';
import 'package:gym_fit/src/providers/baseProvider.dart';
import 'package:http/http.dart' as http;
import 'package:gym_fit/src/models/beginner/beginner_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BeginnerService {
  late BaseProvider _baseProvider;

  Future<List<ExerciseDay>> fetchExerciseDay() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('3');
    final extractedUserData = json.decode(prefs.getString('userData')!);
    print('1');
    String token = extractedUserData['token'];
    final response = await http.get(
      Uri.parse('$DEFAULT_SERVER_PROD1/workout/allWorkouts'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
    print('2');
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<ExerciseDay> exerciseDayList =
          data.map((json) => ExerciseDay.fromJson(json)).toList();
      print('3');
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
      Uri.parse('$DEFAULT_SERVER_PROD1/workout/exercise/$exerciseId'),
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
