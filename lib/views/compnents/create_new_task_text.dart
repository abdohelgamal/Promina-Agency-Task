import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:promina_agency_task/shared/constants.dart';

class CreateTaskText extends StatelessWidget {
  const CreateTaskText({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Create New Task',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 25.sp,
                        fontWeight: FontWeight.w500),
                  ),
                  Icon(
                    FontAwesomeIcons.clipboard,
                    size: 40.sp,
                    color: primaryColor,
                  )
                ],
              );
  }
}