import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todo_app/models/user.dart';

class UserService extends ChangeNotifier {
  static const String baseUrl = "http://localhost:3000";

  Future<List<User>> getUsers() async {
    // Fetch data from API
    final response = await http.get(Uri.parse('$baseUrl/users'));
    if (response.statusCode == 200) {
      final List<dynamic> userJson = json.decode(response.body);
      return userJson.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load user');
    }
  }

  Future<User> getUser(int id) async {
    // Fetch data from API
    final response = await http.get(Uri.parse('$baseUrl/user/$id'));
    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load User');
    }
  }

  Future<User> createUser(User user) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'username': user.username,
        'email': user.email,
        'password': user.password,
        'avatar_url': user.avatarUrl,
      }),
    );

    if (response.statusCode == 201) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create User: ${response.body}');
    }
  }

  Future<User> updateUser(User user) async {
    // Fetch data from API
    final response = await http.put(
      Uri.parse('$baseUrl/users/${user.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'username': user.username,
        'email': user.email,
        'password': user.password,
        'avatar_url': user.avatarUrl,
      }),
    );
    return response.statusCode == 200
        ? User.fromJson(json.decode(response.body))
        : throw Exception('Failed to update User');
  }

  Future<void> deleteUser(int id) async {
    // Fetch data from API
    final response = await http.delete(Uri.parse('$baseUrl/users/$id'));
    if (response.statusCode != 204) {
      throw Exception('Failed to delete User');
    }
  }
}
