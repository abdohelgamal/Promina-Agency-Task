import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserImage extends StatelessWidget {
  const UserImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(35),
      child: Align(
        alignment: Alignment.topRight,
        child: Container(
          height: 60,
          width: 60,
          decoration:
              const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
          padding: const EdgeInsets.all(8),
          child: Image.asset('assets/user_profile.png'),
        ),
      ),
    );
  }
}
