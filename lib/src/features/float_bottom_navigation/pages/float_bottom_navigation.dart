import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:printer/src/features/float_bottom_navigation/cubit/bottom_navigation_bloc.dart';
import 'package:printer/src/theme/colors.dart';

class FloatBottomNavigation extends StatelessWidget {
  const FloatBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
      builder: (context, state) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          constraints: BoxConstraints(maxHeight: 60.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: List.generate(PageIndex.values.length, (i) {
              final element = PageIndex.values[i];

              return Expanded(
                child: GestureDetector(
                    onTap: () =>
                        context.read<BottomNavigationBloc>().onItemTapped(i),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          strokeAlign: 1,
                        ),
                        color: element == state.pageIndex
                            ? XColors.primary2
                            : XColors.primary,
                      ),
                      child: Center(
                          child: Text(
                        element.lableOf(),
                        style: const TextStyle(fontSize: 18),
                      )),
                    )),
              );
            }),
          ),
        );
      },
      buildWhen: (p, c) => p.pageIndex != c.pageIndex,
    );
  }
}
