import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greenchecklist/screens/helpdesk/history/history_screen_controller.dart';
import 'package:i2iutils/helpers/hexcolor.dart';

import '../../../model/ticket_histories.dart';

class HistoryScreen extends GetView<HistoryScreenController> {
  HistoryScreen({Key? key}) : super(key: key);

  final controller = Get.put(HistoryScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${Get.arguments['ticketNo']}'),
      ),
      body: Obx(()=> controller.isHistoryLoading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : controller.histories.isEmpty
              ? const Center(child: Text('No Histories Found'))
              : ListView.builder(
                  itemCount: controller.histories.length,
                  itemBuilder: (_, index) =>
                      _buildTicketItem(controller.histories[index]),
                ),),
    );
  }

  _buildTicketItem(Histories history) {
    return Container(
        margin: const EdgeInsets.all(6),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(
              color: HexColor(history.colorcode.split('-')[1]), width: 2),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildBadge(
                    HexColor(history.colorcode.split('-')[1]), history.status),
                Text(
                  '${history.statusDate} ${history.statusTime}',
                  style: const TextStyle(
                      fontSize: 10, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: history.description.isEmpty
                      ? const SizedBox.shrink()
                      : Text(
                          history.description,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
                !GetUtils.isURL(history.imagelink)
                    ? const SizedBox.shrink()
                    : CachedNetworkImage(
                        imageUrl: history.imagelink,
                        height: 50,
                        errorWidget: (_, __, ___) {
                          return Image.asset(
                            'assets/greenchecklist/placeholder.png',
                            height: 50,
                          );
                        },
                      ),
              ],
            )
          ],
        ));
  }

  _buildBadge(Color color, String text) {
    return Container(
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Text(
        text,
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12),
      ),
    );
  }
}
