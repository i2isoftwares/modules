import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i2iutils/widgets/boxedittext.dart';
import 'package:i2iutils/widgets/button.dart';

import '../model/visitor.dart';
import '../screens/qr_scan.dart';
import 'colors.dart';

void showLoader({String? title}) {
  hideLoader();
  Get.dialog(
    WillPopScope(
      onWillPop: () async => false,
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircularProgressIndicator(
                color: primary,
              ),
              const SizedBox(
                width: 16,
              ),
              Text(
                title ?? 'Please wait',
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              )
            ],
          ),
        ),
      ),
    ),
    barrierDismissible: false,
  );
}

void hideLoader() {
  print('isOpen ? ${Get.isDialogOpen}');
  (Get.isDialogOpen ?? false) ? Get.back() : null;
}

Future showAccessoryDialog() async {
  TextEditingController name = TextEditingController(),
      desc = TextEditingController();

  return await showDialog(
    context: Get.context!,
    barrierDismissible: true,
    builder: (BuildContext con) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        backgroundColor: Colors.grey[100],
        child: Container(
            margin: const EdgeInsets.all(8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Accessory Entry',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Divider(),
                BoxEditText(
                  placeholder: 'Accessory Name',
                  maxLines: 1,
                  controller: name,
                ),
                const SizedBox(
                  height: 8,
                ),
                BoxEditText(
                  placeholder: 'Accessory Description',
                  maxLines: 3,
                  controller: desc,
                ),
                CustomButton(
                    buttonText: 'Add',
                    smallText: true,
                    width: 120,
                    height: 55,
                    padding: const EdgeInsets.all(12),
                    onPressed: () {
                      if (name.text.isNotEmpty) {
                        Get.back(result: Accessory(name.text, desc.text));
                      } else {
                        Get.back(result: null);
                      }
                    }),
              ],
            )),
      );
    },
  );
}

String findIdByList(dynamic arrValue, dynamic arrIds, String val) {
  int id = arrValue.value.indexWhere((element) => element == val);
  if (id < 0) return id.toString();
  return arrIds[id].toString();
}

showAlert(String title, String msg, String posBtnText,
    {bool isDismiss = true, bool isOneButton = false}) {
  Get.focusScope?.unfocus();
  return showDialog(
    context: Get.context!,
    barrierDismissible: isDismiss,
    builder: (BuildContext con) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              const Divider(),
              Text(
                msg,
                style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  isOneButton
                      ? const SizedBox(
                          width: 100,
                        )
                      : CustomButton(
                          width: 100,
                          smallText: true,
                          buttonText: 'Cancel',
                          buttonColor: primary,
                          onPressed: () {
                            Get.back(result: false);
                          }),
                  CustomButton(
                      width: 100,
                      smallText: true,
                      buttonText: posBtnText,
                      onPressed: () {
                        Get.back(result: true);
                      }),
                ],
              )
            ],
          ),
        ),
      );
    },
  );
}

qrScan() async {
  return await Get.to(QRScan((qrResult) async {
    debugPrint(qrResult);
    Get.back(result: qrResult);
    return Future(() => true);
  }));
}
