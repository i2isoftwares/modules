import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greenchecklist/model/ticket_detail_response.dart';
import 'package:i2iutils/helpers/hexcolor.dart';

import '../../helpers/colors.dart';
import '../../model/all_tickets_response.dart';
import '../../routes/app_pages.dart';

class TicketItem extends StatelessWidget {
  final TicketDetails ticket;
  final String colorCode;

  const TicketItem({Key? key, required this.ticket,required this.colorCode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=>Get.toNamed(GCRoutes.helpdesk_history, arguments: {
        'complaintId':'${ticket.compliantID}',
        'ticketNo' : '${ticket.ticketNo}'
      } ),
      child: Container(
        margin: const EdgeInsets.all(6),
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          border: Border.all(
              color: HexColor(colorCode), width: 2),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      ticket.priorityName.isEmpty
                          ? const SizedBox.shrink()
                          : _buildBadge(Colors.green, ticket.priorityName),
                      const SizedBox(
                        width: 6,
                      ),
                      Text(
                        ticket.ticketNo,
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                Text(
                  ticket.reqTime,
                  style: const TextStyle(
                    fontSize: 10,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: Text(ticket.categoryName)),
                const SizedBox(
                  width: 2,
                ),
                Row(
                  children: [
                    _buildBadge(Colors.green, ticket.priorityName),
                    const SizedBox(
                      width: 4,
                    ),
                    _buildBadge(
                        HexColor(colorCode), ticket.statusName),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
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
