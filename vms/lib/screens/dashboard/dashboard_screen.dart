import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:i2iutils/helpers/common_functions.dart';
import 'package:vms/helper/colors.dart';
import 'package:vms/model/dashboard_detail_response.dart';
import 'package:vms/screens/dashboard/dashboard_controller.dart';
import 'package:i2iutils/widgets/boxedittext.dart';

import '../../helper/utils.dart';

class DashboardScreen extends GetView<DashboardController> {
  @override
  final controller = Get.put(DashboardController());

  DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${controller.item['title']}',
          style: const TextStyle(fontSize: 17),
        ),
        leading: GestureDetector(
          onTap: () => {Get.back()},
          child: const Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(4),
              child: BoxEditText(
                  suffixIcon: const Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  placeholder: 'Search',
                  onChanged: (val) {
                    controller.filterList();
                  },
                  controller: controller.searchController),
            ),
            Obx(
              () => controller.isLoading.value
                  ? const Padding(
                      padding: EdgeInsets.all(16),
                      child: CircularProgressIndicator(color: primary),
                    )
                  : controller.list.isEmpty
                      ? const Padding(
                          padding: EdgeInsets.all(16),
                          child: Text('No Records Found'),
                        )
                      : ListView.separated(
                          padding: const EdgeInsets.all(4),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.list.length,
                          itemBuilder: (_, index) {
                            DashboardDetail detail = controller.list[index];
                            return visitorView(detail);
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const Divider();
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }

  visitorView(DashboardDetail visitor) {
    return InkWell(
      onTap: () {
        Get.bottomSheet(
          bottomSheet(visitor),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
                offset: const Offset(10, 20),
                blurRadius: 10,
                spreadRadius: 0,
                color: Colors.grey.withOpacity(.05)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              CachedNetworkImageProvider(visitor.visitPic),
                          backgroundColor: Colors.grey,
                          radius: 15,
                        ),
                        const SizedBox(
                          width: 6,
                        )
                      ],
                    ),
                    Text(
                      visitor.firstname,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: (visitor.inTime ?? '').isEmpty
                              ? Colors.amber
                              : (visitor.outTime ?? '').isEmpty ? Colors.green:Colors.red),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    call(visitor.phoneno);
                  },
                  onLongPress: () {
                    Clipboard.setData(ClipboardData(text: visitor.phoneno));
                    showToastMsg('Phone no Copied!');
                  },
                  child: Row(
                    children: [
                      const Icon(
                        Icons.phone,
                        size: 12,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        visitor.phoneno,
                        style: const TextStyle(
                          fontSize: 12,
                            decoration: TextDecoration.underline,
                            color: Colors.blue),
                      ),
                    ],
                  ),
                ),
                Text(
                  visitor.purpose,
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  visitor.locationName,
                  style: const TextStyle(fontSize: 12),
                ),
                Text(
                  visitor.buildingName,
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(visitor.persontomeet),
                Text(
                  visitor.persontomeetContact,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
            (visitor.inTime ?? '').isEmpty
                ? const SizedBox.shrink()
                : Column(
                    children: [
                      const SizedBox(
                        height: 4,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.trending_down_outlined,
                                size: 12,
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                visitor.inTime ?? '',
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                          (visitor.outTime ?? '').isEmpty
                              ? const SizedBox.shrink()
                              : Row(
                                  children: [
                                    const Icon(
                                      Icons.trending_up_outlined,
                                      size: 12,
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      visitor.outTime ?? '',
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    ],
                  ),
            const Divider(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                visitor.outTime == null
                    ? GestureDetector(
                        onTap: () {
                          controller.resend(visitor);
                        },
                        child: const Text(
                          'Resend SMS',
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 12,
                              decoration: TextDecoration.underline,
                              letterSpacing: 1),
                        ),
                      )
                    : const SizedBox.shrink(),
                visitor.passlink.isEmpty
                    ? visitor.barcoded.isEmpty
                        ? const SizedBox.shrink()
                        : GestureDetector(
                            onTap: () {
                              controller.scanEntry(visitor.barcoded);
                            },
                            child: const Text('Visitor Entry',
                                style: TextStyle(
                                    color: primary,
                                    fontSize: 12,
                                    decoration: TextDecoration.underline,
                                    letterSpacing: 1)),
                          )
                    : GestureDetector(
                        onTap: () {
                          controller.viewPass(visitor.passlink);
                        },
                        child: const Text('View Pass',
                            style: TextStyle(
                                color: primary,
                                fontSize: 12,
                                decoration: TextDecoration.underline,
                                letterSpacing: 1)),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  bottomSheet(DashboardDetail visitor) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(),
        Positioned(
          top: 60,
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              color: Colors.white,
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                _buildRow('Visitor Name', visitor.firstname),
                _buildRow('Mobile Number', visitor.phoneno),
                _buildRow('Person To Meet', visitor.persontomeet),
                _buildRow('Visiting Purpose', visitor.purpose),
                _buildRow('Visitor In Time', visitor.inTime),
                _buildRow('Visitor Out Time', visitor.outTime),
              ],
            ),
          ),
        ),
        CircleAvatar(
          backgroundImage: CachedNetworkImageProvider(visitor.visitPic),
          backgroundColor: Colors.grey,
          radius: 45,
        ),
      ],
    );
  }

  _buildRow(String title, String? value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(
            value ?? '-',
            style: const TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
