import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:promina_agency_task/models/meeting.dart';
import 'package:promina_agency_task/shared/constants.dart';

class MeetingListViewItem extends StatelessWidget {
  const MeetingListViewItem(this.meeting, {super.key});

  final Meeting meeting;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.sp).copyWith(bottom: 12.sp),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            margin:
                EdgeInsets.symmetric(horizontal: 8.sp).copyWith(bottom: 12.sp),
            padding: EdgeInsets.all(16.sp),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    height: 90.w,
                    width: 90.w,
                    child: Image.asset(
                      'assets/${meeting.category.name}.jpg',
                      fit: BoxFit.cover,
                    )),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      meeting.title,
                      style: TextStyle(color: Colors.black, fontSize: 21.sp),
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    Text(
                      meeting.description,
                      maxLines: 2,
                      overflow: TextOverflow.fade,
                      style: TextStyle(color: secondaryColor, fontSize: 14.sp),
                    )
                  ],
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Card(
              color: Colors.black,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15))),
              child: Padding(
                padding: EdgeInsets.all(10.sp),
                child: Text(
                  formatTheDate(meeting.startTime, true),
                  style: TextStyle(color: Colors.white, fontSize: 15.sp),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

String formatTheDate(DateTime dateTime, bool isTime) {
  if (isTime) {
    return formatDate(dateTime, [hh, ':', nn, ' ', am]);
  } else {
    return formatDate(dateTime, [D, ', ', d, ' ', M]);
  }
}
