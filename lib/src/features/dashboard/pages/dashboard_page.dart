import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:printer/src/features/add_new_code/router/add_new_code_router.dart';

import 'package:printer/src/features/float_bottom_navigation/cubit/bottom_navigation_bloc.dart';
import 'package:printer/src/features/float_bottom_navigation/pages/float_bottom_navigation.dart';
import 'package:printer/src/features/search/router/search_router.dart';
import 'package:printer/src/features/sort/router/sort_router.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => AddNewCodeCoordinator()),
        RepositoryProvider(create: (_) => SearchCoordinator()),
        RepositoryProvider(create: (_) => SortCoordinator()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => BottomNavigationBloc(),
          ),
        ],
        child: BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
          builder: (_, state) {
            return WillPopScope(
              onWillPop: () async => false,
              child: Stack(children: [
                Scaffold(
                  body: state.pageIndex.page,
                  bottomNavigationBar: const FloatBottomNavigation(),
                ),
              ]),
            );
          },
          buildWhen: (p, c) => p.pageIndex != c.pageIndex,
        ),
      ),
    );
  }
}
