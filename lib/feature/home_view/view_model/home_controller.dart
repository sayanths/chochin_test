import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kochin_machine_test/feature/home_view/model/user_model.dart';
import 'package:http/http.dart' as http;

class UserProvider with ChangeNotifier {
  UserProvider() {
    fetchData();
  }
  final List<User> _dataList = [];
  int _currentPage = 1;
  bool _isLoading = false;
  bool _hasMore = true;

  List<User> get dataList => _dataList;
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;

  Future<void> fetchData() async {
    if (_isLoading || !_hasMore) return;

    _isLoading = true;
    notifyListeners();

    final response = await http.get(Uri.parse(
        'https://dummyjson.com/users?limit=20&skip=${(_currentPage - 1) * 5}'));

    _isLoading = false;

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data.containsKey('users') && data['users'] is List) {
        final users = data['users'];
        if (users.isNotEmpty) {
          _dataList.addAll(
              users.map((userData) => User.fromJson(userData)).cast<User>());
          _currentPage++;
        } else {
          _hasMore = false;
        }
      } else {
        // Handle the case where 'users' key is missing or not a list
      }
    } else {
      // Handle error here
    }

    notifyListeners();
  }
}
