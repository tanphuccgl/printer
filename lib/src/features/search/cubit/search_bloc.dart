import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:printer/src/network/domain.dart';
import 'package:printer/src/network/model/product_model.dart';
import 'package:printer/widgets/dialogs/toast_wrapper.dart';

part 'search_state.dart';

class SearchBloc extends Cubit<SearchState> {
  SearchBloc() : super(SearchState.ds()) {
    init();
  }

  Domain get domain => GetIt.I<Domain>();

  void init() {
    getAllProduct();
  }

  Future<void> getAllProduct() async {
    final result = await domain.product.getAllProduct();
    if (result.isSuccess) {
      emit(state.copyWith(list: result.data));
    }
  }

  void onTapProduct(ProductModel data) {
    onChangedProductId(data.id);
    searchProduct();
  }

  void searchProduct() async {
    if (state.productId.isEmpty) {
      XToast.error("Vui lòng nhập mã sản phẩm");
      return;
    }

    XToast.showLoading();

    final result = await domain.product.getProduct(state.productId);
    if (result.isSuccess) {
      emit(state.copyWith(productModel: result.data));
      XToast.hideLoading();
      return;
    }

    emit(SearchState.ds());
    await getAllProduct();
    XToast.error("Không tìm thấy sản phẩm");
    XToast.hideLoading();
  }

  void onChangedProductId(String value) {
    emit(state.copyWith(productId: value));
  }

  void printer() {
    XToast.show("Tính năng đang phát triển");
  }

  void deleteProduct() async {
    if (state.productId.isEmpty) {
      XToast.error("Vui lòng nhập mã sản phẩm");
      return;
    }

    XToast.showLoading();

    final result = await domain.product.deleteProduct(state.productId);
    if (result.isSuccess) {
      await getAllProduct();
      XToast.error("Xóa sản phẩm thành công");
      emit(SearchState.ds());
      XToast.hideLoading();
      return;
    }
    await getAllProduct();
    emit(SearchState.ds());
    XToast.error("Xóa sản phẩm thất bại");
    XToast.hideLoading();
  }
}
