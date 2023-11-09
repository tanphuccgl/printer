import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'schedule_state.dart';

class ScheduleBloc extends Cubit<ScheduleState> {
  ScheduleBloc() : super(ScheduleState());
}
