import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:i2iutils/helpers/common_functions.dart';

import 'package:vms/helper/colors.dart';
import 'package:vms/helper/vms_session.dart';
import 'package:vms/helper/utils.dart';
import 'package:vms/model/visitor.dart';
import 'package:vms/networks/api_calls.dart';
import 'package:vms/routes/vms_app_routes.dart';
import 'package:i2iutils/widgets/button.dart';

class ConfirmScreen extends StatelessWidget {
  final Visitor _visitor = Get.arguments;
  final box=GetStorage();


  _confirmBooking() async {
    if (await isNetConnected()) {
      showLoader(title: 'Pass Generating...');
      try {
        
        _visitor.CompanyID =
            int.parse(box.read(VMSSession.COMPID) ?? '-1');
        _visitor.LocationID =
            int.parse(box.read(VMSSession.LOCID) ?? '-1');
        _visitor.GateId =
            int.parse(box.read(VMSSession.GATEID) ?? '-1');
        _visitor.userID =
            (box.read(VMSSession.USERID) ?? -1).toString();
        if (_visitor.visitorImage is List<int>) {
          _visitor.custImagearray = base64Encode(_visitor.visitorImage);
        }
        _visitor.visitorImage = '';
        if (_visitor.vehTypeImage is List<int>) {
          _visitor.vehTypeImage = base64Encode(_visitor.vehTypeImage);
        }
        if (_visitor.idProofImage is List<int>) {
          _visitor.idProofImage = base64Encode(_visitor.idProofImage);
        }

        log('final visitor details \n${jsonEncode(_visitor)}');
        //call ticket api to submit
        Map<String, dynamic> response = await savePass(_visitor);
        if (response['status']) {
          _visitor.barcodeImage = response['message'];
          hideLoader();
          Get.offAllNamed(VMSRoutes.TICKET, arguments: _visitor);
        } else {
          showToastMsg('${response['message']}');
          hideLoader();
        }
      } catch (e) {
        print('exe $e');
        hideLoader();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Confirmation',
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                  color: Colors.white,
                  border: Border.all(color: Colors.black),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black,
                        blurRadius: 0.2,
                        offset: Offset(3, 3)),
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // _buildTitle('Visitor Detail'),
                  Align(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                        backgroundColor: primary.withOpacity(0.8),
                        radius: 50,
                        child: _visitor.visitorImage is List<int>
                            ? CircleAvatar(
                                backgroundImage:
                                    MemoryImage(_visitor.visitorImage),
                                radius: 48,
                                onBackgroundImageError: (_, __) {
                                  const CircleAvatar(
                                    backgroundImage: AssetImage(
                                        'assets/vms/userpic-8.png'),
                                    radius: 48,
                                  );
                                },
                              )
                            : CircleAvatar(
                                backgroundImage:
                                    NetworkImage(_visitor.visitorImage ?? ''),
                                radius: 48,
                                onBackgroundImageError: (_, __) {
                                  const CircleAvatar(
                                    backgroundImage: AssetImage(
                                        'assets/vms/userpic-8.png'),
                                    radius: 48,
                                  );
                                },
                              )),
                  ),
                  const SizedBox(height: 12,),
                  _buildRow('Visitor Name', _visitor.visitorName ?? ''),
                  _buildRow('Coming From', _visitor.visitorFrom ?? ''),
                  _buildRow('Contact No', _visitor.mobileNo ?? ''),
                  _buildRow('ID Proof', _visitor.idProofNo ?? ''),
                  _buildRow('Purpose Of Visit', _visitor.visitPurposeName ?? ''),
                  _buildRow('Company To Visit', _visitor.visitCompName ?? ''),
                  _buildRow('Tower', _visitor.visitTowerName ?? ''),
                  _buildRow('Whom To Meet', _visitor.visitPersonName ?? ''),
                  _buildRow('Contact No\nOf Person To Meet',
                      _visitor.visitPersonContactId ?? ''),
                  _visitor.haveVeh ?? false
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildTitle('Vehicle Details'),
                            _buildRow('Vehicle type', _visitor.vehType ?? ''),
                            _buildRow('V.Number', _visitor.vehNumber ?? ''),
                          ],
                        )
                      : const SizedBox.shrink(),
                  _visitor.haveAccess ?? false
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildTitle('Accessories Details'),
                            ListView.builder(
                              itemBuilder: (context, index) {
                                return _buildRow(
                                    '${(index + 1)}. ${_visitor.accessories![index].name}',
                                    _visitor.accessories![index].desc);
                              },
                              itemCount: _visitor.accessories?.length ?? 0,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                            )
                          ],
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
            // Container(
            //   margin: const EdgeInsets.symmetric(vertical: 12),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     children: <Widget>[
            //       _buildImage(_visitor.visitorImage),
            //       _buildImage(_visitor.idProofImage),
            //       _buildImage(_visitor.vehTypeImage),
            //     ],
            //   ),
            // ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CustomButton(
                    width: MediaQuery.of(context).size.width * 0.4,
                    buttonText: 'Back',
                    onPressed: () => Get.back(),
                    buttonColor: Colors.grey,
                  ),
                  CustomButton(
                    width: MediaQuery.of(context).size.width * 0.4,
                    buttonText: 'Confirm',
                    onPressed: () {
                      _confirmBooking();
                    },

                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildImage(dynamic image) {
    double size = Get.width * 0.25;
    return image != null && image!.isNotEmpty
        ? Image.memory(
            image,
            width: size,
            height: size,
            fit: BoxFit.cover,
            errorBuilder: (context, exe, trace) {
              print('exe : ${exe.toString()}');
              return Image.asset(
                'assets/vms/placeholder.png',
                width: size,
                height: size,
              );
            },
          )
        : Image.asset(
            'assets/vms/placeholder.png',
            width: size,
            height: size,
          );
  }

  _buildTitle(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildRow(String key, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            key,
            style: const TextStyle(
              color: Colors.black54,
            ),
            textAlign: TextAlign.start,
          ),
          const SizedBox(
            width: 4,
          ),
          Flexible(
            child: Text(
              value.isEmpty ? '-' : value,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.w600),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
