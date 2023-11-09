import 'package:flutter/material.dart';

import 'package:printer/src/features/loading/loading_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const LoadingPage();
  }
}
