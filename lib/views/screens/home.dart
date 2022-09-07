import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:date_format/date_format.dart';
import 'package:date_picker_timeline_fixed/date_picker_timeline_fixed.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:promina_agency_task/controllers/cubit_states.dart';
import 'package:promina_agency_task/controllers/meetings_cubit.dart';
import 'package:promina_agency_task/shared/constants.dart';
import 'package:promina_agency_task/views/compnents/clipper.dart';
import 'package:promina_agency_task/views/compnents/meetings_listview_item.dart';
import 'package:promina_agency_task/views/screens/add_meeting.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late ScrollController _scrollController;
  late MeetingsCubit cubit;
  late DatePickerController datePickerController;

  @override
  void initState() {
    datePickerController = DatePickerController();
    _scrollController = ScrollController();
    cubit = BlocProvider.of<MeetingsCubit>(context);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        children: [
          SizedBox(
              height: 0.6.sh,
              child: Stack(
                alignment: Alignment.topLeft,
                children: [
                  ClipPath(
                    clipper: CustomClipPath(),
                    child: Container(
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.sp).copyWith(
                        top: MediaQuery.of(context).viewPadding.top + 15.sp),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  color: Colors.black,
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.sort,
                                    size: 35.sp,
                                  ),
                                ),
                                IconButton(
                                  color: Colors.black,
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.notifications_outlined,
                                    color: primaryColor,
                                    size: 35.sp,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0.sp)
                              .copyWith(top: 40.sp, bottom: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'My Task',
                                style: TextStyle(
                                    fontSize: 30.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const AddMeetingScreen(),
                                      ));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.circular(10)),
                                  height: 40.sp,
                                  width: 40.sp,
                                  child: Icon(
                                    Icons.add_rounded,
                                    color: Colors.white,
                                    size: 20.sp,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0.sp)
                              .copyWith(bottom: 20.sp, top: 10.sp),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Today',
                                style: TextStyle(
                                    fontSize: 22.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                formatDate(
                                    DateTime.now(), [D, ', ', d, ' ', MM]),
                                style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 80.h,
                          width: double.infinity,
                          child: DatePicker(
                            DateTime.now(),
                            controller: datePickerController,
                            initialSelectedDate: DateTime.now(),
                            width: 45.sp,
                            height: 45.sp,
                            selectionColor: primaryColor,
                            daysCount: (DateTime(DateTime.now().year,
                                            DateTime.now().month + 1, 0)
                                        .day -
                                    DateTime.now().day) +
                                1,
                            onDateChange: (DateTime dateTime) {
                              datePickerController.animateToDate(dateTime,
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.easeIn);
                              cubit.getSelectedDayMeetings(dateTime);
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20.sp).copyWith(
                        top: MediaQuery.of(context).viewPadding.top + 10.sp),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        height: 60.h,
                        width: 60.h,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                        padding: EdgeInsets.all(8.sp),
                        child: Image.asset('assets/user_profile.png'),
                      ),
                    ),
                  )
                ],
              )),
          Expanded(
            child: BlocBuilder<MeetingsCubit, MeetingsCubitBaseState>(
              builder: (context, state) {
                if (state is MeetingsCubitLoadingMeetings) {
                  return Center(
                      child: CupertinoActivityIndicator(
                    color: Colors.white,
                    radius: 25.sp,
                  ));
                } else if (cubit.selectedDayMeetings.isNotEmpty) {
                  return AdaptiveScrollbar(
                    position: ScrollbarPosition.left,
                    width: 2.5.sp,
                    sliderDefaultColor: const Color.fromARGB(255, 6, 48, 96),
                    sliderHeight: 80.h,
                    underSpacing: EdgeInsets.only(
                      bottom: 50.sp,
                      left: 10.sp,
                    ),
                    sliderSpacing: EdgeInsets.zero,
                    controller: _scrollController,
                    child: ListView.builder(
                      itemCount: cubit.selectedDayMeetings.length,
                      controller: _scrollController,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return MeetingListViewItem(
                            cubit.selectedDayMeetings[index]);
                      },
                    ),
                  );
                } else {
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
              },
            ),
          ),
        ],
      ),
    );
  }
}
