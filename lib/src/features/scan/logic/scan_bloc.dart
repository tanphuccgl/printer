import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:printer/widgets/dialogs/toast_wrapper.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

part 'scan_state.dart';

class ScanBloc extends Cubit<ScanState> {
  final BuildContext context;
  ScanBloc(
    this.context,
  ) : super(const ScanState()) {
    _getCameraPermission();
  }

  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final Logger _log = Logger();

  Future<PermissionStatus> _getCameraPermission() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      return await Permission.camera.request();
    } else {
      return status;
    }
  }

  void onQRViewCreated(QRViewController controllerValue) {
    controller = controllerValue;
    scannedStream();
  }

  void scannedStream() {
    if (controller == null) return;
    controller!.scannedDataStream.listen((scanData) {
      if (scanData.code != null) {
        emit(state.copyWith(barcode: scanData));
        if (state.barcode != null) {
          controller?.stopCamera();
          Navigator.pop(context, scanData.code);
        }
      }
    });
  }

  void onPermissionSet(
    bool p,
  ) {
    _log.i('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      XToast.show('Không có quyền');
    }
  }

  @override
  Future<void> close() {
    controller?.dispose();

    return super.close();
  }
}
