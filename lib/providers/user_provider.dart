import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/api_service.dart';

class UserProvider extends ChangeNotifier {
  final ApiService apiService = ApiService();

  List<UserModel> users = [];

  bool isLoading = false;
  String error = '';

  Future<void> fetchUsers() async {
    try {
      isLoading = true;
      notifyListeners();

      users = await apiService.fetchUsers();

      error = '';
    } catch (e) {
      error = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> addUser(String name, String job) async {
    await apiService.createUser(name, job);
    await fetchUsers();
  }

  Future<void> editUser(int id, String name, String job) async {
    await apiService.updateUser(id, name, job);
    await fetchUsers();
  }

  Future<void> removeUser(int id) async {
    await apiService.deleteUser(id);

    users.removeWhere((user) => user.id == id);

    notifyListeners();
  }
}
