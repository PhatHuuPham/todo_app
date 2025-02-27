import 'package:flutter/material.dart';
import 'package:todo_app/services/task_service.dart';

import '../models/task.dart';

class TaskViewmodel extends ChangeNotifier {
  TaskViewmodel() {
    fetchTasks();
  }

  List<Task> _tasks = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<Task> get tasks => _tasks;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchTasks() async {
    _isLoading = true;
    notifyListeners();
    try {
      _tasks = await TaskService().getTasks();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
    }
    notifyListeners();
  }

  Future<void> createTask(Task task) async {
    _isLoading = true;
    try {
      await TaskService().createTask(task);
      _errorMessage = '';
    } catch (e) {
      _errorMessage = 'Failed to create task: ${e.toString()}';
      throw _errorMessage; // Re-throw to handle in UI
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateTask(Task task) async {
    try {
      await TaskService().updateTask(task);
      fetchTasks();
    } catch (e) {
      _errorMessage = e.toString();
    }
  }

  Future<void> deleteTask(int id) async {
    try {
      await TaskService().deleteTask(id);
      fetchTasks();
    } catch (e) {
      _errorMessage = e.toString();
    }
  }

  Future<void> updateTaskStatus(int id, String status) async {
    try {
      print('vô đây chưa');
      await TaskService().updateTaskStatus(id, status);
      fetchTasks();
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
    }
  }
}
