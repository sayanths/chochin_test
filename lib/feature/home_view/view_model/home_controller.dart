import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:kochin_machine_test/core/asset_url/repository.dart';
import 'package:kochin_machine_test/feature/home_view/model/user_model.dart';

import '../../../core/url/base_url.dart';

class HomeController extends ChangeNotifier {
  HomeController() {
    getAllUserList();
  }
  bool isUserListLoading = false;

  List<User>? myPostList = [];

  Future<void> getAllUserList() async {
    List response = await BaseClient.get(Url().url1);
    myPostList?.clear();
    if (response[0] >= 200 && response[0] < 300) {
      myPostList?.clear();
      final data = UserModel.fromJson(response[1]);
      myPostList?.addAll(data.users ?? []);
      log("${myPostList.toString()}==========");
    }
    notifyListeners();
  }
}
