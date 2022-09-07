import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoMeetings extends StatelessWidget {
  const NoMeetings({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
                    child: Padding(
                      padding: EdgeInsets.all(20.sp),
                      child: Text(
                        'No meetings have been added for this day',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 20.sp),
                      ),
                    ),
                  );
  }
}