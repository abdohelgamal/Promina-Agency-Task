import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:promina_agency_task/shared/constants.dart';

class DateTextfield extends StatelessWidget {
  DateTextfield(this.label, this.isTime, {this.text, super.key});

  String? text;
  String label;
  bool isTime;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: isTime ? 0.35.sw : 0.5.sw,
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: primaryColor))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: TextStyle(color: primaryColor, fontSize: 17.sp)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text ?? '',
                  style: TextStyle(fontSize: 15.sp),
                ),
                Icon(
                  Icons.expand_more,
                  size: 30.sp,
                  color: isTime ? primaryColor : Colors.transparent,
                )
              ],
            ),
          ],
        ));
  }
}
