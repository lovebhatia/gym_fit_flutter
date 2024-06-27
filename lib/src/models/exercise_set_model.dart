import 'package:gym_fit/src/models/exerciseRecordmodel.dart';

class ExerciseSetmodel {
  final String exerciseName;
  final List<ExerciseRecordModel> records;
  final int exercisePerUserId;

  ExerciseSetmodel(
      {required this.exerciseName,
      required this.records,
      required this.exercisePerUserId});

  Map<String, dynamic> toJson() {
    return {
      'exerciseName': exerciseName,
      'records': records.map((record) => record.toJson()).toList(),
      'exercisePerUserId': exercisePerUserId,
    };
  }

  static ExerciseSetmodel fromJson(Map<String, dynamic> json) {
    return ExerciseSetmodel(
      exerciseName: json['exerciseName'],
      records: (json['records'] as List<dynamic>)
          .map((record) => ExerciseRecordModel.fromJson(record))
          .toList(),
      exercisePerUserId: json['exercisePerUserId'],
    );
  }
}
