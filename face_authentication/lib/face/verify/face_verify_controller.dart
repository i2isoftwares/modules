import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'dart:math' as math;


import '../../services/camera.service.dart';
import '../../services/facenet.service.dart';
import '../../services/ml_kit_service.dart';

class FaceVerifyController extends GetxController with GetSingleTickerProviderStateMixin{


  final double mirror = math.pi;

  RxBool isInitialized = false.obs;
  bool detectingFace = false;
  RxBool pictureTaked = false.obs;
  bool saving = false;

  RxString imagePath = ''.obs;
  Rx<Face?> faceDetected = Rx(null);
  Rx<Size?> imageSize = Rx(null);
  var facedata = "";
  RxString animation = '30'.obs;
  var animationController;
  Timer? timer;
  int eyeCloseCount = 0;
  RxBool isClose = false.obs;

  //service injection
  CameraService cameraService = CameraService();
  final MLKitService _mlKitService = MLKitService();
  final FaceNetService _faceNetService = FaceNetService();

  @override
  void onInit() {
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    facedata = await Session.getString(Session.faceData);

    if (facedata.isNotEmpty)
      _start();
    else {
      showToastMsg('Face data not available');
      Get.back();
    }
  }

  _start() async {
    List<CameraDescription> cameras = await availableCameras();

    /// takes the front camera
    var cameraDescription = cameras.firstWhere(
          (CameraDescription camera) =>
      camera.lensDirection == CameraLensDirection.front,
    );

    await cameraService.startService(cameraDescription);

    // start the services
    await _faceNetService.loadModel();
    _mlKitService.initialize();

    isInitialized(true);
  }
}

