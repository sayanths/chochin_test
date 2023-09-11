import 'package:flutter/material.dart';

import '../../../../core/color/color.dart';
import '../../../../responsive/responsive.dart';

class UserDetailShowingWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  final double? titleSize;
  final double? subTitleSize;
  final double? size;
  final int? maxLines;
  final TextOverflow? overflow;
  const UserDetailShowingWidget(
      {super.key,
      required this.title,
      required this.subTitle,
      this.titleSize,
      this.subTitleSize,
      this.size,
      this.maxLines,
      this.overflow});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(size ?? 6),
      child: Row(
        children: [
          Expanded(
            child: Text(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: titleSize ?? Responsive.textMultiplier! * 1.5,
              ),
            ),
          ),
          const Flexible(child: Text("  :   ")),
          Expanded(
            flex: 2,
            child: Text(
              maxLines: maxLines ,
              overflow:overflow ,
              subTitle,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: subTitleSize ?? Responsive.textMultiplier! * 1.5,
                  color: Apc.grey),
            ),
          ),
        ],
      ),
    );
  }
}
