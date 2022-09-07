import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:promina_agency_task/controllers/cubit_states.dart';
import 'package:promina_agency_task/models/meeting.dart';

class MeetingsCubit extends Cubit<MeetingsCubitBaseState> {
  late Box meetingsBox;
  late List meetings;
  late List selectedDayMeetings;
  MeetingsCubit() : super(MeetingsCubitInitialState()) {
    selectedDayMeetings = [];
    meetings = [];
    init();
  }

  void getSelectedDayMeetings(DateTime dateTime) {
    emit(MeetingsCubitLoadingMeetings());
    selectedDayMeetings = meetings
        .where((element) => element.date == dateTime)
        .toList()
      ..sort(((a, b) => (a.date).compareTo(b.date)));
    emit(MeetingsCubitAddedMeeting());
  }

  Future<void> addMeeting(Meeting meeting) async {
    meetings.add(meeting);
    await meetingsBox.put('Meetings', meetings).whenComplete(() {
      updateAfterAdding(meeting);
    });
  }

  void updateAfterAdding(Meeting meeting) {
    if (selectedDayMeetings.isNotEmpty) {
      if (selectedDayMeetings[0].date == meeting.date) {
        selectedDayMeetings.add(meeting);
        selectedDayMeetings.sort(((a, b) => (a.date).compareTo(b.date)));
        emit(MeetingsCubitAddedMeeting());
      }
    }
  }

  Future<void> init() async {
    emit(MeetingsCubitLoadingMeetings());
    meetingsBox = await Hive.openBox('Meetings');
    meetings = meetingsBox.get('Meetings') ?? [];
    emit(MeetingsCubitInitialState());
  }
}
