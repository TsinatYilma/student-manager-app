import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class ApiService {
  static const String baseUrl = 'https://reqres.in/api';

  Future<List<UserModel>> fetchUsers() async {
    final response = await http.get(
      Uri.parse('$baseUrl/users?page=1'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      List users = data['data'];

      return users.map((user) => UserModel.fromJson(user)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<void> createUser(String name, String job) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users'),
      body: {
        'name': name,
        'job': job,
      },
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create user');
    }
  }

  Future<void> updateUser(int id, String name, String job) async {
    final response = await http.put(
      Uri.parse('$baseUrl/users/$id'),
      body: {
        'name': name,
        'job': job,
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update user');
    }
  }

  Future<void> deleteUser(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/users/$id'),
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to delete user');
    }
  }
}
