import 'package:flutter/material.dart';
import 'package:printer/src/features/add_new_code/pages/add_new_code_page.dart';
import 'package:printer/src/features/common/pages/not_found_page.dart';

import 'package:printer/src/router/base_coordinator.dart';

class XHomeRouterName {
  static const String addnewcode = '/addnewcode';
}

class AddNewCodeCoordinator extends BaseCoordinator {
  @override
  String get initialRoute => XHomeRouterName.addnewcode;

  @override
  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case XHomeRouterName.addnewcode:
        return MaterialPageRoute(builder: (_) => const AddNewCodePage());

      default:
        return MaterialPageRoute(builder: (_) => const NotFoundPage());
    }
  }
}
