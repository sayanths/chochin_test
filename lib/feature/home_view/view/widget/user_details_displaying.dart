import 'package:flutter/material.dart';

import '../../../../core/color/color.dart';
import '../../../../responsive/responsive.dart';

class UserDetailShowingWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  final double? titleSize;
  final double? subTitleSize;
  final double? size;
  const UserDetailShowingWidget({
    super.key,
    required this.title,
    required this.subTitle,
    this.titleSize,
    this.subTitleSize,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(size ?? 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: titleSize ?? Responsive.textMultiplier! * 2,
              ),
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
                  fontSize: subTitleSize ?? Responsive.textMultiplier! * 2,
                  color: Apc.grey),
            ),
          ),
        ],
      ),
    );
  }
}
