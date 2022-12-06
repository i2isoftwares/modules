import 'package:barcode_widget/barcode_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vms/routes/vms_app_routes.dart';
import 'package:vms/screens/ticket/ticket_controller.dart';

class TicketScreen extends GetView<TicketController> {
  @override
  final controller = Get.put(TicketController());

  TicketScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAndToNamed(VMSRoutes.HOME);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Visitor Pass'),
        ),
        body: Container(
          margin: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Obx(
              //   () => CachedNetworkImage(
              //     imageUrl: controller.compLogo.value,
              //     width: Get.width * 0.7,
              //     height: Get.height * 0.2,
              //     errorWidget: (_, __, ___) {
              //       return CachedNetworkImage(
              //         imageUrl:
              //             'https://ifazility.com/static/logo-company-snowaski.com/Android/16.png',
              //       );
              //     },
              //   ),
              // ),
              // const SizedBox(
              //   height: 12,
              // ),
              _buildTicket(),
              Container(
                padding: const EdgeInsets.all(16),
                child: TextButton(
                  onPressed: () => Get.offAndToNamed(VMSRoutes.HOME),
                  child: const Text('Back'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildTicket() {
    return Card(
      elevation: 8,
      color: Colors.white,
      child: Container(
        margin: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
        padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        controller.visitor.visitTowerName ?? '',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 35,
                        ),
                      ),
                      Text(
                        controller.visitor.visitCompName ?? '',
                        maxLines: 2,
                        style: const TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        controller.visitor.visitorName ?? '',
                        maxLines: 2,
                        style: const TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        controller.visitor.mobileNo ?? '',
                        maxLines: 1,
                        style: const TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        controller.visitor.visitingDateTime ?? '',
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    BarcodeWidget(
                      barcode: Barcode.qrCode(),
                      data: "${controller.visitor.barcodeImage ?? -1}",
                      width: Get.width * 0.3,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    CachedNetworkImage(
                      imageUrl: controller.compLogo.value,
                      width: 70,
                      errorWidget: (_, __, ___) {
                        return CachedNetworkImage(
                          imageUrl:
                              'https://ifazility.com/static/logo-company-snowaski.com/Android/16.png',
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Powered by',
                  style: TextStyle(
                    fontSize: 10,
                    letterSpacing: 2,
                    color: Colors.grey.withOpacity(0.5),
                  ),
                ),
                CachedNetworkImage(
                  imageUrl:
                      'https://ifazility.com/static/logo-company-snowaski.com/Android/16.png',
                  width: 50,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
