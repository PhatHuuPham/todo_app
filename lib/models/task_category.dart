class TaskCategory {
  final int id;
  final String name;
  final String? description;

  TaskCategory({this.id = 0, required this.name, this.description});

  factory TaskCategory.fromJson(Map<String, dynamic> json) {
    return TaskCategory(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }
}
