import 'package:flutter/material.dart';
import 'package:printer/src/router/router_name.dart';

class XCoordinator {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static BuildContext get context => navigatorKey.currentState!.context;
  static NavigatorState get navigator => navigatorKey.currentState!;
  static void pop<T extends Object?>([T? result]) async {
    return navigatorKey.currentState!.pop(result);
  }

  static Future<T?> pushNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) =>
      navigator.pushNamed(
        routeName,
        arguments: arguments,
      );

  static Future<T?> push<T extends Object?>(Widget screen) => navigator.push(
        MaterialPageRoute(builder: (context) => screen),
      );

  static Future<T?> pushReplacement<T extends Object?>(Widget screen) =>
      navigator.pushReplacement(
        MaterialPageRoute(builder: (context) => screen),
      );

  static Future showDashboard() => pushNamed(XRouterName.dashboard);
}
