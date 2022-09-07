import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:promina_agency_task/shared/constants.dart';

class SelectCategoryLabels extends StatelessWidget {
  const SelectCategoryLabels({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Select Category',
              style: TextStyle(color: primaryColor, fontSize: 18.sp)),
          Text('See All',
              style: TextStyle(color: primaryColor, fontSize: 14.sp))
        ],
      ),
    );
  }
}
