import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:printer/src/features/card_student/router/card_student_router.dart';
import 'package:printer/src/features/float_bottom_navigation/cubit/bottom_navigation_bloc.dart';
import 'package:printer/src/features/float_bottom_navigation/pages/float_bottom_navigation.dart';
import 'package:printer/src/features/home/router/home_router.dart';
import 'package:printer/src/features/profile/router/profile_router.dart';
import 'package:printer/src/features/schedule/router/schedule_router.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => HomeCoordinator()),
        RepositoryProvider(create: (_) => ProfileCoordinator()),
        RepositoryProvider(create: (_) => CardStudentCoordinator()),
        RepositoryProvider(create: (_) => ScheduleCoordinator()),
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
