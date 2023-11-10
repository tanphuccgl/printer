import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:printer/src/features/add_new_code/pages/dialog_camera.dart';
import 'package:printer/src/features/add_new_code/pages/pick_image_mixin.dart';
import 'package:printer/src/network/domain.dart';
import 'package:printer/src/network/model/product_model.dart';
import 'package:printer/widgets/dialogs/toast_wrapper.dart';
import 'package:get_it/get_it.dart';
part 'add_new_code_state.dart';

class AddNewCodeBloc extends Cubit<AddNewCodeState> with PickImageMixin {
  AddNewCodeBloc() : super(const AddNewCodeState());

  Domain get domain => GetIt.I<Domain>();

  void createNewProduct() async {
    if (state.name.isEmpty) {
      XToast.error("Vui lòng nhập tên sản phẩm");
      return;
    }

    XToast.showLoading();

    String url = "";
    if (state.fileImage != null) {
      url = await uploadUserAvatar(state.fileImage!) ?? "";
    }

    final product = ProductModel(name: state.name, image: url);

    final result = await domain.product.createProduct(product);
    if (result.isSuccess) {
      emit(const AddNewCodeState());
      XToast.success("Thêm mới sản phẩm thành công");
      XToast.hideLoading();
      return;
    }
    emit(const AddNewCodeState());
    XToast.error("Thêm sản phẩm thất bại");
    XToast.hideLoading();
  }

  void onChangedName(String value) {
    emit(state.copyWith(name: value));
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
    emit(state.copyWith(fileImage: file));
    XToast.success("Tải ảnh lên thành công");
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

  void printer() {
    XToast.show("Tính năng đang phát triển");
  }
}
