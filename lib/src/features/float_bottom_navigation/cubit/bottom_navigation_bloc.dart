import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:printer/src/config/constants/images.dart';
import 'package:printer/src/features/card_student/router/card_student_wrapper_router.dart';
import 'package:printer/src/features/home/router/home_wrapper_router.dart';
import 'package:printer/src/features/profile/router/profile_wrapper_router.dart';
import 'package:printer/src/features/schedule/router/schedule_wrapper_router.dart';
import 'package:printer/src/theme/colors.dart';
import 'package:printer/widgets/common/empty_widget.dart';

part 'bottom_navigation_state.dart';

class BottomNavigationBloc extends Cubit<BottomNavigationState> {
  BottomNavigationBloc() : super(const BottomNavigationState());

  void onItemTapped(int index) =>
      _emitIfOpen(state.copyWith(pageIndex: PageIndex.values[index]));
  void _emitIfOpen(BottomNavigationState newState) {
    if (!isClosed) {
      emit(newState);
    }
  }
}
