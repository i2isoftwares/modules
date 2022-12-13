import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'face_verify_controller.dart';

class FaceVerify extends GetView<FaceVerifyController>{

  final controller = Get.put(FaceVerifyController());

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Obx(
            () => Stack(
          fit: StackFit.expand,
          children: [
            Center(
              child: controller.isInitialized.value
                  ? AspectRatio(
                aspectRatio: Get.size.aspectRatio,
                child: FittedBox(
                  fit: BoxFit.fitHeight,
                  child: Container(
                    width: Get.width,
                    height: Get.width *
                        controller.cameraService.cameraController.value
                            .aspectRatio,
                    child: CameraPreview(
                      controller.cameraService.cameraController,
                    ),
                  ),
                ),
              )
                  : const SizedBox(),
            ),
            Container(
              height: double.infinity,
              width: double.infinity,
              margin: const EdgeInsets.only(left: 20),
              child: Column(
                children: [
                  const SizedBox(height: 40,),
                  const Align(
                      alignment: Alignment.topLeft,
                      child: Icon(Icons.arrow_back,color: Colors.white,)),
                  const SizedBox(height: 10,),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Face Recognition',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Please look into the camera and blink your eyes',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                  ),
                  const Spacer(),
                  LinearPercentIndicator(
                    width: 340,
                    lineHeight: 8.0,
                    percent: 0.9,
                    progressColor: Colors.blue,
                  ),
                  const SizedBox(height: 10,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}