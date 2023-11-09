import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:printer/src/features/add_new_code/router/add_new_code_router.dart';

class AddNewCodeWrapperPage extends StatelessWidget {
  const AddNewCodeWrapperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: (_) => context.read<AddNewCodeCoordinator>(),
      child: context.read<AddNewCodeCoordinator>().getNavigator(),
    );
  }
}
