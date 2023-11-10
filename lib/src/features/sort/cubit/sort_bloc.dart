import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
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
    emit(state.copyWith(shelfNumber: int.tryParse(value) ?? 0));
  }

  void onChangedColumnNumber(String value) {
    emit(state.copyWith(columnNumber: int.tryParse(value) ?? 0));
  }

  void onChangedFloorNumber(String value) {
    emit(state.copyWith(floorNumber: int.tryParse(value) ?? 0));
  }

  void onChangedLocation(LocationEnum value) {
    emit(state.copyWith(location: value));
  }

  void printer() {
    XToast.show("Tính năng đang phát triển");
  }
}
