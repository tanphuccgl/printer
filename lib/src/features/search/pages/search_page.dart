import 'package:flutter/material.dart';
import 'package:printer/src/theme/colors.dart';
import 'package:printer/widgets/froms/input.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Expanded(
                  child: XInput(value: ""),
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
                    onPressed: () {},
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
            const SizedBox(height: 20),
            const Text(
              "Hình Ảnh:",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
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
                    side: const BorderSide(
                        color: XColors.primary3, strokeAlign: 1),
                    minimumSize: Size(size.width, 40),
                    elevation: 2,
                    backgroundColor: XColors.primary2,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 12)),
                onPressed: () {},
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
                onPressed: () {},
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
          ]),
        ),
      ),
    );
  }
}
