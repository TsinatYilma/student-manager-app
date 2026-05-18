import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class ApiService {
  static const String baseUrl = 'https://dummyjson.com';

  Future<List<UserModel>> fetchUsers() async {
    final response = await http.get(
      Uri.parse('$baseUrl/users'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      List users = data['users'];

      return users.map((user) => UserModel.fromJson(user)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<void> createUser(String name, String email) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users/add'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'firstName': name,
        'company': {
          'email': email,
        }
      }),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to create user');
    }
  }

  Future<void> updateUser(
    int id,
    String name,
    String email,
  ) async {
    final response = await http.put(
      Uri.parse('$baseUrl/users/$id'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'firstName': name,
        'email': email,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update user');
    }
  }

  Future<void> deleteUser(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/users/$id'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete user');
    }
  }
}
