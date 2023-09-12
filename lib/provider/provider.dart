import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kochin_machine_test/feature/splash_view/view_model/splash_controller.dart';

import '../feature/home_view/view_model/home_controller.dart';
import '../feature/overview_page/view_model/over_view_controller.dart';

class ProviderApp extends StatelessWidget {
  final Widget child;
  const ProviderApp({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SplashController(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => OverViewController(),
        ),
      ],
      child: child,
    );
  }
}
