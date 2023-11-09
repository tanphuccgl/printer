import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:printer/src/features/sort/router/sort_router.dart';

class SortWrapperPage extends StatelessWidget {
  const SortWrapperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: (_) => context.read<SortCoordinator>(),
      child: context.read<SortCoordinator>().getNavigator(),
    );
  }
}
