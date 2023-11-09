import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_state.dart';

class SearchBloc extends Cubit<SearchState> {
  SearchBloc() : super(const SearchState());
}
