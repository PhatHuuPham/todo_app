import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todo_app/models/task.dart';

class TaskService extends ChangeNotifier {
  static const String baseUrl = "http://localhost:3000";

  Future<List<Task>> getTasks() async {
    // Fetch data from API
    final response = await http.get(Uri.parse('$baseUrl/tasks'));
    if (response.statusCode == 200) {
      final List<dynamic> taskJson = json.decode(response.body);
      return taskJson.map((json) => Task.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  Future<List<Task>> getTasksByUserId(int userId) async {
    // Fetch data from API
    final response = await http.get(Uri.parse('$baseUrl/tasks/user/$userId'));
    if (response.statusCode == 200) {
      final List<dynamic> taskJson = json.decode(response.body);
      return taskJson.map((json) => Task.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  Future<Task> getTask(int id) async {
    // Fetch data from API
    final response = await http.get(Uri.parse('$baseUrl/tasks/$id'));
    if (response.statusCode == 200) {
      return Task.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load task');
    }
  }

  Future<Task> createTask(Task task) async {
    final response = await http.post(
      Uri.parse('$baseUrl/tasks'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'title': task.title,
        'description': task.description,
        if (task.dueDate != null) 'due_date': task.dueDate!.toIso8601String(),
        'status': task.status,
        'priority': task.priority,
        if (task.categoryId != null) 'category_id': task.categoryId,
        if (task.userId != null) 'user_id': task.userId, // Thêm user_id nếu có
      }),
    );

    if (response.statusCode == 201) {
      return Task.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create task: ${response.body}');
    }
  }

  Future<Task> updateTask(Task task) async {
    // Fetch data from API
    final response = await http.put(
      Uri.parse('$baseUrl/tasks/${task.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'title': task.title,
        'description': task.description,
        if (task.dueDate != null) 'due_date': task.dueDate!.toIso8601String(),
        'status': task.status,
        'priority': task.priority,
        if (task.categoryId != null) 'category_id': task.categoryId,
        if (task.userId != null) 'user_id': task.userId, // Thêm user_id nếu có
      }),
    );
    return response.statusCode == 200
        ? Task.fromJson(json.decode(response.body))
        : throw Exception('Failed to update task');
  }

  Future<void> deleteTask(int id) async {
    // Fetch data from API
    final response = await http.delete(Uri.parse('$baseUrl/tasks/$id'));
    if (response.statusCode != 204) {
      throw Exception('Failed to delete task');
    }
  }

  Future<void> updateTaskStatus(int id, String status) async {
    // Fetch data from API
    final response = await http.put(
      Uri.parse('$baseUrl/tasks/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'status': status}),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update task status');
    }
  }
}
