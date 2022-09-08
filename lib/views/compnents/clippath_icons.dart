import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:promina_agency_task/shared/constants.dart';

class ClipPathIcons extends StatelessWidget {
   ClipPathIcons(this.isSmallScreen, {super.key});
  bool isSmallScreen;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: [
            Icon(
              Icons.sort,
              size: isSmallScreen ? 30 : 35.sp,
            ),
            Icon(
              Icons.notifications_outlined,
              color: primaryColor,
             size: isSmallScreen ? 30 : 35.sp,
            ),
          ],
        ),
      ],
    );
  }
}
