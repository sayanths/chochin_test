import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:kochin_machine_test/core/asset_url/repository.dart';
import 'package:kochin_machine_test/feature/home_view/model/user_model.dart';

import '../../../core/url/base_url.dart';
import '../model/over_view.dart';

class HomeController extends ChangeNotifier {
  HomeController() {
    getAllUserList();
    getAllOverViewObject();
  }

  List<User>? myPostList = [];

  Future<void> getAllUserList() async {
    List response = await BaseClient.get(Url().listofUserUrl);
    myPostList?.clear();
    if (response[0] >= 200 && response[0] < 300) {
      myPostList?.clear();
      final data = UserModel.fromJson(response[1]);
      myPostList?.addAll(data.users ?? []);
      log("${myPostList.toString()}==========");
    }
    notifyListeners();
  }

  int? userIndex;

  void getUserIndex(int index) {
    userIndex = index;
    log("$userIndex");
    notifyListeners();
  }

  UserModelOverViewSectionModel? overviewObject;

  Future<void> getAllOverViewObject() async {
    List response = await BaseClient.get(
        Url().overViewUrl.replaceFirst('{id}', userIndex.toString()));
    if (response[0] >= 200 && response[0] < 300) {
      final data = UserModelOverViewSectionModel.fromJson(response[1]);
      overviewObject = data;
      log("${overviewObject?.age.toString()}==age========");
      notifyListeners();
    }
    notifyListeners();
  }
}
