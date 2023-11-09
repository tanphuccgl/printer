import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:printer/src/features/add_new_code/router/add_new_code_wrapper_router.dart';
import 'package:printer/src/features/search/router/search_wrapper_router.dart';
import 'package:printer/src/features/sort/router/sort_wrapper_router.dart';
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
