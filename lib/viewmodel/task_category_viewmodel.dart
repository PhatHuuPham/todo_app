import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/services/task_categories_service.dart';
import '../models/task_category.dart';

class TaskCategoryViewmodel extends ChangeNotifier with WidgetsBindingObserver {
  TaskCategoryViewmodel() {
    fetchTasksByUserId();
  }
  // Khi app được active lại, gọi refresh dữ liệu
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      fetchTasksByUserId();
    }
  }

  List<TaskCategory> _taskCategories = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<TaskCategory> get taskCategories => _taskCategories;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // Future<void> fetchTasksCategory() async {
  //   _isLoading = true;
  //   try {
  //     _taskCategories = await TaskCategoriesService().getTasks();
  //   } catch (e) {
  //     _errorMessage = e.toString();
  //   } finally {
  //     _isLoading = false;
  //     notifyListeners();
  //   }
  // }

  Future<void> fetchTasksByUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isLoading = true;
    notifyListeners(); // Thông báo UI rằng đang tải dữ liệu

    try {
      _taskCategories = await TaskCategoriesService()
          .getTasksByUserId(prefs.getInt('userId') ?? 0);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners(); // Đảm bảo UI cập nhật sau khi dữ liệu thay đổi
    }
  }

  void clearTasks() {
    _taskCategories = []; // Reset danh sách task
    notifyListeners();
  }

  Future<void> createTaskCategory(TaskCategory taskCategory) async {
    _isLoading = true;
    try {
      await TaskCategoriesService().createTask(taskCategory);
      await fetchTasksByUserId();
      notifyListeners();
      // _errorMessage = '';
    } catch (e) {
      _errorMessage = 'Failed to create task category: ${e.toString()}';
      throw _errorMessage; // Re-throw to handle in UI
    }
  }

  Future<void> updateTaskCategory(TaskCategory taskCategory) async {
    try {
      await TaskCategoriesService().updateTask(taskCategory);
      await fetchTasksByUserId();
    } catch (e) {
      _errorMessage = e.toString();
    }
  }

  Future<void> deleteTaskCategory(int id) async {
    try {
      await TaskCategoriesService().deleteTask(id);
      await fetchTasksByUserId();
    } catch (e) {
      _errorMessage = e.toString();
    }
  }
}
