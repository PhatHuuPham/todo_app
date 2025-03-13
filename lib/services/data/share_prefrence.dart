import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Shareprefrence extends ChangeNotifier {
  late SharedPreferences prefs;
  String? _token;
  String? get token => _token;

  Future<void> setUser(int id, String username, String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('id', id);
    await prefs.setString('username', username);
    await prefs.setString('email', email);
  }

  Future<bool> checkLoginStatus() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _token = prefs.getString('accessToken');
      notifyListeners();
      return _token != null;
    } catch (e) {
      _token = null;
      notifyListeners();
      return false;
    }
  }
}
