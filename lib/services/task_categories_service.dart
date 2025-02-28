import 'package:flutter/material.dart';
import 'package:todo_app/models/task_category.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TaskCategoriesService extends ChangeNotifier {
  static const String baseUrl = "http://localhost:3000";

  Future<List<TaskCategory>> getTaskCategories() async {
    // Fetch data from API
    final response = await http.get(Uri.parse('$baseUrl/task_categories'));
    if (response.statusCode == 200) {
      final List<dynamic> taskCategoryJson = json.decode(response.body);
      return taskCategoryJson
          .map((json) => TaskCategory.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load task categories');
    }
  }
}
