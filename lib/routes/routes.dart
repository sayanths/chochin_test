import 'package:flutter/material.dart';
import 'package:kochin_machine_test/feature/home_view/view/home_view.dart';

import '../feature/overview_page/view/over_view.dart';

class Routes {
  static final routeKey = GlobalKey<NavigatorState>();

  Map<String, Widget Function(BuildContext)> route = {
    "/homeView": (context) => MyHomePage(),
    "/OverViewPage": (context) => const OverViewPage(),
  };

  static push({required var screen}) {
    routeKey.currentState?.pushNamed(screen);
  }

  static back({bool? value}) {
    routeKey.currentState?.pop();
  }

  static pushReplace({required var screen}) {
    routeKey.currentState?.pushReplacementNamed(screen);
  }

  static pushRemoveUntil({required var screen}) {
    routeKey.currentState?.pushNamedAndRemoveUntil(
      screen,
      (route) => false,
    );
  }

  static sizedAnimationPush({required var screen}) {
    routeKey.currentState?.push(
      PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) {
          return screen;
        },
        transitionDuration: const Duration(milliseconds: 1000),
        transitionsBuilder: (context, animation, anotherAnimation, child) {
          animation =
              CurvedAnimation(curve: Curves.bounceIn, parent: animation);
          return Align(
            child: Align(
              child: SizeTransition(
                sizeFactor: animation,
                axisAlignment: 0.0,
                child: child,
              ),
            ),
          );
        },
      ),
    );
  }
}
