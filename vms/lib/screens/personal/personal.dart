import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i2iutils/widgets/boxedittext.dart';
import 'package:i2iutils/widgets/button.dart';
import 'package:i2iutils/widgets/spinner.dart';
import 'package:vms/helper/colors.dart';
import 'package:vms/model/visitor.dart';
import 'package:vms/screens/personal/personal_controller.dart';

class Personal extends GetView<PersonalController> {
  @override
  final controller = Get.put(PersonalController());

  Personal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Visitor Details',
          ),
        ),
        body: SingleChildScrollView(
          child: GestureDetector(
            onTap: () => {Get.focusScope?.unfocus()},
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildCard(),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          'Visitor Details',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black),
                        ),
                        const Divider(),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Obx(() {
                              return CircleAvatar(
                                backgroundColor: primary.withOpacity(0.8),
                                radius: 30,
                                child: InkWell(
                                    onTap: () => {
                                          controller.getUserImage(),
                                        },
                                    child:
                                        controller.userImagePath.value != null
                                            ? CircleAvatar(
                                                backgroundImage: MemoryImage(
                                                    controller
                                                        .userImagePath.value!),
                                                radius: 28,
                                              )
                                            : controller.visitImage.isNotEmpty
                                                ? CircleAvatar(
                                                    backgroundImage:
                                                        NetworkImage(controller
                                                            .visitImage.value),
                                                    radius: 28,
                                                    onBackgroundImageError:
                                                        (_, __) {
                                                      const CircleAvatar(
                                                        backgroundImage: AssetImage(
                                                            'assets/vms/userpic-8.png'),
                                                        radius: 28,
                                                      );
                                                    },
                                                  )
                                                : const CircleAvatar(
                                                    backgroundImage: AssetImage(
                                                        'assets/vms/userpic-8.png'),
                                                    radius: 28,
                                                  )),
                              );
                            }),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: BoxEditText(
                                placeholder: 'Name',
                                maxLines: 1,
                                readOnly: controller.visitor.value.readOnly,
                                controller: controller.namecontroller.value,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        BoxEditText(
                          placeholder: 'Mobile No',
                          maxLines: 1,
                          readOnly: true,
                          controller: controller.mobilecontroller.value,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        BoxEditText(
                          placeholder: 'Coming from',
                          maxLines: 1,
                          controller: controller.loccontroller.value,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(color: Colors.grey, blurRadius: 0.5)
                              ]),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              SizedBox(
                                width: MediaQuery.of(context).size.width - 130,
                                child: TextFormField(
                                    controller: controller.tempController.value,
                                    textInputAction: TextInputAction.next,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                    ),
                                    maxLines: 1,
                                    maxLength: 3,
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            signed: true),
                                    decoration: const InputDecoration(
                                      filled: false,
                                      counter: null,
                                      counterText: '',
                                      border: InputBorder.none,
                                      hintText: 'Body Temp',
                                      hintStyle: TextStyle(
                                          color: Colors.grey, fontSize: 13),
                                      contentPadding: EdgeInsets.all(12),
                                    )),
                              ),
                              Obx(() {
                                return Spinner(
                                    controller.temp.value, controller.templists,
                                    width: 80, onChanged: null);
                              }),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Obx(() {
                          return Spinner(
                              controller.proof.value, controller.prooflists,
                              hint: controller.proofhint.value,
                              onChanged: (val) {
                            controller.proof(val);
                          });
                        }),
                        const SizedBox(
                          height: 8,
                        ),
                        BoxEditText(
                          width: MediaQuery.of(context).size.width,
                          placeholder: 'Id Proof Number',
                          maxLines: 1,
                          controller: controller.proofController.value,
                        ),
                        /*Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            BoxEditText(
                              width: MediaQuery.of(context).size.width - 120,
                              placeholder: 'Id Proof Number',
                              maxLines: 1,
                              controller: controller.proofController.value,
                            ),
                            Obx(() {
                              return InkWell(
                                onTap: () => {controller.getProofImage()},
                                child: controller.proofImagePath.value != null
                                    ? Image.memory(
                                        controller.proofImagePath.value!,
                                        width: 40,
                                        height: 40,
                                        errorBuilder: (_, __, ___) {
                                          return Image.asset(
                                            'assets/vms/idprooficon-8.png',
                                            width: 30,
                                            height: 30,
                                            color: Colors.red,
                                          );
                                        },
                                      )
                                    : Image.asset(
                                        'assets/vms/idprooficon-8.png',
                                        width: 30,
                                        height: 30,
                                        color: Colors.red,
                                      ),
                              );
                            }),
                          ],
                        ),*/
                        const SizedBox(
                          height: 8,
                        ),
                        Obx(() {
                          return Spinner(
                              controller.purpose.value, controller.purposelists,
                              hint: controller.visithint.value,
                              onChanged: controller.visitor.value.readOnly
                                  ? null
                                  : (val) {
                                      controller.purpose(val);
                                    });
                        }),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                            padding: const EdgeInsets.only(left: 12),
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(color: Colors.grey, blurRadius: 0.5)
                                ]),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Have Accessories',
                                ),
                                Obx(
                                  () => Switch(
                                    value: controller.haveacc.value,
                                    onChanged: (val) {
                                      Get.focusScope?.unfocus();
                                      controller.haveacc(val);
                                    },
                                  ),
                                ),
                              ],
                            )),
                        Obx(
                          () => Visibility(
                            visible: controller.haveacc.value,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: SizedBox(
                                width: 160,
                                child: TextButton(
                                  onPressed: () => controller.addAccessory(),
                                  child: Row(
                                    children: const [
                                      Icon(
                                        Icons.add,
                                        color: primary,
                                        size: 15,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        'Add Accessories',
                                        style: TextStyle(color: primary),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Obx(() {
                          return controller.haveacc.value &&
                                  controller.accessory.value.isNotEmpty
                              ? ListView.separated(
                                  itemBuilder: (context, index) {
                                    Accessory acc =
                                        controller.accessory.value[index];

                                    return Row(
                                      children: [
                                        Expanded(
                                            child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${index + 1}',
                                              textAlign: TextAlign.center,
                                            ),
                                            const SizedBox(
                                              width: 16,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  acc.name,
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                Text(
                                                  acc.desc,
                                                  maxLines: 3,
                                                  style: const TextStyle(
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        )),
                                        IconButton(
                                          icon: const Icon(
                                            Icons.delete,
                                            color: primary,
                                            size: 16,
                                          ),
                                          onPressed: () {
                                            controller.deleteAcc(acc);
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                  itemCount: controller.accessory.value.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return const Divider();
                                  },
                                )
                              : const SizedBox.shrink();
                        })
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      CustomButton(
                          buttonText: 'Next',
                          width: 150,
                          height: 80,
                          padding: const EdgeInsets.all(16),
                          onPressed: () => controller.nextPage()),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  _buildCard() {
    return Card(
      elevation: 6,
      color: primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -20,
            right: -30,
            child: Container(
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: [
                    Color.fromRGBO(250, 250, 250, 1),
                    Color.fromRGBO(240, 240, 240, 1),
                  ])),
              width: 130,
              height: 100,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: Image.asset(
                'assets/vms/calendar-8.png',
                width: 50,
                height: 50,
              ),
              title: Text(
                controller.today,
                style: const TextStyle(fontSize: 13, color: Colors.white),
              ),
              subtitle: Text(
                controller.time,
                style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              trailing: Column(
                children: <Widget>[
                  Image.asset(
                    'assets/vms/sun-8.png',
                    width: 40,
                    height: 40,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
