import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:printer/src/features/add_new_code/cubit/add_new_code_bloc.dart';
import 'package:printer/src/theme/colors.dart';
import 'package:printer/widgets/froms/input.dart';

class AddNewCodePage extends StatelessWidget {
  const AddNewCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (_) => AddNewCodeBloc(),
      child: BlocBuilder<AddNewCodeBloc, AddNewCodeState>(
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 30,
                  horizontal: 15,
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        "Nhập Tên:",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(height: 20),
                      XInput(
                        value: state.name,
                        onChanged: (value) =>
                            context.read<AddNewCodeBloc>().onChangedName(value),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Chọn Ảnh:",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 2,
                            side: const BorderSide(
                                color: XColors.primary3, strokeAlign: 1),
                            backgroundColor: XColors.primary2,
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 12)),
                        onPressed: () => context
                            .read<AddNewCodeBloc>()
                            .onCameraButton(context),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.add_box_outlined,
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Thêm Ảnh Mới",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      state.fileImage != null
                          ? Expanded(
                              child: Container(
                              height: 170,
                              width: size.width,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: FileImage(
                                        File(state.fileImage!.path),
                                      ),
                                      fit: BoxFit.scaleDown),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: XColors.primary3)),
                            ))
                          : Expanded(
                              child: Container(
                                height: 170,
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
                              ),
                            ),
                      const SizedBox(height: 20),
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              minimumSize: Size(size.width, 40),
                              side: const BorderSide(
                                  color: XColors.primary3, strokeAlign: 1),
                              elevation: 2,
                              backgroundColor: XColors.primary2,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 12)),
                          onPressed: () =>
                              context.read<AddNewCodeBloc>().createNewProduct(),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.add_box_outlined,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Thêm Mới",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
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
                          onPressed: () =>
                              context.read<AddNewCodeBloc>().printer(),
                          child: const Text(
                            "Xác Nhận Và In",
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
            ),
          );
        },
      ),
    );
  }
}
