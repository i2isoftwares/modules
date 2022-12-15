import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'face_verify_controller.dart';

class FaceVerify extends GetView<FaceVerifyController> {
  FaceVerify({super.key});

  @override
  final controller = Get.put(FaceVerifyController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        controller.dispose();
        return true;
      },
      child: Scaffold(
        body: Obx(
          () => Stack(
            children: [
              controller.isInitialized.value
                  ? AspectRatio(
                      aspectRatio: Get.size.aspectRatio,
                      child: FittedBox(
                        fit: BoxFit.fitHeight,
                        child: SizedBox(
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
                  : const Center(child: CircularProgressIndicator()),
              controller.isPredicted.value
                  ? Container(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Lottie.asset(
                            controller.isSuccess
                                ? 'assets/lottie/face_success.json'
                                : 'assets/lottie/face_failed.json',
                          ),
                          Text(
                            controller.isSuccess
                                ? 'Face ID Verified'
                                : 'Failed To Verify',
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                letterSpacing: 1.5),
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          Visibility(
                            visible: !controller.isSuccess,
                            child: InkWell(
                              onTap: () => controller.retry(),
                              child: Container(
                                width: 100,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 12),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(50.0)),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade500,
                                      blurRadius: 25,
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: const [
                                    Icon(
                                      Icons.refresh,
                                      color: Colors.red,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      'Retry',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox.shrink(),
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      Colors.black,
                      Colors.transparent,
                      Colors.transparent,
                      Colors.black54,
                    ])),
                padding: const EdgeInsets.only(
                    left: 20, top: 40, bottom: 16, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () => Get.back(),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Face Recognition',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Please look into the camera and blink your eyes',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                    const Spacer(),
                    controller.isPredicted.value
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${(controller.prediction.value * (controller.isSuccess ? 100 : 10)).toInt()}% Recognized',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    letterSpacing: 1.5),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: LinearProgressIndicator(
                                  value: controller.isSuccess
                                      ? controller.prediction.value
                                      : controller.prediction.value / 10,
                                  color: controller.isSuccess
                                      ? Colors.green
                                      : Colors.red,
                                  backgroundColor: Colors.white,
                                ),
                              ),
                            ],
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
