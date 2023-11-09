import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:printer/src/services/user_prefs.dart';
import 'package:printer/src/theme/themes.dart';

import 'features/common/app_cubit/bloc_observer.dart';

class ConfigApp {
  static Future<void> initializeApp() async {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setSystemUIOverlayStyle(XTheme.barOverLayStyle);
    _locator();
    await Future.wait([
      // Firebase.initializeApp(),
      // AnalyticsService.instance.init(),

      UserPrefs.instance.initialize(),
    ]);

    Bloc.observer = XBlocObserver();
  }

  static void _locator() {
    // GetIt.I
    //   ..registerLazySingleton(() => Domain())
    //   ..registerLazySingleton(() => AccountBloc())
    //   ..registerLazySingleton(() => ListScheduleBloc());
  }
}
