import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:date_picker_timeline_fixed/date_picker_timeline_fixed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:promina_agency_task/controllers/cubit_states.dart';
import 'package:promina_agency_task/controllers/meetings_cubit.dart';
import 'package:promina_agency_task/shared/constants.dart';
import 'package:promina_agency_task/views/compnents/clippath_contents.dart';
import 'package:promina_agency_task/views/compnents/clippath_icons.dart';
import 'package:promina_agency_task/views/compnents/clipper.dart';
import 'package:promina_agency_task/views/compnents/date_calender.dart';
import 'package:promina_agency_task/views/compnents/loading.dart';
import 'package:promina_agency_task/views/compnents/meetings_listview_item.dart';
import 'package:promina_agency_task/views/compnents/no_meetings_text.dart';
import 'package:promina_agency_task/views/compnents/user_image.dart';

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
    bool isSmallScreen = MediaQuery.of(context).size.height < 1024;
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
                height: isSmallScreen ? 480 : 430,
                child: Stack(
                  alignment: Alignment.topLeft,
                  children: [
                    ClipPath(
                      clipper: CustomClipPath(),
                      child: Container(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20)
                              .copyWith(top: 55),
                          child: Column(
                            children: [
                              ClipPathIcons(isSmallScreen),
                              ClipPathFirstContents(isSmallScreen),
                              ClipPathSecondContents(isSmallScreen),
                              DateCalender(isSmallScreen)
                            ],
                          ),
                        ),
                      ),
                    ),
                    const UserImage()
                  ],
                )),
            Expanded(
              child: BlocBuilder<MeetingsCubit, MeetingsCubitBaseState>(
                builder: (context, state) {
                  if (state is MeetingsCubitLoadingMeetings) {
                    return const Loading();
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
                    return const NoMeetings();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
