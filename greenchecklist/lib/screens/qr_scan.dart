import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

typedef QrResult = Future<bool> Function(String);

class QRScan extends GetView {
  QRScan(this.qrResult, {Key? key})
      : super(
          key: key,
        );

  double width = 0;
  double height = 0;

  Barcode? result;
  QRViewController? qrController;
  RxBool isLoading = false.obs;
  Rx<IconData> flash = Icons.flash_off.obs;

  Color borderColor = Colors.green;
  QrResult qrResult;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: ()async{
        qrController?.dispose();
        return true;
      },
      child: Scaffold(
        body: Stack(
          children: [
            _buildQrView(),
            Positioned(
              top: 32,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      color: Colors.white,
                      icon: const Icon(Icons.arrow_back)),
                  IconButton(
                      onPressed: () {
                        qrController?.toggleFlash();
                        flash((flash == Icons.flash_on)
                            ? Icons.flash_off
                            : Icons.flash_on);
                      },
                      color: Colors.white,
                      icon: Obx(() => Icon(flash.value))),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildQrView() {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (width < 400 || height < 400) ? 250.0 : 400.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return Stack(
      children: [
        QRView(
          key: GlobalKey(debugLabel: 'QR'),
          onQRViewCreated: (qr) {
            qrController = qr;
            qr.resumeCamera();

            qrController?.scannedDataStream.listen((scanData) async {
              result = scanData;
              if (result != null && result?.code != null && !isLoading.value) {
                qrController?.pauseCamera();
                isLoading(true);
                var res = await qrResult(result?.code ?? '');
                if (res) {
                  qrController?.dispose();
                } else {
                  Future.delayed(const Duration(seconds: 2), () {
                    qrController?.resumeCamera();
                    isLoading(false);
                  });
                }
              }
            });
          },
          overlay: QrScannerOverlayShape(
              borderColor: borderColor,
              borderRadius: 10,
              borderLength: 30,
              borderWidth: 10,
              cutOutSize: scanArea),
          onPermissionSet: (ctrl, p) async {
            if (!p) {
              ScaffoldMessenger.of(Get.context!).showSnackBar(
                  const SnackBar(content: Text('Camera Permission Denied')));
              var status = await Permission.camera.request();
              if (status.isDenied || status.isPermanentlyDenied) {
                if (Platform.isIOS) {
                  showDialog(
                      context: Get.context!,
                      builder: (BuildContext context) => CupertinoAlertDialog(
                            title: const Text('Camera Permission'),
                            content: const Text(''),
                            actions: <Widget>[
                              CupertinoDialogAction(
                                child: const Text('Deny'),
                                onPressed: () => Navigator.pop(context),
                              ),
                              CupertinoDialogAction(
                                child: const Text('Settings'),
                                onPressed: () => openAppSettings(),
                              ),
                            ],
                          ));
                } else {
                  if (await Permission.camera.isPermanentlyDenied) {
                    openAppSettings();
                  } else {
                    await Permission.camera.request();
                  }
                }
              }
            }
          },
        ),
        Obx(() => Visibility(
              visible: isLoading.value,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ))
      ],
    );
  }
}
