import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:i2iutils/widgets/boxedittext.dart';
import 'package:intl/intl.dart';
import 'package:i2iutils/helpers/common_functions.dart';
import 'package:vms/helper/colors.dart';
import 'package:vms/helper/utils.dart';
import 'package:vms/model/invite_visitor_list_response.dart';
import 'package:vms/routes/vms_app_routes.dart';
import 'package:vms/screens/client/visitor_view/client_visitor_view_controller.dart';


class ClientVisitorView extends GetView<ClientVisitorViewController> {
  ClientVisitorView({Key? key}) : super(key: key);

  @override
  final controller = Get.put(ClientVisitorViewController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: Obx(() =>
            Text(
              controller.title.value,
              style: const TextStyle(fontSize: 13),
            )),
      ),
      body: GestureDetector(
          onTap: (){
            Get.focusScope?.unfocus();
          },
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Visitors',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed(VMSRoutes.CLIENT_INSERT_VISITOR);
                      },
                      child: const Text(
                        'Create Visitors',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: primary,
                            letterSpacing: 1.2,
                            decoration: TextDecoration.underline,
                            decorationStyle: TextDecorationStyle.dashed),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                BoxEditText(
                    prefixIcon: const Icon(
                      Icons.search,
                      size: 15,
                    ),
                    suffixIcon: InkWell(
                      onTap: () {
                        if (controller.searchController.text.isNotEmpty) {
                          controller.searchController.clear();
                          controller.filter(controller.searchController.text,
                              controller.tController?.index ?? -1);
                        }
                      },
                      child: const Icon(
                        Icons.clear,
                        size: 15,
                      ),
                    ),
                    placeholder: 'Search',
                    onChanged: (val) {
                      controller.filter(val, controller.tController?.index ?? -1);
                    },
                    controller: controller.searchController),
                const SizedBox(
                  height: 8,
                ),
                Expanded(
                  child: DefaultTabController(
                      length: 3,
                      initialIndex: 1,
                      child: Column(
                        children: [
                          TabBar(
                              labelColor: Colors.black,
                              indicatorSize: TabBarIndicatorSize.label,
                              isScrollable: true,
                              controller: controller.tController,
                              tabs: [
                                Tab(
                                  height: 55,
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 14,),
                                      const Text('UPCOMING', softWrap: false, overflow: TextOverflow.fade),
                                      const SizedBox(height: 4,),
                                      Row(
                                        children: [
                                          Obx(()=>_buildInfo(Colors.amber, controller.ucCount.value),),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Tab(
                                  height: 55,
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 14,),
                                      const Text('TODAY', softWrap: false, overflow: TextOverflow.fade),
                                      const SizedBox(height: 4,),
                                      Row(
                                        children: [
                                          Obx(()=>_buildInfo(Colors.amber, '${controller.tnCount.value}'),),
                                          Obx(()=>_buildInfo(Colors.green, '${controller.tiCount.value}',),),
                                          Obx(()=>_buildInfo(Colors.red, '${controller.toCount.value}',),)
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Tab(
                                  height: 55,
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 14,),
                                      const Text('PREVIOUS', softWrap: false, overflow: TextOverflow.fade),
                                      const SizedBox(height: 4,),
                                      Row(
                                        children: [
                                          Obx(()=>_buildInfo(Colors.red, controller.prevCount.value),),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ]),
                          Expanded(
                            child: TabBarView(
                                controller: controller.tController,
                                children: [
                                  Obx(
                                        () =>
                                    controller.isLoading.value
                                        ? loader()
                                        : controller.upcomingVisitors.isEmpty
                                        ? const Center(
                                        child: Text(
                                          'No Invite Visitors Found',
                                          style:
                                          TextStyle(color: Colors.grey),
                                        ))
                                        : RefreshIndicator(
                                      onRefresh: () async{
                                        await controller.getList();
                                      },
                                          child: ListView.builder(
                                          physics:
                                          const AlwaysScrollableScrollPhysics(),
                                          itemCount: controller
                                              .upcomingVisitors.length +
                                              1,
                                          itemBuilder: (_, index) {
                                            if (index !=
                                                controller.upcomingVisitors
                                                    .length) {
                                              return visitorView(
                                                  controller.upcomingVisitors[
                                                  index],
                                                  true,);
                                            } else {
                                              return bottomView();
                                            }
                                          }),
                                        ),
                                  ),
                                  Obx(
                                        () =>
                                    controller.isLoading.value
                                        ? loader()
                                        : controller.todayVisitors.isEmpty
                                        ? const Center(
                                        child: Text(
                                          'No Invite Visitors Found',
                                          style:
                                          TextStyle(color: Colors.grey),
                                        ))
                                        : RefreshIndicator(
                                      onRefresh: () async{
                                        await controller.getList();
                                      },
                                      child: ListView.builder(
                                          physics:
                                          const AlwaysScrollableScrollPhysics(),
                                          itemCount: controller
                                              .todayVisitors.length +
                                              1,
                                          itemBuilder: (_, index) {
                                            if (index !=
                                                controller.todayVisitors
                                                    .length) {
                                              return visitorView(
                                                controller.todayVisitors[
                                                index],
                                                true,);
                                            } else {
                                              return bottomView();
                                            }
                                          }),
                                    ),
                                  ),
                                  Obx(
                                        () =>
                                    controller.isLoading.value
                                        ? loader()
                                        : controller.visitors.isEmpty
                                        ? const Center(
                                        child: Text(
                                          'No Invite Visitors Found',
                                          style:
                                          TextStyle(color: Colors.grey),
                                        ))
                                        : RefreshIndicator(
                                      onRefresh: () async{
                                        await controller.getList();
                                      },
                                          child: ListView.builder(
                                          physics:
                                          const AlwaysScrollableScrollPhysics(),
                                          itemCount:
                                          controller.visitors.length + 1,
                                          itemBuilder: (_, index) {
                                            if (index !=
                                                controller.visitors.length) {
                                              return visitorView(
                                                  controller.visitors[index],
                                                  false,);
                                            } else {
                                              return bottomView();
                                            }
                                          }),
                                        ),
                                  ),
                                ]),
                          ),
                        ],
                      )),
                )
              ],
            ),
          ),
        ),

    );
  }

