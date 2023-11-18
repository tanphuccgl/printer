import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:printer/src/features/scan/pages/scan_page.dart';
import 'package:printer/src/network/domain.dart';
import 'package:printer/src/network/model/product_model.dart';

import 'package:printer/widgets/dialogs/toast_wrapper.dart';

part 'sort_state.dart';

class SortBloc extends Cubit<SortState> {
  SortBloc() : super(const SortState());

  Domain get domain => GetIt.I<Domain>();

  void sortProduct() async {
    if (state.productId.isEmpty) {
      XToast.error("Vui lòng nhập mã sản phẩm");
      return;
    }

    XToast.showLoading();

    final result =
        await domain.product.updateProduct(productId: state.productId, item: {
      "location": state.location.nameOf,
      "updateAt": Timestamp.now(),
      "columnNumber": state.columnNumber,
      "floorNumber": state.floorNumber,
      "shelfNumber": state.shelfNumber,
    });
    if (result.isSuccess) {
      emit(const SortState());
      XToast.success("Xếp chổ sản phẩm thành công");
      XToast.hideLoading();
      return;
    }

    emit(const SortState());
    XToast.error("Xếp chổ sản phẩm thất bại");
    XToast.hideLoading();
  }

  void onChangedProductId(String value) {
    emit(state.copyWith(productId: value));
  }

  void onChangedShelfNumber(String value) {
    emit(state.copyWith(shelfNumber: value));
  }

  void onChangedColumnNumber(String value) {
    emit(state.copyWith(columnNumber: value));
  }

  void onChangedFloorNumber(String value) {
    emit(state.copyWith(floorNumber: value));
  }

  void onChangedLocation(LocationEnum value) {
    emit(state.copyWith(location: value));
  }

  void scan(BuildContext context, bool scanId) async {
    if (scanId) {
      final String? result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ScanQrPage()),
      );

      try {
        if (result != null) {
          if (result == "") {
            return;
          }
          if (result == "error") {
            XToast.error("Mã không hợp lệ");
          } else {
            emit(state.copyWith(productId: result));
          }
        } else {
          XToast.error("Mã không hợp lệ");
        }
      } catch (e) {
        XToast.error("Mã không hợp lệ");
      }
    } else {
      final String? result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ScanQrPage()),
      );

      try {
        if (result != null) {
          if (result == "") {
            return;
          }
          if (result == "error") {
            XToast.error("Vị trí không hợp lệ");
          } else {
            final list = _separateString(result);
            emit(state.copyWith(
              shelfNumber: list[0],
              columnNumber: list[1],
              floorNumber: list[2],
              location: LocationEnum.fromString(list[3]),
            ));
          }
        } else {
          XToast.error("Mã không hợp lệ");
        }
      } catch (e) {
        XToast.error("Vị trí không hợp lệ");
      }
    }
  }

  List<String> _separateString(String input) {
    // Tách chuỗi bằng dấu cách và trả về một danh sách (List) các giá trị
    return input.split(' ');
  }
}
