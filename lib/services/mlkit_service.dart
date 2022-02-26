import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_faces/services/camera_service.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class MLKitService {
  static final MLKitService _cameraServiceService = MLKitService._internal();

  factory MLKitService() => _cameraServiceService;

  MLKitService._internal();

  CameraService _cameraService = CameraService();

  late FaceDetector _faceDetector;
  FaceDetector get faceDetector => this._faceDetector;

  void initialize() {
    this._faceDetector = GoogleMlKit.vision.faceDetector(
      FaceDetectorOptions(
        mode: FaceDetectorMode.accurate,
        enableLandmarks: true,
        enableTracking: true,
        enableClassification: true,
      ),
    );
  }

  Future<List<Face>> getFacesFromImage(
    CameraImage image,
  ) async {
    /// Preprocess the image
    InputImageData _firebaseImageMetadata = InputImageData(
      imageRotation: _cameraService.cameraRotation,
      inputImageFormat: InputImageFormatMethods.fromRawValue(image.format.raw)!,
      size: Size(image.width.toDouble(), image.height.toDouble()),
      planeData: image.planes
          .map(
            (Plane plane) => InputImagePlaneMetadata(
              bytesPerRow: plane.bytesPerRow,
              height: plane.height,
              width: plane.width,
            ),
          )
          .toList(),
    );

    /// Transform the image input for the face detector
    InputImage _firebaseVisionImage = InputImage.fromBytes(
      bytes: image.planes[0].bytes,
      inputImageData: _firebaseImageMetadata,
    );

    /// proces the image and makes inference
    List<Face> faces =
        await this._faceDetector.processImage(_firebaseVisionImage);

    return faces;
  }
}
