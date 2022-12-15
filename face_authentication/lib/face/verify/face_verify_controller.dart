import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

import '../../services/camera.service.dart';
import '../../services/facenet.service.dart';
import '../../services/ml_kit_service.dart';

class FaceVerifyController extends GetxController {
//service injection
  CameraService cameraService = CameraService();
  final MLKitService _mlKitService = MLKitService();
  final FaceNetService _faceNetService = FaceNetService();

  RxBool isInitialized = false.obs;
  Size? imageSize;
  Face? faceDetected;

  bool detectingFace = false;
  int eyeCloseCount = 0;
  RxBool isPredicted = false.obs;
  bool isSuccess = true;
  RxDouble prediction = 0.0.obs;

  List faceData = jsonDecode(Get.arguments ?? []);

  @override
  void onInit() {
    debugPrint('\nface verification module required'
        '\n---------------------------------------------------'
        '\nassets/lottie/face_success.json'
        '\nassets/lottie/face_failed.json'
        '\nlottie files for animation'
        '\n'
        '\nuse Get.toNamed(FRRoutes.verify, arguments= "face data list string")'
        '\n'
        '\n---------------------------------------------------');
    if (faceData.isEmpty) {
      dispose();
      Get.back();
    }

    _start();
    super.onInit();
  }

  @override
  Future<void> dispose() async {
    // TODO: implement dispose
    await cameraService.cameraController.stopImageStream();
    await cameraService.dispose();
    super.dispose();
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
    _frameFaces();
  }

  _frameFaces() {
    imageSize = cameraService.getImageSize();

    cameraService.cameraController.startImageStream((image) async {
      try {
        if (detectingFace) return;

        detectingFace = true;

        List<Face> faces = await _mlKitService.getFacesFromImage(image);
        // showToastMsg('faces ${faces.length}');
        if (faces.isNotEmpty) {
          faceDetected = faces[0];
          // log('face data ${faces[0].boundingBox.toString()}\n${faces[0].headEulerAngleY}\n${faces[0].headEulerAngleZ}\n${faces[0].leftEyeOpenProbability}\n${faces[0].rightEyeOpenProbability}\n${faces[0].smilingProbability}\n${faces[0].trackingId}');

          debugPrint('EagularY ${faceDetected!.headEulerAngleY!}');

          if (faceDetected!.headEulerAngleY! > 10 ||
              faceDetected!.headEulerAngleY! < -10) {
            // faceDetected.value = null;
          } else {
            log('working start at................. ${DateTime.now().millisecondsSinceEpoch}');

            log('face detect ${faces[0].leftEyeOpenProbability} / ${faces[0].rightEyeOpenProbability}');
            if (((faces[0].leftEyeOpenProbability ?? 1) < 0.3) &&
                ((faces[0].rightEyeOpenProbability ?? 1) < 0.3)) {
              eyeCloseCount++;
              debugPrint('eye closed $eyeCloseCount');
            } else {
              if (eyeCloseCount != 0 && eyeCloseCount <= 3) {
                //ok
                debugPrint('eye reopened $eyeCloseCount blinked');

                await Future.delayed(const Duration(milliseconds: 300));
                await cameraService.cameraController.stopImageStream();
                await cameraService.cameraController.pausePreview();
                await Future.delayed(const Duration(milliseconds: 500));

                //after reopen
                _faceNetService.setCurrentPrediction(image, faceDetected!);
                var response = _faceNetService.predict(faceData);

                bool res = response['result'];
                prediction(response['prediction']);

                isPredicted(true);
                if (res) {
                  isSuccess = true;
                  Future.delayed(const Duration(seconds: 5), () {
                    dispose();
                    Get.back(result: true);
                  });
                } else {
                  isSuccess = false;
                }
                FlutterRingtonePlayer.playNotification();
              } else {
                //fast occur
                debugPrint('eye opened $eyeCloseCount');
              }
              eyeCloseCount = 0;
              log('working end at................. ${DateTime.now().millisecondsSinceEpoch}');
            }
          }
        } else {
          faceDetected = null;
          log('face not detected ${faceDetected == null}');
        }

        detectingFace = false;
      } catch (e) {
        debugPrint('exe $e');
        // showToastMsg('$e');
        faceDetected = null;
        detectingFace = false;
      }
    });
  }

  retry() async {
    isPredicted(false);
    isSuccess = false;
    detectingFace = false;
    eyeCloseCount = 0;
    faceDetected = null;
    await cameraService.cameraController.resumePreview();
    _frameFaces();
  }
}
