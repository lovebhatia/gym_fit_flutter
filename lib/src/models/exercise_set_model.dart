import 'package:gym_fit/src/models/exerciseRecordmodel.dart';

class ExercisePerUserModel {
  final int id;
  final String exerciseName;
  final DateTime createdAt;
  final List<ExercisePeruserRecordModel> exerciseSetRecords;

  ExercisePerUserModel({
    required this.id,
    required this.exerciseName,
    required this.createdAt,
    required this.exerciseSetRecords,
  });

  factory ExercisePerUserModel.fromJson(Map<String, dynamic> json) {
    var list = json['exerciseSetRecords'] as List;
    List<ExercisePeruserRecordModel> exerciseSetRecordList =
        list.map((i) => ExercisePeruserRecordModel.fromJson(i)).toList();

    return ExercisePerUserModel(
      id: json['id'],
      exerciseName: json['exerciseName'],
      createdAt: DateTime.parse(json['createdAt']),
      exerciseSetRecords: exerciseSetRecordList,
    );
  }
}
