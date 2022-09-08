import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:promina_agency_task/shared/constants.dart';
import 'package:promina_agency_task/views/screens/add_meeting.dart';

class ClipPathFirstContents extends StatelessWidget {
  ClipPathFirstContents(this.isSmallScreen, {super.key});
  bool isSmallScreen;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10).copyWith(top: 50, bottom: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'My Task',
            style: TextStyle(
                fontSize: isSmallScreen ? 25 : 30.sp,
                fontWeight: FontWeight.bold),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddMeetingScreen(),
                  ));
            },
            child: Container(
              decoration: BoxDecoration(
                  color: primaryColor, borderRadius: BorderRadius.circular(10)),
              height: 50,
              width: 50,
              child: Icon(
                Icons.add_rounded,
                color: Colors.white,
                size: isSmallScreen ? 16 : 20.sp,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ClipPathSecondContents extends StatelessWidget {
  ClipPathSecondContents(this.isSmallScreen, {super.key});
  bool isSmallScreen;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10).copyWith(bottom: 20, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Today',
            style: TextStyle(
                fontSize: isSmallScreen ? 17 : 22.sp,
                fontWeight: FontWeight.bold),
          ),
          Text(
            formatDate(DateTime.now(), [D, ', ', d, ' ', MM]),
            style: TextStyle(
                color: primaryColor,
                fontSize: isSmallScreen ? 11 : 16.sp,
                fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  }
}
