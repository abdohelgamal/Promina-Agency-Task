import 'package:date_picker_timeline_fixed/date_picker_timeline_fixed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:promina_agency_task/controllers/meetings_cubit.dart';
import 'package:promina_agency_task/shared/constants.dart';

class DateCalender extends StatelessWidget {
DatePickerController datePickerController = DatePickerController();

    DateCalender(this.isSmallScreen, {super.key});
  bool isSmallScreen;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:isSmallScreen ? 95 : 80,
      width: double.infinity,
      child: DatePicker(
        DateTime.now(),
        controller: datePickerController,
        initialSelectedDate: DateTime.now(),
        width: 55,
        height: 55,
        selectionColor: primaryColor,
        daysCount:
            (DateTime(DateTime.now().year, DateTime.now().month + 1, 0).day -
                    DateTime.now().day) +
                1,
        onDateChange: (DateTime dateTime) {
          datePickerController.animateToDate(dateTime,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeIn);
          BlocProvider.of<MeetingsCubit>(context)
              .getSelectedDayMeetings(dateTime);
        },
      ),
    );
  }
}
