import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:promina_agency_task/controllers/cubit_states.dart';
import 'package:promina_agency_task/models/meeting.dart';

class MeetingsCubit extends Cubit<MeetingsCubitBaseState> {
  MeetingsCubit() : super(MeetingsCubitInitialState()) {
    init();
  }
  void init() {
    meetingsBox = Hive.box('Meetings');
  }

  late Box meetingsBox;
  late List<Meeting> meetings;
}
