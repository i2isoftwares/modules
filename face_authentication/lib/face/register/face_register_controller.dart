
import 'dart:developer';
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

import '../../services/camera.service.dart';
import '../../services/facenet.service.dart';
import '../../services/ml_kit_service.dart';

class FaceRegisterController extends GetxController{

  //service injection
  CameraService cameraService = CameraService();
  final MLKitService _mlKitService = MLKitService();
  final FaceNetService _faceNetService = FaceNetService();

  RxBool isInitialized = false.obs;
  Rx<Size?> imageSize = Rx(null);
  RxBool detectingFace = false.obs;
  Rx<Face?> faceDetected = Rx(null);
  int eyeCloseCount = 0;
  RxString imagePath = ''.obs;
  RxBool pictureTaked = false.obs;
  String faceData = "";




  @override
  void onInit() {
    _start();
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
    imageSize(cameraService.getImageSize());

    cameraService.cameraController.startImageStream((image) async {
      try {
        if (detectingFace.value) return;

        detectingFace(true);

        List<Face> faces = await _mlKitService.getFacesFromImage(image);
        // showToastMsg('faces ${faces.length}');
        if (faces.isNotEmpty) {
          faceDetected(faces[0]);
          // log('face data ${faces[0].boundingBox.toString()}\n${faces[0].headEulerAngleY}\n${faces[0].headEulerAngleZ}\n${faces[0].leftEyeOpenProbability}\n${faces[0].rightEyeOpenProbability}\n${faces[0].smilingProbability}\n${faces[0].trackingId}');

          print('EagularY ${faceDetected.value!.headEulerAngleY!}');

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

                await Future.delayed(const Duration(milliseconds: 300));
                await cameraService.cameraController.stopImageStream();
                await Future.delayed(const Duration(milliseconds: 500));

                //after reopen
                _faceNetService.setCurrentPrediction(
                    image, faceDetected.value!);


                XFile file = await cameraService.takePicture();
                imagePath(file.path);

                pictureTaked(true);
                faceData = _faceNetService.predictedData.toString();

                //Navigate to back with facedata and imagepath


              } else {
                //fast occur
                print('eye opened $eyeCloseCount');
              }
              eyeCloseCount = 0;
              log('working end at................. ${DateTime.now().millisecondsSinceEpoch}');
            }
          }
        } else {
          faceDetected.value = null;
          log('face not detected ${faceDetected.value == null}');
        }

        detectingFace(false);
      } catch (e) {
        print('exe $e');
        // showToastMsg('$e');
        faceDetected.value = null;
        detectingFace(false);
      }
    });
  }
}