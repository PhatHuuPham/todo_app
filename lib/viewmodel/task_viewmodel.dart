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
    notifyListeners(); // Thông báo UI rằng đang tải dữ liệu

    try {
      _tasks = await TaskService().getTasks();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners(); // Đảm bảo UI cập nhật sau khi dữ liệu thay đổi
    }
  }

  Future<void> createTask(Task task) async {
    _isLoading = true;
    notifyListeners(); // Thông báo UI rằng đang tải

    try {
      await TaskService().createTask(task);
      await fetchTasks(); // Đợi fetchTasks hoàn thành
      _errorMessage = '';
    } catch (e) {
      _errorMessage = 'Failed to create task: ${e.toString()}';
      throw _errorMessage; // Re-throw để xử lý ở UI nếu cần
    } finally {
      _isLoading = false;
      notifyListeners(); // Thông báo UI rằng đã hoàn thành
    }
  }

  Future<void> updateTask(Task task) async {
    // _isLoading = true;
    // notifyListeners();

    try {
      await TaskService().updateTask(task);
      await fetchTasks(); // Đợi fetchTasks hoàn thành
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> deleteTask(int id) async {
    // _isLoading = true;
    // notifyListeners();

    try {
      await TaskService().deleteTask(id);
      await fetchTasks(); // Đợi fetchTasks hoàn thành
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> updateTaskStatus(int id, String status) async {
    try {
      await TaskService().updateTaskStatus(id, status);
      await fetchTasks(); // Đợi fetchTasks hoàn thành
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }
}
