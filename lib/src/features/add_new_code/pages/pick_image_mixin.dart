import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:printer/src/features/add_new_code/pages/image_picker_services.dart';
import 'package:printer/src/services/permission_services.dart';

mixin PickImageMixin {
  Future<XFile?> pickImage(BuildContext context,
      {required ImageSource imageSource, bool isBack = false}) async {
    final type = imageSource == ImageSource.camera
        ? PermissionTypeEnum.camera
        : PermissionTypeEnum.photo;
    final value = await PermissionService().requestPermission(type);

    if (!value) return null;
    //Hide dialog select type pick
    // ignore: use_build_context_synchronously
    if (isBack) Navigator.pop(context);
    final XFile? photo = await ImagePickerService().onPickImage(imageSource);
    return photo;
  }

  Future<List<XFile>> pickMultiImage() async {
    final value =
        await PermissionService().requestPermission(PermissionTypeEnum.photo);
    if (!value) return [];
    final files = await ImagePickerService().onPickMultiImage();
    return files;
  }
}
