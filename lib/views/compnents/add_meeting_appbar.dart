import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      actions: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.sp),
          child: IconButton(
            color: Colors.black,
            onPressed: () {},
            icon: Icon(
              Icons.sort,
              size: 30.sp,
            ),
          ),
        ),
      ],
      leading: IconButton(
        color: Colors.black,
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back_ios_new,
          size: 20.sp,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size(1.sw, 50.h);
}
