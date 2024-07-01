class ExercisePeruserRecordModel {
  final int id;
  final int reps;
  final double weight;
  final int set;
  final DateTime createdTime;

  ExercisePeruserRecordModel({
    required this.id,
    required this.reps,
    required this.weight,
    required this.set,
    required this.createdTime,
  });

  factory ExercisePeruserRecordModel.fromJson(Map<String, dynamic> json) {
    return ExercisePeruserRecordModel(
      id: json['id'],
      reps: json['reps'],
      weight: json['weight'],
      set: json['set'],
      createdTime: DateTime.parse(json['createdTime']),
    );
  }
}
