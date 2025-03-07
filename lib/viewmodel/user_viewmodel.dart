import 'package:flutter/material.dart';
import 'package:todo_app/models/user.dart';
import 'package:todo_app/services/task_service.dart';
import 'package:todo_app/services/user_service.dart';

class UserViewmodel extends ChangeNotifier {
  UserViewmodel() {
    fetchUsers();
  }

  List<User> _users = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<User> get tasks => _users;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchUsers() async {
    _isLoading = true;
    notifyListeners(); // Thông báo UI rằng đang tải dữ liệu

    try {
      _users = await UserService().getUsers();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners(); // Đảm bảo UI cập nhật sau khi dữ liệu thay đổi
    }
  }

  Future<void> createUser(User user) async {
    _isLoading = true;
    notifyListeners(); // Thông báo UI rằng đang tải

    try {
      await UserService().createUser(user);
      await fetchUsers(); // Đợi fetchTasks hoàn thành
      _errorMessage = '';
    } catch (e) {
      _errorMessage = 'Failed to create task: ${e.toString()}';
      throw _errorMessage; // Re-throw để xử lý ở UI nếu cần
    } finally {
      _isLoading = false;
      notifyListeners(); // Thông báo UI rằng đã hoàn thành
    }
  }

  Future<void> updateTask(User user) async {
    // _isLoading = true;
    // notifyListeners();

    try {
      await UserService().updateUser(user);
      await fetchUsers(); // Đợi fetchTasks hoàn thành
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> deleteUser(int id) async {
    // _isLoading = true;
    // notifyListeners();

    try {
      await TaskService().deleteTask(id);
      await fetchUsers(); // Đợi fetchTasks hoàn thành
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }
}
