import 'dart:async';
import 'dart:convert';
import 'dart:developer';

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
    // facedata = await Session.getString(Session.faceData);

    if (facedata.isNotEmpty)
      _start();
    else {
      // showToastMsg('Face data not available');
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

    var i = 30;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      i--;
      animation('$i');
      if (i <= 0) {
        timer.cancel();
        if (!isClosed) {
          // showToastMsg('Time Expired');
          dispose();
          Get.back(result: false);
        }
      }
    });

    _frameFaces();
  }

  _frameFaces() {
    imageSize(cameraService.getImageSize());

    cameraService.cameraController.startImageStream((image) async {
      if (detectingFace) return;

      detectingFace = true;

      try {
        List<Face> faces = await _mlKitService.getFacesFromImage(image);
        print('face ${faces.length}');

        if (faces.length > 0) {
          faceDetected(faces[0]);

          // log('face data' + jsonEncode(faces[0]).toString());

          if (faceDetected.value!.headEulerAngleY! > 10 ||
              faceDetected.value!.headEulerAngleY! < -10) {
            // faceDetected.value = null;
          } else {
            log('working start at................. ${DateTime.now().millisecondsSinceEpoch}');
            log('face detect ${faces[0].leftEyeOpenProbability} / ${faces[0].rightEyeOpenProbability}');
            if (((faces[0].leftEyeOpenProbability ?? 1) < 0.3) &&
                ((faces[0].rightEyeOpenProbability ?? 1) < 0.3)) {
              eyeCloseCount++;
              print('eye closed $eyeCloseCount');
            } else {
              if (eyeCloseCount != 0 && eyeCloseCount <= 3) {
                //ok
                print('eye reopened $eyeCloseCount blinked');

                //after reopen
                _faceNetService.setCurrentPrediction(
                    image, faceDetected.value!);
                bool res = _faceNetService.predict(jsonDecode(facedata));
                print('face response $res');
                if (res) {
                  pictureTaked(true);
                  // showToastMsg("Successfully Authenticated");

                  await Future.delayed(Duration(milliseconds: 300));
                  await cameraService.cameraController.stopImageStream();
                  await Future.delayed(Duration(milliseconds: 500));

                  if (timer != null) timer?.cancel();
                  Get.back(result: res);
                } else {
                  // showToastMsg("Retry with closer");
                }
              } else {
                //fast occur
                print('eye opened $eyeCloseCount');
              }
              eyeCloseCount = 0;
            }
            log('working end at................. ${DateTime.now().millisecondsSinceEpoch}');
          }
        } else {
          faceDetected.value = null;
        }

        detectingFace = false;
      } catch (e) {
        faceDetected.value = null;
        detectingFace = false;
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    cameraService.cameraController.stopImageStream();
    cameraService.dispose();
    super.dispose();

  }
}

