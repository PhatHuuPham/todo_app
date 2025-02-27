class Task {
  final int id; // Có thể null khi tạo mới
  final int? userId;
  final String title;
  final String description;
  final int? categoryId;
  final DateTime? dueDate;
  final String status;
  final String priority;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Task({
    this.id = 0,
    this.userId,
    this.title = '',
    this.description = '',
    this.categoryId,
    this.dueDate,
    this.status = 'pending',
    this.priority = 'medium',
    this.createdAt,
    this.updatedAt,
  });

  // Chuyển từ JSON về object Task
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      userId: json['user_id'],
      title: json['title'],
      description: json['description'],
      categoryId: json['category_id'],
      dueDate:
          json['due_date'] != null ? DateTime.parse(json['due_date']) : null,
      status: json['status'],
      priority: json['priority'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
