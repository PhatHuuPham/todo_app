import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Shareprefrence extends ChangeNotifier {
  late SharedPreferences prefs;

  Future<void> setUser(int id, String username, String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('id', id);
    await prefs.setString('username', username);
    await prefs.setString('email', email);
  }
}
