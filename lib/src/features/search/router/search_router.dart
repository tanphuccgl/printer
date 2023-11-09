import 'package:flutter/material.dart';
import 'package:printer/src/features/common/pages/not_found_page.dart';
import 'package:printer/src/features/search/pages/search_page.dart';

import 'package:printer/src/router/base_coordinator.dart';

class XCardStudentRouterName {
  static const String search = '/search';
}

class SearchCoordinator extends BaseCoordinator {
  @override
  String get initialRoute => XCardStudentRouterName.search;

  @override
  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case XCardStudentRouterName.search:
        return MaterialPageRoute(builder: (_) => const SearchPage());

      default:
        return MaterialPageRoute(builder: (_) => const NotFoundPage());
    }
  }
}
