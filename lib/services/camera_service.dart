import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class CameraService {
  static final CameraService _cameraServiceService = CameraService._internal();

  factory CameraService() => _cameraServiceService;

  CameraService._internal();

  late CameraController _cameraController;
  CameraController get cameraController => this._cameraController;

  late CameraDescription _cameraDescription;

  late InputImageRotation _cameraRotation;
  InputImageRotation get cameraRotation => this._cameraRotation;

  late String _imagePath;
  String get imagePath => this._imagePath;

  Future<void> startService(
    CameraDescription cameraDescription,
  ) async {
    this._cameraDescription = cameraDescription;
    this._cameraController = CameraController(
      this._cameraDescription,
      ResolutionPreset.high,
      enableAudio: false,
    );

    // Sets the rotation of the image
    this._cameraRotation = rotationIntToImageRotation(
      this._cameraDescription.sensorOrientation,
    );

    return this._cameraController.initialize();
  }

  Future<void> updateDescription(
    CameraDescription cameraDescription,
  ) async {
    await _cameraController.dispose();
    await startService(cameraDescription);
  }

  InputImageRotation rotationIntToImageRotation(
    int rotation,
  ) {
    switch (rotation) {
      case 90:
        return InputImageRotation.Rotation_90deg;

      case 180:
        return InputImageRotation.Rotation_180deg;

      case 270:
        return InputImageRotation.Rotation_270deg;

      default:
        return InputImageRotation.Rotation_0deg;
    }
  }

  /// Takes the picture and saves it in the given path
  Future<XFile> takePicture() async {
    XFile file = await _cameraController.takePicture();
    this._imagePath = file.path;
    return file;
  }

  /// Returns the image size
  Size getImageSize() => Size(
        _cameraController.value.previewSize!.height,
        _cameraController.value.previewSize!.width,
      );

  dispose() {
    this._cameraController.dispose();
  }
}
