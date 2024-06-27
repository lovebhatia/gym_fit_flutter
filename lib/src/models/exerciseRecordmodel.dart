class ExerciseRecordModel {
  final int reps;
  final double weight;
  final int index;

  ExerciseRecordModel(
      {required this.reps, required this.weight, required this.index});

  Map<String, dynamic> toJson() {
    return {
      'reps': reps,
      'weight': weight,
      'index': index,
    };
  }

  static ExerciseRecordModel fromJson(Map<String, dynamic> json) {
    return ExerciseRecordModel(
      reps: json['reps'],
      weight: json['weight'],
      index: json['index'],
    );
  }
}
