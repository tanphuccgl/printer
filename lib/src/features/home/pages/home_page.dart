import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:printer/src/features/home/cubit/home_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(),
      child: const Scaffold(
        body: SafeArea(
          bottom: false,
          child: Column(children: []),
        ),
      ),
    );
  }
}
