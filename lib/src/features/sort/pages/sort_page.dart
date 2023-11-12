import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:printer/src/features/sort/cubit/sort_bloc.dart';
import 'package:printer/src/network/model/product_model.dart';
import 'package:printer/src/theme/colors.dart';
import 'package:printer/widgets/froms/input.dart';

class SortPage extends StatelessWidget {
  const SortPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (context) => SortBloc(),
      child: BlocBuilder<SortBloc, SortState>(
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: SafeArea(
              child: ListView(
                  padding: const EdgeInsets.symmetric(
                    vertical: 30,
                    horizontal: 15,
                  ),
                  children: [
                    const Text(
                      "Nhập Mã:",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(height: 20),
                    XInput(
                      value: state.productId,
                      onChanged: (value) =>
                          context.read<SortBloc>().onChangedProductId(value),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Nhập Vị Trí:",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 65,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              width: 85,
                              height: 65,
                              child: XInput(
                                value: state.shelfNumber.toString(),
                                onChanged: (value) => context
                                    .read<SortBloc>()
                                    .onChangedShelfNumber(value),
                              )),
                          SizedBox(
                              width: 85,
                              height: 65,
                              child: XInput(
                                value: state.columnNumber.toString(),
                                onChanged: (value) => context
                                    .read<SortBloc>()
                                    .onChangedColumnNumber(value),
                              )),
                          SizedBox(
                              width: 85,
                              height: 65,
                              child: XInput(
                                value: state.floorNumber.toString(),
                                onChanged: (value) => context
                                    .read<SortBloc>()
                                    .onChangedFloorNumber(value),
                              )),
                          Container(
                            width: 85,
                            height: 43,
                            padding: const EdgeInsets.only(left: 5),
                            decoration: BoxDecoration(
                                color: XColors.primary2,
                                borderRadius: BorderRadius.circular(10)),
                            child: DropdownButton<LocationEnum>(
                              icon: const Icon(Icons.arrow_drop_down),
                              iconSize: 22,
                              underline: const SizedBox(),
                              value: state.location,
                              onChanged: (LocationEnum? value) {
                                return context
                                    .read<SortBloc>()
                                    .onChangedLocation(value!);
                              },
                              items: LocationEnum.values
                                  .map((LocationEnum location) {
                                return DropdownMenuItem<LocationEnum>(
                                  value: location,
                                  child: Text(location.label),
                                );
                              }).toList(),
                            ),
                          )
                        ],
                      ),
                    ),
                    const Spacer(),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            side: const BorderSide(
                                color: XColors.primary3, strokeAlign: 1),
                            minimumSize: Size(size.width, 40),
                            elevation: 2,
                            backgroundColor: XColors.primary2,
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 12)),
                        onPressed: () => context.read<SortBloc>().printer(),
                        child: const Text(
                          "Quét Mã",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            side: const BorderSide(
                                color: XColors.primary3, strokeAlign: 1),
                            minimumSize: Size(size.width, 40),
                            elevation: 2,
                            backgroundColor: XColors.primary2,
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 12)),
                        onPressed: () => context.read<SortBloc>().sortProduct(),
                        child: const Text(
                          "Lưu",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ]),
            ),
          );
        },
      ),
    );
  }
}
