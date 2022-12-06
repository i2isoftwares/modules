import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vms/screens/visitor_view/visitor_view_controller.dart';
import 'package:i2iutils/widgets/button.dart';

class VisitorViewScreen extends GetView<VisitorViewController> {
  @override
  final controller = Get.put(VisitorViewController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visitor View'),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Obx(
                () => controller.msg.value.isEmpty
                    ? const SizedBox.shrink()
                    : Container(
                  width: Get.width,
                        margin: const EdgeInsets.all(6),
                        padding: const EdgeInsets.all(8),
                        color: Colors.redAccent,
                        child: Text(
                          controller.msg.value,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
              ),
              _buildRow('Tenant Name', '${controller.detail.tenantName}'),
              const SizedBox(
                height: 8,
              ),
              _buildRow('Location Name', '${controller.detail.locationName}'),
              const SizedBox(
                height: 8,
              ),
              _buildRow('Building Name', '${controller.detail.buildingName}'),
              const SizedBox(
                height: 8,
              ),
              _buildRow(
                  'Visitor First Name', '${controller.detail.visitorFName}'),
              const SizedBox(
                height: 8,
              ),
              _buildRow(
                  'Visitor Last Name', '${controller.detail.visitorLName}'),
              const SizedBox(
                height: 8,
              ),
              _buildRow(
                  'Visitor From', controller.detail.comeFrom ?? ''),
              const SizedBox(
                height: 8,
              ),
              _buildRow('Contact No', '${controller.detail.contactNo}'),
              const SizedBox(
                height: 8,
              ),
              _buildRow('Email Id', '${controller.detail.emailID}'),
              const SizedBox(
                height: 8,
              ),
              _buildRow('Date', '${controller.detail.visitDate}'),
              const SizedBox(
                height: 8,
              ),
              _buildRow('Time',
                  '${controller.detail.startTime}'),
              const SizedBox(
                height: 8,
              ),
              _buildRow(
                  'Accessory', controller.detail.accessory ?? ''),
              const SizedBox(
                height: 8,
              ),
              _buildRow('Person To Meet', '${controller.detail.whomToVisit}'),
              const SizedBox(
                height: 8,
              ),
              _buildRow(
                  'Purpose Of Visit', '${controller.detail.purposeOfVisit}'),
              const SizedBox(
                height: 24,
              ),
              Obx(
                () => CustomButton(
                  buttonText: 'Submit',
                  onPressed: controller.isValid.value
                      ? () {
                          controller.nextScreen();
                        }
                      : null,
                  smallText: true,
                  width: 100,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildRow(String title, String msg) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
        ),
        Text(
          msg.isEmpty ? '-' : msg,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
