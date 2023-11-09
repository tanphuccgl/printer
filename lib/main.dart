import 'package:flutter/material.dart';

import 'package:printer/src/locator.dart';

import 'src/app.dart';

Future main() async {
  await ConfigApp.initializeApp();
  runApp(
    const MyApp(),
  );
}
