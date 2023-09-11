import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:kochin_machine_test/feature/overview_page/model/over_view.dart';

import '../../../core/asset_url/repository.dart';
import '../../../core/url/base_url.dart';

class OverViewController extends ChangeNotifier {
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
