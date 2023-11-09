import 'package:flutter/material.dart';
import 'package:printer/src/theme/colors.dart';
import 'package:printer/widgets/froms/input.dart';

class SortPage extends StatelessWidget {
  const SortPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 30,
            horizontal: 15,
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text(
              "Nhập Mã:",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(height: 20),
            const XInput(value: ""),
            const SizedBox(height: 20),
            const Text(
              "Nhập Vị Trí:",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(height: 20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 85, height: 65, child: XInput(value: "")),
                SizedBox(width: 85, height: 65, child: XInput(value: "")),
                SizedBox(width: 85, height: 65, child: XInput(value: "")),
                SizedBox(
                    width: 85,
                    height: 65,
                    child: XInput(
                      value: "",
                      showArrowIcon: true,
                    )),
              ],
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
                onPressed: () {},
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
                onPressed: () {},
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
      ),
    );
  }
}
