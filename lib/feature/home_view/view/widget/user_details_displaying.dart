import 'package:flutter/material.dart';

import '../../../../core/color/color.dart';
import '../../../../responsive/responsive.dart';

class UserDetailShowingWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  const UserDetailShowingWidget({
    super.key,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Responsive.textMultiplier! * 2),
            ),
          ),
          const Expanded(child: Text("  : ")),
          Expanded(
            flex: 3,
            child: Text(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              subTitle,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: Responsive.textMultiplier! * 2,
                  color: Apc.grey),
            ),
          ),
        ],
      ),
    );
  }
}
