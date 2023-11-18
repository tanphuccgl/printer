// ignore_for_file: depend_on_referenced_packages

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
import 'package:printer/src/theme/colors.dart';
import 'package:printer/widgets/dialogs/toast_wrapper.dart';
import 'package:get_it/get_it.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';

part 'add_new_code_state.dart';

class AddNewCodeBloc extends Cubit<AddNewCodeState> with PickImageMixin {
  AddNewCodeBloc() : super(const AddNewCodeState());

  Domain get domain => GetIt.I<Domain>();

  void createNewProduct(BuildContext context) async {
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

      XToast.hideLoading();
      // ignore: use_build_context_synchronously
      showSuccessDiaog(context, result.data!);
      return;
    }
    emit(const AddNewCodeState());
    XToast.error("Thêm sản phẩm thất bại");
    XToast.hideLoading();
  }

  Future<void> showSuccessDiaog(BuildContext context, ProductModel data) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        final size = MediaQuery.of(context).size;

        return AlertDialog(
          title: const Text('Thêm mới sản phẩm thành công'),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                children: [
                  Text('Mã ID: ${data.id}'),
                  Text("Tên: ${data.name}"),
                  const Text('Hình ảnh'),
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                              data.image,
                            ),
                            onError: (_, __) {
                              const Icon(
                                Icons.image_outlined,
                                size: 50,
                                color: XColors.primary2,
                              );
                            },
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
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        "Xác Nhận",
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
                      onPressed: () => printer(id: data.id, name: data.name),
                      child: const Text(
                        "Print",
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
            ],
          ),
        );
      },
    );
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

  void printer({
    required String id,
    required String name,
  }) async {
    final doc = pw.Document();

    doc.addPage(
      pw.Page(
        pageFormat: const PdfPageFormat(150, 100),
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Column(
              children: [
                pw.Text("Mã $id"),
                pw.SizedBox(height: 5),
                pw.Text("Tên $name"),
                pw.SizedBox(height: 5),
                pw.SizedBox(
                    height: 30,
                    width: 50,
                    child: pw.BarcodeWidget(
                      barcode: pw.Barcode.code128(),
                      data: id,
                      drawText: false,
                    ))
              ],
            ),
          ); // Center
        },
      ),
    ); // Page

    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save());

    /// share the document to other applications:
    // await Printing.sharePdf(
    //     bytes: await doc.save(), filename: 'my-document.pdf');

    /// tutorial for using path_provider: https://www.youtube.com/watch?v=fJtFDrjEvE8
    /// save PDF with Flutter library "path_provider":
    // final output = await getTemporaryDirectory();
    // final file = File('${output.path}/example.pdf');
    // await file.writeAsBytes(await doc.save());
  }
}
