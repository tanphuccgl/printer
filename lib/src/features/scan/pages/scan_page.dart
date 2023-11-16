import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:printer/src/features/scan/logic/scan_bloc.dart';
import 'package:printer/src/theme/colors.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanQrPage extends StatelessWidget {
  const ScanQrPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ScanBloc(),
      child: BlocBuilder<ScanBloc, ScanState>(
        builder: (context, state) {
          final bloc = context.read<ScanBloc>();

          return Scaffold(
            body: Stack(children: [
              QRView(
                key: bloc.qrKey,
                onQRViewCreated: (p0) => bloc.onQRViewCreated(p0),
                overlay: QrScannerOverlayShape(
                  borderColor: Colors.grey,
                  borderWidth: 12,
                  borderRadius: 5,
                  borderLength: 20,
                  cutOutSize: 250.0.w,
                ),
                onPermissionSet: (ctrl, p) => bloc.onPermissionSet(
                  // context,
                  // ctrl,
                  p,
                ),
              ),
              //TODO
              (state.barcode != null)
                  ? Center(
                      child: Text(
                        'Barcode Type: ${describeEnum(state.barcode!.format)}   Data: ${state.barcode!.code}',
                        style: const TextStyle(color: Colors.black),
                      ),
                    )
                  : const Center(
                      child: Text(
                        'Scan a code',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 10.w,
                    top: MediaQuery.of(context).padding.top + 20.h,
                  ),
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(40.w, 40.w),
                      elevation: 0,
                      padding: EdgeInsets.zero,
                      shape: const CircleBorder(),
                      backgroundColor: Colors.white,
                    ),
                    child: const Icon(Icons.close, color: XColors.primary3),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 10.w,
                    top: MediaQuery.of(context).padding.top + 20.h,
                  ),
                  child: ElevatedButton(
                    onPressed: () => bloc.controller?.toggleFlash(),
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(40.w, 40.w),
                      elevation: 0,
                      padding: EdgeInsets.zero,
                      shape: const CircleBorder(),
                      backgroundColor: Colors.white,
                    ),
                    child: const Icon(Icons.flash_on, color: XColors.primary3),
                  ),
                ),
              ),
            ]),
          );
        },
      ),
    );
  }
}
