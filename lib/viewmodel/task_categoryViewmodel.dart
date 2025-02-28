import 'package:flutter/material.dart';
import 'package:todo_app/models/task_category.dart';
import 'package:todo_app/services/task_categories_service.dart';

class TaskCategoryViewmodel extends ChangeNotifier {
  TaskCategoryViewmodel() {
    fetchTaskCategories();
  }

  List<TaskCategory> _taskCategories = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<TaskCategory> get taskCategories => _taskCategories;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchTaskCategories() async {
    _isLoading = true;
    try {
      _taskCategories = await TaskCategoriesService().getTaskCategories();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
    }
    notifyListeners();
  }
}
