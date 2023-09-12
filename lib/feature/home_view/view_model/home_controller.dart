import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:kochin_machine_test/core/asset_url/repository.dart';
import 'package:kochin_machine_test/feature/home_view/model/user_model.dart';

class HomeController extends ChangeNotifier {
  HomeController() {
    getAllUserList();
  }

  List<User>? myPostList = [];
  bool isLoadingData = false;
  bool hasMoreData = true;

  Future<void> getAllUserList() async {
    if (!isLoadingData && hasMoreData) {
      isLoadingData = true;
      notifyListeners();
      await Future.delayed(const Duration(seconds: 1));
      List response =
          await BaseClient.get('https://dummyjson.com/users?limit=100&skip=0');
      myPostList?.clear();
      if (response.isEmpty) {
        hasMoreData = false;
        notifyListeners();
      }
      if (response[0] >= 200 && response[0] < 300) {
        myPostList?.clear();
        final data = UserModel.fromJson(response[1]);
        myPostList?.addAll(data.users ?? []);
        isLoadingData = false;
        notifyListeners();
        log("${myPostList.toString()}==========");
      }
    }

    notifyListeners();
  }
}