  _buildInfo(Color color, String count){
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          width: 5,
          height: 5,
          margin: const EdgeInsets.only(right: 2,left: 2),
        ),
        Text(count, softWrap: true,overflow: TextOverflow.ellipsis),
      ],
    );
  }

  loader() {
    return const Center(
      child: CircularProgressIndicator(
        color: primary,
      ),
    );
  }

  bottomView() {
    return Text(
      'VMS\n© i2isoftwares.com',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: Colors.black.withOpacity(0.05),
        letterSpacing: 2,
      ),
    );
  }

  visitorView(InviteVisitors visitor, bool canSendSms,) {

    Widget widget=const SizedBox.shrink();
    if(controller.listTitle != visitor.visitDate){
      controller.listTitle=visitor.visitDate;
      widget=Row(
        children: [
          const Expanded(child: Divider(color: Colors.black26,)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(visitor.visitDate, style: const TextStyle(fontSize: 10,color: Colors.grey),),
          ),
          const Expanded(child: Divider(color: Colors.black26,)),
        ],
      );
    }
    return Column(
      children: [
        widget,
        InkWell(
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
                          '${visitor.visitorFName} ${visitor.visitorLName}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        visitor.isVisited ||
                            DateFormat("MMM dd yyyy")
                                .parse(visitor.visitDate)
                                .isBefore(DateFormat("MMM dd yyyy")
                                .parse(controller.today))
                            ? const SizedBox.shrink()
                            : GestureDetector(
                          onTap: () {
                            Get.toNamed(VMSRoutes.CLIENT_INSERT_VISITOR,
                                arguments: visitor);
                          },
                          child: const Text(
                            'Edit',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: primary,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: (visitor.inTime).isEmpty
                                  ? Colors.amber
                                  : (visitor.outTime).isEmpty ? Colors.green:Colors.red),
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
                        call(visitor.contactNo);
                      },
                      onLongPress: () {
                        Clipboard.setData(ClipboardData(text: visitor.contactNo));
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
                            visitor.contactNo,
                            style: const TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.blue),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '${visitor.visitDate} ${visitor.startTime}',
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
                    Text(visitor.purposeOfVisit),
                    Text(
                      visitor.whomToVisit,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                visitor.inTime.isEmpty
                    ? const SizedBox.shrink()
                    : Column(
                  children: [
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
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
                              visitor.inTime,
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.trending_up_outlined,
                              size: 12,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              visitor.outTime,
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        visitor.clientVisitorID = 0;
                        Get.toNamed(VMSRoutes.CLIENT_INSERT_VISITOR,
                            arguments: visitor);
                      },
                      child: const Text(
                        'Another Entry',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                          color: primary,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                    canSendSms && !visitor.isVisited
                        ? GestureDetector(
                      onTap: () {
                        controller.smsResend(visitor);
                      },
                      child: const Text(
                        'Resend SMS',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                          letterSpacing: 1.2,
                        ),
                      ),
                    )
                        : const SizedBox.shrink(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  bottomSheet(InviteVisitors visitor) {
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
                _buildRow('Visitor Name',
                    visitor.visitorFName + ' ' + visitor.visitorLName),
                _buildRow('Mobile Number', visitor.contactNo),
                _buildRow('Person To Meet', visitor.whomToVisit),
                _buildRow('Visiting Purpose', visitor.purposeOfVisit),
                _buildRow(
                  'Invite Date Time',
                  '${visitor.visitDate} ${visitor.startTime}',
                ),
                _buildRow('Visitor In Time',
                    visitor.inTime.isEmpty ? ' - ' : visitor.inTime),
                _buildRow('Visitor Out Time',
                    visitor.outTime.isEmpty ? ' - ' : visitor.outTime),
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

  _buildRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
