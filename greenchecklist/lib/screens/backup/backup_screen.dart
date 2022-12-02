import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greenchecklist/screens/backup/backup_controller.dart';
import 'package:i2iutils/widgets/button.dart';

class BackupScreen extends GetView<BackupController> {
  BackupScreen({Key? key}) : super(key: key);

  final controller=Get.put(BackupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Backup'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: 5,
                itemBuilder: (_, index) {
                  return CheckboxListTile(
                    value: true,
                    onChanged: (val) {},
                    title: Text('Database'),
                    controlAffinity: ListTileControlAffinity.leading,
                  );
                }),
          ),
          CustomButton(
              margin: EdgeInsets.all(34),
              buttonText: 'Backup Now', onPressed: () {}),
        ],
      ),
    );
  }
}
