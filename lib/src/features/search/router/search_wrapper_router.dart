import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:printer/src/features/search/router/search_router.dart';

class CardStudentWrapperPage extends StatelessWidget {
  const CardStudentWrapperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: (_) => context.read<SearchCoordinator>(),
      child: context.read<SearchCoordinator>().getNavigator(),
    );
  }
}
