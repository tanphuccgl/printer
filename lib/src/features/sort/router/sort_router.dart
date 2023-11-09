import 'package:flutter/material.dart';

import 'package:printer/src/features/sort/pages/sort_page.dart';
import 'package:printer/src/router/base_coordinator.dart';

import '../../common/pages/not_found_page.dart';

class XScheduleRouterName {
  static const String sort = '/sort';
}

class SortCoordinator extends BaseCoordinator {
  @override
  String get initialRoute => XScheduleRouterName.sort;

  @override
  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case XScheduleRouterName.sort:
        return MaterialPageRoute(builder: (_) => const SortPage());

      default:
        return MaterialPageRoute(builder: (_) => const NotFoundPage());
    }
  }
}
