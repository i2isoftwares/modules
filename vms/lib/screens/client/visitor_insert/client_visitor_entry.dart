import 'package:flutter/material.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:get/get.dart';
import 'package:vms/helper/colors.dart';
import 'package:vms/screens/client/visitor_insert/client_visitor_entry_controller.dart';
import 'package:i2iutils/widgets/boxedittext.dart';
import 'package:i2iutils/widgets/button.dart';
import 'package:i2iutils/widgets/spinner.dart';

class ClientVisitorEntryScreen extends GetView<ClientVisitorEntryController> {
  ClientVisitorEntryScreen({Key? key}) : super(key: key);

  @override
  final controller = Get.put(ClientVisitorEntryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: Text(controller.visitor == null
            ? 'Invite Visitor'
            : controller.visitor!.clientVisitorID == 0
                ? 'Invite Visitor'
                : 'Edit Visitor'),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Mobile No'),
                      const SizedBox(
                        height: 4,
                      ),
                      BoxEditText(
                        placeholder: 'Mobile No',
                        maxLines: 1,
                        maxLength: 10,
                        keyboardType: TextInputType.phone,
                        controller: controller.mobileController,
                        textInputAction: TextInputAction.search,
                        onSubmitted: (_) => controller.submitMobileNo(),
                        prefixIcon: InkWell(
                          onTap: () async {
                            if (await FlutterContactPicker.hasPermission()) {
                              controller.getNumber();
                            } else {
                              await FlutterContactPicker.requestPermission(
                                  force: true);
                            }
                          },
                          child: const Icon(
                            Icons.contacts,
                            size: 15,
                          ),
                        ),
                        suffixIcon: InkWell(
                          onTap: () {
                            controller.submitMobileNo();
                          },
                          child: const Icon(
                            Icons.search,
                            size: 15,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text('Visitor Name'),
                      const SizedBox(
                        height: 4,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: BoxEditText(
                              placeholder: 'First Name',
                              maxLines: 1,
                              controller: controller.fNameController,
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: BoxEditText(
                              placeholder: 'Last Name',
                              maxLines: 1,
                              controller: controller.lNameController,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text('Email Id'),
                      const SizedBox(
                        height: 4,
                      ),
                      BoxEditText(
                        placeholder: 'Email Id',
                        maxLines: 1,
                        keyboardType: TextInputType.emailAddress,
                        controller: controller.emailController,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text('Meeting Date'),
                      const SizedBox(
                        height: 4,
                      ),
                      BoxEditText(
                        placeholder: 'Meeting Date',
                        onTab: () {
                          controller.selectDate();
                        },
                        maxLines: 1,
                        readOnly: true,
                        controller: controller.dateController,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text('Meeting Time'),
                      const SizedBox(
                        height: 4,
                      ),
                      BoxEditText(
                        placeholder: 'Meeting Time',
                        onTab: () {
                          controller.selectTime();
                        },
                        maxLines: 1,
                        readOnly: true,
                        controller: controller.timeController,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text('Purpose Of Visit'),
                      const SizedBox(
                        height: 4,
                      ),
                      Obx(() => Spinner(
                              controller.purpose.value, controller.purposeLists,
                              hint: 'Select Purpose', onChanged: (val) {
                            controller.purpose(val);
                          })),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text('Select Building'),
                      const SizedBox(
                        height: 4,
                      ),
                      Obx(() {
                        return Spinner(
                            controller.building.value, controller.buildingList,
                            hint: 'Select Building', onChanged: (val) {
                          controller.building(val);
                        });
                      }),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text('Person To Meet?'),
                      const SizedBox(
                        height: 4,
                      ),
                      BoxEditText(
                        placeholder: 'Person to meet',
                        maxLines: 1,
                        controller: controller.personController,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      CustomButton(
                        buttonText: controller.visitor == null
                            ? 'Create Visitor Pass'
                            : controller.visitor!.clientVisitorID == 0
                                ? 'Create Visitor Pass'
                                : 'Edit Visitor Pass',
                        margin: const EdgeInsets.all(16),
                        onPressed: () => controller.create(),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Obx(() => controller.isLoading.value
              ? Container(
                  width: Get.width,
                  height: Get.height,
                  color: Colors.black26,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: primary,
                    ),
                  ),
                )
              : const SizedBox.shrink())
        ],
      ),
    );
  }
}
