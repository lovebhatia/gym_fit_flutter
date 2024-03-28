class ExerciseDay {
  final int id;
  final String name_of_day;
  final String createdDate;
  final String image;

  ExerciseDay(
      {required this.id,
      required this.name_of_day,
      required this.createdDate,
      required this.image});

  factory ExerciseDay.fromJson(Map<String, dynamic> json) {
    return ExerciseDay(
        id: json['id'],
        name_of_day: json['name_of_day'] ?? "",
        createdDate: json['created'] ?? "",
        image: json['image'] ?? "");
  }
}

class ExercisesPerDay {
  final int id;
  final String name_of_exercise;
  final String created;
  final String sets;
  final String gif;
  final String description;

  ExercisesPerDay(
      {required this.id,
      required this.name_of_exercise,
      required this.created,
      required this.sets,
      required this.gif,
      required this.description});

  factory ExercisesPerDay.fromJson(Map<String, dynamic> json) {
    return ExercisesPerDay(
      id: json['id'],
      name_of_exercise: json['name'] ?? "",
      created: json['created'] ?? "",
      sets: json['sets'] ?? "",
      gif: json['gif'] ?? "",
      description: json['description'] ?? "",
    );
  }
}
