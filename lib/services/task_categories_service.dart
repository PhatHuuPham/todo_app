import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todo_app/models/task_category.dart';

class TaskCategoriesService extends ChangeNotifier {
  static const String baseUrl = "http://localhost:3000";

  Future<List<TaskCategory>> getTasks() async {
    // Fetch data from API
    final response = await http.get(Uri.parse('$baseUrl/task_categories'));
    if (response.statusCode == 200) {
      final List<dynamic> taskJson = json.decode(response.body);
      return taskJson.map((json) => TaskCategory.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  Future<TaskCategory> getTask(int id) async {
    // Fetch data from API
    final response = await http.get(Uri.parse('$baseUrl/task_categories/$id'));
    if (response.statusCode == 200) {
      return TaskCategory.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load task');
    }
  }

  Future<TaskCategory> createTask(TaskCategory taskCategory) async {
    final response = await http.post(
      Uri.parse('$baseUrl/task_categories'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          {'name': taskCategory.name, 'description': taskCategory.description}),
    );

    if (response.statusCode == 201) {
      return TaskCategory.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create task: ${response.body}');
    }
  }

  Future<TaskCategory> updateTask(TaskCategory taskCategory) async {
    // Fetch data from API
    final response = await http.put(
      Uri.parse('$baseUrl/task_categories/${taskCategory.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'title': taskCategory.name,
        'description': taskCategory.description,
      }),
    );
    return response.statusCode == 200
        ? TaskCategory.fromJson(json.decode(response.body))
        : throw Exception('Failed to update task');
  }

  Future<void> deleteTask(int id) async {
    // Fetch data from API
    final response =
        await http.delete(Uri.parse('$baseUrl/task_categories/$id'));
    if (response.statusCode != 204) {
      throw Exception('Failed to delete task');
    }
  }
}
