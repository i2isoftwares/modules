import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../services/camera.service.dart';
import '../../services/facenet.service.dart';
import '../../services/ml_kit_service.dart';

class FaceRegisterController extends GetxController{

  //service injection
  CameraService cameraService = CameraService();
  final MLKitService _mlKitService = MLKitService();
  final FaceNetService _faceNetService = FaceNetService();

  RxBool isInitialized = false.obs;

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
  }
}