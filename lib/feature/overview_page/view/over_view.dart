import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kochin_machine_test/core/custom_container/container.dart';
import 'package:kochin_machine_test/feature/overview_page/view_model/over_view_controller.dart';
import 'package:kochin_machine_test/responsive/responsive.dart';
import 'package:provider/provider.dart';

class OverViewPage extends StatelessWidget {
  const OverViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<OverViewController>(
        builder: (context, overViewProvider, _) => Column(
          children: [
            CustomContainer(
              height: Responsive.heightMultiplier! * 60,
              width: Responsive.widthMultiplier! * 120,
              child: CachedNetworkImage(
                imageUrl: overViewProvider.overviewObject?.image ?? "",
                height: 120,
              ),
            )
          ],
        ),
      ),
    );
  }
}
