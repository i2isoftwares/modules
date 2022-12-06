import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:vms/helper/colors.dart';
import 'package:vms/screens/home/home_controller.dart';
import 'package:i2iutils/widgets/boxedittext.dart';
import 'package:i2iutils/widgets/spinner.dart';

class Home extends GetView<HomeController> {
  @override
  final controller = Get.put(HomeController());

  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        title:
            const Text('Visitor Management', style: TextStyle(fontSize: 17)),
      ),
      body: RefreshIndicator(
          onRefresh: () async {
            await controller.getDashboardInfo();
          },
          child: GestureDetector(
            onTap: () => Get.focusScope?.unfocus(),
            child: Stack(
              children: [
                SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 18),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Obx(() {
                          return Spinner(
                            controller.company.value,
                            controller.companylists,
                            hint: 'Select Company',
                            fontSize: 12,
                            onChanged: (val) => controller.changeCompany(val),
                          );
                        }),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 4),
                                child: Obx(() {
                                  return Spinner(controller.location.value,
                                      controller.locationlists,
                                      hint: 'Select Location',
                                      fontSize: 12,
                                      onChanged: (val) =>
                                          controller.changeLocation(val));
                                }),
                              ),
                            ),
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 4),
                                child: Obx(() {
                                  return Spinner(controller.gate.value,
                                      controller.gatelists.value,
                                      hint: 'Select Gate',
                                      fontSize: 12,
                                      onChanged: (val) =>
                                          controller.changeGate(val));
                                }),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                controller.scanEntry();
                              },
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      'assets/vms/entry.png',
                                      width: 30,
                                      height: 30,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  const Text(
                                    'Scan QRCode\nTo Entry',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 9,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(32),
                                child: Obx(
                                  () => CachedNetworkImage(
                                    imageUrl: controller.compLogo.value,
                                    height: MediaQuery.of(context).size.height *
                                        0.1,
                                    errorWidget: (_, __, ___) {
                                      return CachedNetworkImage(
                                        imageUrl:
                                            'https://ifazility.com/static/logo-company-snowaski.com/Android/16.png',
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                controller.scanExit();
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      'assets/vms/exit.png',
                                      width: 30,
                                      height: 30,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  const Text(
                                    'Scan QRCode\nTo Exit',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 9,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        /*const SizedBox(
                          height: 16,
                        ),*/
                        /*const Text(
                          'Search by entering your mobile number',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Colors.black54),
                        ),
                        const SizedBox(
                          height: 16,
                        ),*/
                        BoxEditText(
                          placeholder: 'Mobile Number',
                          controller: controller.mobileController,
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(0)),
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.black,
                              ),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 1,
                                    offset: Offset(3, 3))
                              ]),
                          prefixIcon: const Icon(
                            Icons.phone,
                            size: 15,
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
                          textInputAction: TextInputAction.search,
                          keyboardType: TextInputType.phone,
                          maxLength: 10,
                          maxLines: 1,
                          onSubmitted: (_) => controller.submitMobileNo(),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        const Text(
                          'Analytics',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Obx(
                          () => Flexible(
                            child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: controller.list.length,
                                itemBuilder: (_, index) {
                                  return buildNewCard(
                                      controller.list[index], index);
                                }),
                          ),
                        ),
                        /* Obx(
                          () => Flexible(
                            child: controller.list.isEmpty
                                ? const Center(
                                    child: Text(
                                      'No Records Found',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    ),
                                  )
                                : GridView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            childAspectRatio: 1.6,
                                            mainAxisSpacing: 15,
                                            crossAxisSpacing: 10),
                                    itemCount: controller.list.length,
                                    itemBuilder: (_, index) {
                                      return buildCard(controller.list[index]);
                                    }),
                          ),
                        ),*/
                      ],
                    ),
                  ),
                ),
                Obx(() => controller.isLoading.value
                    ? Container(
                        width: Get.width,
                        height: Get.height,
                        color: Colors.white54,
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: primary,
                          ),
                        ),
                      )
                    : const SizedBox.shrink()),
              ],
            ),
          ),
        ),
    );
  }

  buildCard(
    var item,
  ) {
    return GestureDetector(
      onTap: () {
        controller.onCardClicked(item);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(6)),
            gradient: gradient,
            boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 0.5)]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              '${item['title']}',
              maxLines: 2,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              '${item['value']}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }

  buildNewCard(var item, var index) {
    return GestureDetector(
      onTap: () {
        Get.focusScope?.unfocus();
        controller.onCardClicked(item);
      },
      child: Container(
        height: 130,
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(6)),
            gradient: gradients[index % 3],
            boxShadow: [
              BoxShadow(
                  offset: const Offset(10, 20),
                  blurRadius: 10,
                  spreadRadius: 0,
                  color: Colors.grey.withOpacity(.05)),
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 70,
                  height: 70,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      shape: BoxShape.circle),
                  child: CachedNetworkImage(
                    imageUrl: item['icon'] ?? index == 0
                        ? 'https://cdn-icons-png.flaticon.com/512/1747/1747119.png'
                        : index == 1
                            ? 'https://cdn-icons-png.flaticon.com/512/2413/2413874.png'
                            : 'https://cdn-icons-png.flaticon.com/512/3284/3284598.png',
                    fit: BoxFit.contain,
                  ),
                ),
                Text(
                  '${item['title']}',
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            Text(
              '${item['value']}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
