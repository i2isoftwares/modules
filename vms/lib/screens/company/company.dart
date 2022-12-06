import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vms/screens/company/company_controller.dart';
import 'package:i2iutils/widgets/spinner.dart';
import 'package:i2iutils/widgets/boxedittext.dart';
import 'package:i2iutils/widgets/button.dart';

class Company extends GetView<CompanyController> {
  @override
  final controller = Get.put(CompanyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Company Details',
        ),
      ),
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () => {
            FocusScope.of(context).unfocus(),
          },
          child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(16),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Company Being Visited',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black),
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 12,
                    ),
                    Obx(() {
                      return Spinner(
                          controller.tenant.value, controller.tenantlist,
                          hint: controller.tenanthint.value,
                          onChanged: controller.visitor.value.readOnly
                              ? null
                              : (val) {
                                  controller.tenant(val);
                                  controller.loadBuilding();
                                });
                    }),
                    const SizedBox(
                      height: 6,
                    ),
                    Obx(() {
                      return Spinner(
                          controller.building.value, controller.buildinglist,
                          hint: controller.buildinghint.value,
                          onChanged: controller.visitor.value.readOnly
                              ? null
                              : (val) {
                                  controller.building(val);
                                });
                    }),
                    const SizedBox(
                      height: 6,
                    ),
                    BoxEditText(
                      placeholder: 'Whom to meet',
                      maxLines: 1,
                      readOnly: controller.visitor.value.readOnly,
                      controller: controller.personController,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    BoxEditText(
                      placeholder: 'Contact no of person to meet',
                      maxLines: 1,
                      maxLength: 10,
                      controller: controller.contactNumber,
                      keyboardType:
                          const TextInputType.numberWithOptions(signed: true),
                      textInputAction: TextInputAction.done,
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.all(16),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Vehicle Details',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black),
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 12,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 12),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.grey, blurRadius: 0.5)
                          ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Text(
                            'Mode Of Travel?',
                          ),
                          Obx(() {
                            return Switch(
                              value: controller.haveveh.value,
                              onChanged: (val) {
                                controller.haveveh(val);
                              },
                            );
                          }),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Obx(() {
                      return controller.haveveh.value
                          ? Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Spinner(controller.veh.value,
                                  controller.vehlists,
                                  width: Get.width - 32,
                                  hint: controller.vehhint.value,
                                  onChanged: (val) {
                                    controller.veh(val);
                                  }),
                              /*InkWell(
                                      onTap: () => {
                                        controller.getVehImage(),
                                      },
                                      child: controller.vehImagePath.value !=
                                              null
                                          ? Image.memory(
                                              controller.vehImagePath.value!,
                                              width: 40,
                                              height: 40,
                                            )
                                          : Image.asset(
                                              'assets/vms/bikepic-8.png',
                                              width: 30,
                                              height: 30,
                                              color: Colors.red,
                                            ),
                                    )*/
                            ],
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          BoxEditText(
                            placeholder: 'Vehicle Number',
                            maxLines: 1,
                            controller: controller.vehNumber,
                            textInputAction: TextInputAction.done,
                          )
                        ],
                      )
                          : const SizedBox.shrink();
                    }),
                  ],
                ),
              ),
              CustomButton(
                buttonText: 'Submit now',
                margin: const EdgeInsets.all(16),
                onPressed: () => controller.confirmPage(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
