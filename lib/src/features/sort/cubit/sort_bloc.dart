import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sort_state.dart';

class SortBloc extends Cubit<SortState> {
  SortBloc() : super(SortState());
}
