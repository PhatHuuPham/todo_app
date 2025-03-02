import 'package:flutter/material.dart';
import 'package:todo_app/services/task_categories_service.dart';

import '../models/task_category.dart';

class TaskCategoryViewmodel extends ChangeNotifier {
  TaskCategoryViewmodel() {
    fetchTasksCategory();
  }

  List<TaskCategory> _taskCategories = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<TaskCategory> get taskCategories => _taskCategories;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchTasksCategory() async {
    _isLoading = true;
    notifyListeners();
    try {
      _taskCategories = await TaskCategoriesService().getTasks();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
    }
    notifyListeners();
  }

  Future<void> createTaskCategory(TaskCategory taskCategory) async {
    _isLoading = true;
    try {
      await TaskCategoriesService().createTask(taskCategory);
      _errorMessage = '';
    } catch (e) {
      _errorMessage = 'Failed to create task category: ${e.toString()}';
      throw _errorMessage; // Re-throw to handle in UI
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateTaskCategory(TaskCategory taskCategory) async {
    try {
      await TaskCategoriesService().updateTask(taskCategory);
      fetchTasksCategory();
    } catch (e) {
      _errorMessage = e.toString();
    }
  }

  Future<void> deleteTaskCategory(int id) async {
    try {
      await TaskCategoriesService().deleteTask(id);
      fetchTasksCategory();
    } catch (e) {
      _errorMessage = e.toString();
    }
  }

  Future<void> updateTaskStatusCategory(int id, String status) async {
    try {
      await TaskCategoriesService().updateTaskStatus(id, status);
      fetchTasksCategory();
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
    }
  }
}
