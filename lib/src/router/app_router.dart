import 'package:flutter/material.dart';
import 'package:printer/src/features/common/pages/not_found_page.dart';
import 'package:printer/src/features/dashboard/pages/dashboard_page.dart';
import 'package:printer/src/router/router_name.dart';

class XAppRoute {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case XRouterName.dashboard:
        return MaterialPageRoute(builder: (_) => const DashboardPage());

      default:
        return MaterialPageRoute(
          builder: (_) => const NotFoundPage(),
        );
    }
  }
}
