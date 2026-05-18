import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/api_service.dart';
import '../models/user_model.dart';

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

  Future<void> addUser(String name, String email) async {
    await apiService.createUser(name, email);

    users.insert(
      0,
      UserModel(
        id: DateTime.now().millisecondsSinceEpoch,
        firstName: name,
        lastName: '',
        email: email,
        avatar: 'https://cdn-icons-png.flaticon.com/512/149/149071.png',
      ),
    );

    notifyListeners();
  }

  Future<void> editUser(int id, String name, String email) async {
    await apiService.updateUser(id, name, email);

    final index = users.indexWhere((user) => user.id == id);

    if (index != -1) {
      users[index] = UserModel(
        id: users[index].id,
        firstName: name,
        lastName: users[index].lastName,
        email: email,
        avatar: users[index].avatar,
      );

      notifyListeners();
    }
  }

  Future<void> removeUser(int id) async {
    await apiService.deleteUser(id);

    users.removeWhere((user) => user.id == id);

    notifyListeners();
  }
}
