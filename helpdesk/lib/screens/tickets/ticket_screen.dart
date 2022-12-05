import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helpdesk/helpers/strings.dart';
import 'package:helpdesk/model/all_tickets_response.dart';
import 'package:helpdesk/routes/hd_app_routes.dart';
import 'package:helpdesk/screens/tickets/ticket_item.dart';
import 'package:helpdesk/widgets/shimmer/list_shimmer.dart';
import 'package:i2iutils/helpers/hexcolor.dart';

import 'ticket_controller.dart';

class TicketScreen extends GetView<TicketController> {
  TicketScreen({Key? key}) : super(key: key);

  @override
  final controller = Get.put(TicketController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(controller.args['title']),
        bottom: PreferredSize(
          preferredSize: Size(Get.width, 50),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${controller.args['companyName']}',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold)),
                    Text('${controller.args['locationName']}',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w700)),
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                Text('${controller.args['duration']}',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w700)),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
        ),
        actions: [
          CachedNetworkImage(
            imageUrl: '${controller.box.read(LOGO)}',
            width: 50,
            errorWidget: (_, __, ___) {
              return Image.asset(
                'assets/helpdesklogo.png',
                color: Colors.white,
                width: 50,
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              controller.getTicket();
            },
          ),
        ],
      ),
      body: Obx(
        () => Column(
          children: [
            Expanded(
              child: controller.isLoading.value
                  ? const ListShimmer(6)
                  : Column(
                      children: [
                        controller.statusDetails.isEmpty
                            ? const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Center(child: Text('No Records Found')),
                              )
                            : SizedBox(
                                height: 90,
                                child: ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: controller.statusDetails.length,
                                  itemBuilder: (_, index) {
                                    Statusdetails status =
                                        controller.statusDetails[index];
                                    return _buildStatusWidget(status);
                                  },
                                ),
                              ),
                        const SizedBox(
                          height: 8,
                        ),
                        controller.tickets.isEmpty
                            ? const Padding(
                                padding: EdgeInsets.all(16),
                                child: Center(child: Text('No Records Found')),
                              )
                            : Expanded(
                                child: RefreshIndicator(
                                  onRefresh: () async {
                                    await controller.getTicket();
                                  },
                                  child: ListView.builder(
                                    itemCount: controller.tickets.length,
                                    itemBuilder: (_, index) {
                                      Ticketdetails ticket =
                                          controller.tickets[index];
                                      // return _buildTicketItem(ticket);
                                      return TicketItem(
                                          ticket: ticket,
                                          controller: controller);
                                    },
                                  ),
                                ),
                              ),
                      ],
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: controller.isB2c
          ? null
          : FloatingActionButton.small(
              onPressed: () async {
                var res = await Get.toNamed(HDRoutes.TICKET_CREATE, arguments: {
                  'companyName': controller.args['companyName'],
                  'companyId': int.parse(controller.args['companyid']),
                  'locationName': controller.args['locationName'],
                  'locationId': int.parse(controller.args['locationid']),
                  "building": controller.args['building'],
                  "complaintType": controller.args['complaintType'],
                  "complaintId": int.parse(controller.args['ticketType']),
                });

                if (res != null && res["status"]) {
                  controller.getTicket();
                  Get.toNamed(HDRoutes.TICKET_DETAIL,
                      arguments: {"complaintId": "${res['complaintId']}"});
                }
              },
              child: const Icon(Icons.add),
              tooltip: "Generate Ticket",
            ),
    );
  }

  _buildStatusWidget(Statusdetails status) {
    return GestureDetector(
      onTap: () {
        controller.onStatusChange(status);
      },
      child: Obx(
        () => Card(
          color: controller.selectedStatusId.value == status.statusid
              ? HexColor(status.colorcode.split('-')[1])
              : null,
          margin: const EdgeInsets.all(4),
          elevation:
              controller.selectedStatusId.value == status.statusid ? 6 : 1,
          shadowColor: controller.selectedStatusId.value == status.statusid
              ? HexColor(status.colorcode.split('-')[1])
              : null,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: SizedBox(
            width: 110,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${status.tickets}',
                    style: TextStyle(
                        color:
                            controller.selectedStatusId.value == status.statusid
                                ? Colors.white
                                : Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                  Text(
                    status.status,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color:
                            controller.selectedStatusId.value == status.statusid
                                ? Colors.white
                                : Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}
