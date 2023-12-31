import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kochin_machine_test/core/color/color.dart';
import 'package:kochin_machine_test/feature/splash_view/view_model/splash_controller.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<SplashController>();
    return const Scaffold(
      backgroundColor: Apc.primary,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text("SplasH vIEW"),
          ),
        ],
      ),
    );
  }
}
