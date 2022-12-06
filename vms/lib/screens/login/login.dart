import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vms/helper/colors.dart';

import 'login_controller.dart';

class Login extends GetView<LoginController> {
  @override
  final controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      )
    );
  }
}
