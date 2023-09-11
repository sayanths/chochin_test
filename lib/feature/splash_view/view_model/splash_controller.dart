import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kochin_machine_test/routes/routes.dart';

class SplashController extends ChangeNotifier {
  SplashController() {
    Timer(const Duration(seconds: 3), () {
      Routes.pushReplace(screen: "/homeView");
    });
  }
}
