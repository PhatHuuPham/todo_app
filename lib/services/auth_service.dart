import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/models/user.dart';

class AuthService extends ChangeNotifier {
  static const String baseUrl = "http://localhost:3000";
  String? _accessToken;
  User? _currentUser;

  String? get accessToken => _accessToken;
  User? get currentUser => _currentUser;

  Future<Map<String, dynamic>> login(String userInput, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'userInput': userInput,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        _accessToken = (data['accessToken'] ?? '') as String;

        final userData = data['user'];

        if (accessToken == null || userData == null) {
          throw Exception(
              'Invalid response format: missing accessToken or user data');
        }

        _accessToken = accessToken;
        _currentUser = User.fromJson(userData);
        notifyListeners();

        // ✅ Lưu vào SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('accessToken', accessToken!);
        await prefs.setString('user', jsonEncode(userData));
        await prefs.setInt('userId', userData['id']);
        await prefs.setString('email', userData['email']);
        await prefs.setString('userName', userData['username']);
        print(prefs.getInt('userId'));
        return data;
      } else {
        final error = json.decode(response.body);
        throw Exception(error['message'] ?? 'Login failed');
      }
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  Future<void> logout() async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/logout'),
        headers: {
          'Content-Type': 'application/json',
          if (_accessToken != null) 'Authorization': 'Bearer $_accessToken',
        },
      );

      if (response.statusCode == 200) {
        _accessToken = null;
        _currentUser = null;
        notifyListeners();
      } else {
        final error = json.decode(response.body);
        throw Exception(error['message'] ?? 'Logout failed');
      }
    } catch (e) {
      throw Exception('Logout failed: $e');
    }
  }

  Future<String> refreshToken() async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/refresh-token'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        _accessToken = data['accessToken'];
        notifyListeners();
        return _accessToken!;
      } else {
        final error = json.decode(response.body);
        throw Exception(error['message'] ?? 'Token refresh failed');
      }
    } catch (e) {
      throw Exception('Token refresh failed: $e');
    }
  }

  bool get isAuthenticated => _accessToken != null && _currentUser != null;
}
