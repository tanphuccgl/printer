import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:printer/src/features/add_new_code/pages/dialog_camera.dart';
import 'package:printer/src/features/add_new_code/pages/pick_image_mixin.dart';
import 'package:printer/src/network/domain.dart';
import 'package:printer/src/network/model/product_model.dart';
import 'package:printer/widgets/dialogs/toast_wrapper.dart';

part 'search_state.dart';

class SearchBloc extends Cubit<SearchState> with PickImageMixin {
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

  Future<void> showDeleteConfirmationDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Xác nhận xóa?'),
          content: const Text('Bạn có chắc chắn muốn xóa sản phẩm này?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Hủy'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();

                deleteProduct();
              },
              child: const Text('Xác nhận'),
            ),
          ],
        );
      },
    );
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
      XToast.success("Xóa sản phẩm thành công");
      emit(SearchState.ds());
      getAllProduct();
      XToast.hideLoading();
      return;
    }
    await getAllProduct();
    emit(SearchState.ds());
    getAllProduct();
    XToast.error("Xóa sản phẩm thất bại");
    XToast.hideLoading();
  }

  Future<void> onCameraButton(BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) {
          return XDialogCamera(
              onTapGallery: () => _onPickImage(context, ImageSource.gallery),
              onTapCamera: () => _onPickImage(context, ImageSource.camera));
        });
  }

  Future<void> _onPickImage(
      BuildContext context, ImageSource imageSource) async {
    XToast.showLoading();
    final file =
        await pickImage(context, imageSource: imageSource, isBack: true);

    if (file == null) {
      XToast.hideLoading();
      return;
    }

    final url = await uploadUserAvatar(file) ?? "";
    if (url.isEmpty) {
      XToast.success("Tải ảnh thất bại");
      XToast.hideLoading();
      return;
    }

    final product = state.productModel.copyWith(image: url);

    final result = await domain.product.createProduct(product);
    if (result.isSuccess) {
      emit(state.copyWith(productModel: result.data!));
      XToast.success("Tải ảnh lên thành công");
      XToast.hideLoading();
      return;
    }
    XToast.success("Tải ảnh thất bại");
    XToast.hideLoading();
  }

  static Future<String?> uploadUserAvatar(XFile file) async {
    final storageRef = FirebaseStorage.instance.ref();

    final Reference usersRef = storageRef;
    final newFile = File(file.path);
    try {
      final metadata = SettableMetadata(
        contentType: 'image/jpeg',
      );

      var uploadTask = await usersRef
          .child(file.hashCode.toString())
          .putFile(newFile, metadata);
      return uploadTask.ref.getDownloadURL();
    } catch (error) {
      debugPrint(error.toString());
      return null;
    }
  }
}
