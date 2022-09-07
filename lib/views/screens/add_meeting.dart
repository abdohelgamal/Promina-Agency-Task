import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:promina_agency_task/controllers/meetings_cubit.dart';
import 'package:promina_agency_task/models/meeting.dart';
import 'package:promina_agency_task/shared/constants.dart';
import 'package:promina_agency_task/views/compnents/add_meeting_appbar.dart';
import 'package:promina_agency_task/views/compnents/create_new_task_text.dart';
import 'package:promina_agency_task/views/compnents/custom_textfield.dart';
import 'package:promina_agency_task/views/compnents/date_textfield.dart';
import 'package:promina_agency_task/views/compnents/select_category_labels.dart';

class AddMeetingScreen extends StatefulWidget {
  const AddMeetingScreen({super.key});

  @override
  State<AddMeetingScreen> createState() => _AddMeetingScreenState();
}

class _AddMeetingScreenState extends State<AddMeetingScreen> {
  late TextEditingController description;
  late TextEditingController title;
  DateTime? date;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  Category selectedCategory = Category.development;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    description = TextEditingController();
    title = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    description.dispose();
    title.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.all(25.sp),
          child: Column(
            children: [
              const CreateTaskText(),
              CustomTextField(
                  formKey: formKey, label: 'Task Name', controller: title),
              const SelectCategoryLabels(),
              StatefulBuilder(builder: (context, ststt) {
                return Container(
                  alignment: Alignment.topCenter,
                  margin: EdgeInsets.symmetric(vertical: 10.sp),
                  height: 45.h,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        ststt(
                          () {
                            selectedCategory = Category.values[index];
                          },
                        );
                      },
                      child: Chip(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.sp),
                              side: const BorderSide(color: primaryColor)),
                          backgroundColor:
                              selectedCategory == Category.values[index]
                                  ? primaryColor
                                  : Colors.white,
                          label: Text(
                            Category.values[index].name,
                            style: TextStyle(
                                color:
                                    selectedCategory == Category.values[index]
                                        ? Colors.white
                                        : primaryColor),
                          )),
                    ),
                    separatorBuilder: (context, index) => SizedBox(
                      width: 15.w,
                    ),
                    itemCount: Category.values.length,
                  ),
                );
              }),
              StatefulBuilder(builder: (context, ststt) {
                return GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(DateTime.now().year,
                                DateTime.now().month + 1, 0))
                        .then((value) {
                      if (value != null) {
                        ststt(
                          () {
                            date = value;
                          },
                        );
                      }
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DateTextfield(
                          'Date',
                          false,
                          text: date != null
                              ? formatDate(date!, [D, ', ', d, ' ', M])
                              : null,
                        ),
                        const CircleAvatar(
                            backgroundColor: primaryColor,
                            child: Icon(
                              FontAwesomeIcons.calendar,
                              color: Colors.white,
                            ))
                      ],
                    ),
                  ),
                );
              }),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    StatefulBuilder(builder: (context, ststt) {
                      return GestureDetector(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now())
                              .then((value) {
                            if (value != null) {
                              ststt(
                                () {
                                  startTime = value;
                                },
                              );
                            }
                          });
                        },
                        child: DateTextfield(
                          'Start Time',
                          true,
                          text: startTime == null
                              ? ''
                              : startTime!.hour >= 12
                                  ? '${startTime!.hour - 12}:${startTime!.minute.toString().length == 2 ? startTime!.minute : "0${startTime!.minute}"} PM'
                                  : '${startTime!.hour}:${startTime!.minute.toString().length == 2 ? startTime!.minute : "0${startTime!.minute}"} AM',
                        ),
                      );
                    }),
                    StatefulBuilder(builder: (context, ststt) {
                      return GestureDetector(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now())
                              .then((value) {
                            if (value != null) {
                              ststt(
                                () {
                                  endTime = value;
                                },
                              );
                            }
                          });
                        },
                        child: DateTextfield(
                          'End Time',
                          true,
                          text: endTime == null
                              ? ''
                              : endTime!.hour >= 12
                                  ? '${endTime!.hour - 12}:${endTime!.minute.toString().length == 2 ? endTime!.minute : "0${endTime!.minute}"} PM'
                                  : '${endTime!.hour}:${endTime!.minute.toString().length == 2 ? endTime!.minute : "0${endTime!.minute}"} AM',
                        ),
                      );
                    }),
                  ],
                ),
              ),
              CustomTextField(
                  formKey: formKey,
                  label: 'Description',
                  controller: description),
              SizedBox(
                height: 45.h,
                width: 0.75.sw,
                child: OutlinedButton(
                    style: ButtonStyle(
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                        backgroundColor:
                            const MaterialStatePropertyAll(primaryColor),
                        foregroundColor:
                            const MaterialStatePropertyAll(Colors.white),
                        textStyle: MaterialStatePropertyAll(TextStyle(
                            color: Colors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600))),
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      if (formKey.currentState!.validate() &&
                          date != null &&
                          startTime != null &&
                          endTime != null) {
                        BlocProvider.of<MeetingsCubit>(context)
                            .addMeeting(Meeting(
                              title: title.text,
                              description: description.text,
                              category: selectedCategory,
                              date: date!,
                              startTime: DateTime(
                                  date!.year,
                                  date!.month,
                                  date!.day,
                                  startTime!.hour,
                                  startTime!.minute),
                              endTime: DateTime(date!.year, date!.month,
                                  date!.day, endTime!.hour, endTime!.minute),
                            ))
                            .whenComplete(() => Navigator.pop(context));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          padding: EdgeInsets.all(10.sp),
                          duration: const Duration(milliseconds: 2500),
                          content: Text(
                            'Please enter the missing times',
                            style: TextStyle(fontSize: 12.sp),
                          ),
                          backgroundColor: Colors.redAccent.withOpacity(0.8),
                        ));
                      }
                    },
                    child: const Text('Create Task')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
