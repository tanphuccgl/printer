import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:printer/src/features/search/cubit/search_bloc.dart';
import 'package:printer/src/network/model/product_model.dart';
import 'package:printer/src/theme/colors.dart';
import 'package:printer/widgets/froms/input.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (context) => SearchBloc(),
      child: BlocBuilder<SearchBloc, SearchState>(
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
                    SizedBox(
                      width: size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: XInput(
                              value: state.productId,
                              onChanged: (value) => context
                                  .read<SearchBloc>()
                                  .onChangedProductId(value),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Center(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  elevation: 2,
                                  side: const BorderSide(
                                      color: XColors.primary3, strokeAlign: 1),
                                  backgroundColor: XColors.primary2,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 12)),
                              onPressed: () =>
                                  context.read<SearchBloc>().searchProduct(),
                              child: const Text(
                                "Tìm kiếm",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    if (state.productModel.id == "")
                      ListView.builder(
                        itemCount: state.list.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final item = state.list[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: GestureDetector(
                              onTap: () =>
                                  context.read<SearchBloc>().onTapProduct(item),
                              child: Row(
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                              item.image,
                                            ),
                                            fit: BoxFit.scaleDown),
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                            color: XColors.primary3)),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    item.id,
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 18),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    else ...[
                      const Text(
                        "Vị Trí:",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              width: 85,
                              height: 65,
                              child: XInput(
                                value:
                                    state.productModel.shelfNumber.toString(),
                                readOnly: true,
                              )),
                          SizedBox(
                              width: 85,
                              height: 65,
                              child: XInput(
                                value:
                                    state.productModel.columnNumber.toString(),
                                readOnly: true,
                              )),
                          SizedBox(
                              width: 85,
                              height: 65,
                              child: XInput(
                                value:
                                    state.productModel.floorNumber.toString(),
                                readOnly: true,
                              )),
                          IgnorePointer(
                            child: Container(
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
                                value: state.productModel.location,
                                onChanged: (LocationEnum? value) {},
                                items: LocationEnum.values
                                    .map((LocationEnum location) {
                                  return DropdownMenuItem<LocationEnum>(
                                    value: location,
                                    child: Text(location.label),
                                  );
                                }).toList(),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Hình Ảnh:",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(height: 20),
                      (state.productModel.image).isEmpty
                          ? Container(
                              height: 300,
                              width: size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: XColors.primary4,
                              ),
                              child: const Icon(
                                Icons.image_outlined,
                                size: 100,
                                color: XColors.primary2,
                              ),
                            )
                          : Container(
                              height: 300,
                              width: size.width,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                        state.productModel.image,
                                      ),
                                      fit: BoxFit.scaleDown),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: XColors.primary3)),
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
                          onPressed: () => context.read<SearchBloc>().printer(),
                          child: const Text(
                            "IN",
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
                          onPressed: () => context
                              .read<SearchBloc>()
                              .showDeleteConfirmationDialog(context),
                          child: const Text(
                            "Xóa",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.red,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    ]
                  ]),
            ),
          );
        },
      ),
    );
  }
}
