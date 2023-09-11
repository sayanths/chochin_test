import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:kochin_machine_test/feature/overview_page/model/over_view.dart';

import '../../../core/asset_url/repository.dart';
import '../../../core/url/base_url.dart';
import '../../../routes/routes.dart';

class OverViewController extends ChangeNotifier {
  int? userIndex;

  void getUserIndex(int index) {
    userIndex = index;
    log("$userIndex");
    notifyListeners();
  }

  UserModelOverViewSectionModel? overviewObject;

  bool isOverViewPageLoading = false;

  Future<void> getAllOverViewObject() async {
    isOverViewPageLoading = true;
    notifyListeners();
    List response = await BaseClient.get(
        Url().overViewUrl.replaceFirst('{id}', userIndex.toString()));
    if (response[0] >= 200 && response[0] < 300) {
      isOverViewPageLoading = false;
      notifyListeners();
      Routes.push(screen: '/OverViewPage');
      final data = UserModelOverViewSectionModel.fromJson(response[1]);
      overviewObject = data;
      log("${overviewObject?.age.toString()}==age========");
      notifyListeners();
    }
    isOverViewPageLoading = false;
    notifyListeners();
  }
}
