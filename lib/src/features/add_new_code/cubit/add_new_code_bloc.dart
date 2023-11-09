import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_new_code_state.dart';

class AddNewCodeBloc extends Cubit<AddNewCodeState> {
  AddNewCodeBloc() : super(AddNewCodeState());
}
