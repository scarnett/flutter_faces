import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:tflite_flutter/tflite_flutter.dart' as tflite;
import 'package:image/image.dart' as imglib;

class FaceNetService {
  static final FaceNetService _faceNetService = FaceNetService._internal();

  factory FaceNetService() => _faceNetService;

  FaceNetService._internal();

  late tflite.Interpreter _interpreter;

  double threshold = 1.0;

  late List _predictedData;
  List get predictedData => this._predictedData;

  dynamic data = {};

  Future loadModel() async {
    try {
      final tflite.GpuDelegateV2 gpuDelegateV2 = tflite.GpuDelegateV2(
        options: tflite.GpuDelegateOptionsV2(
          isPrecisionLossAllowed: false,
          inferencePreference: tflite.TfLiteGpuInferenceUsage.fastSingleAnswer,
          inferencePriority1: tflite.TfLiteGpuInferencePriority.minLatency,
          inferencePriority2: tflite.TfLiteGpuInferencePriority.auto,
          inferencePriority3: tflite.TfLiteGpuInferencePriority.auto,
        ),
      );

      tflite.InterpreterOptions interpreterOptions = tflite.InterpreterOptions()
        ..addDelegate(gpuDelegateV2);

      this._interpreter = await tflite.Interpreter.fromAsset(
        'mobilefacenet.tflite',
        options: interpreterOptions,
      );
    } catch (e) {
      print('Failed to load model.');
      print(e);
    }
  }

  setCurrentPrediction(
    CameraImage cameraImage,
    Face face,
  ) {
    /// Crops the face from the image and transforms it to an array of data
    List input = _preProcess(cameraImage, face);

    /// Reshapes input and ouput to model format
    input = input.reshape([1, 112, 112, 3]);
    List output = List.generate(1, (int index) => List.filled(192, 0));

    /// Runs and transforms the data
    this._interpreter.run(input, output);
    output = output.reshape([192]);

    this._predictedData = List.from(output);
  }

  /// Crops the image to be more easy to detect and transforms it to
  /// model input.
  List _preProcess(
    CameraImage image,
    Face faceDetected,
  ) {
    // Crops the face
    imglib.Image croppedImage = _cropFace(image, faceDetected);
    imglib.Image img = imglib.copyResizeCropSquare(croppedImage, 112);

    // Transforms the cropped face to array data
    Float32List imageAsList = imageToByteListFloat32(img);
    return imageAsList;
  }

  /// Crops the face from the image
  _cropFace(
    CameraImage image,
    Face faceDetected,
  ) {
    imglib.Image convertedImage = _convertCameraImage(image);
    double x = (faceDetected.boundingBox.left - 10.0);
    double y = (faceDetected.boundingBox.top - 10.0);
    double w = (faceDetected.boundingBox.width + 10.0);
    double h = (faceDetected.boundingBox.height + 10.0);

    return imglib.copyCrop(
      convertedImage,
      x.round(),
      y.round(),
      w.round(),
      h.round(),
    );
  }

  /// Converts CameraImage type to Image type
  imglib.Image _convertCameraImage(
    CameraImage image,
  ) {
    int width = image.width;
    int height = image.height;

    imglib.Image img = imglib.Image(width, height);

    const int hexFF = 0xFF000000;
    final int uvyButtonStride = image.planes[1].bytesPerRow;
    final int? uvPixelStride = image.planes[1].bytesPerPixel;

    for (int x = 0; x < width; x++) {
      for (int y = 0; y < height; y++) {
        final int uvIndex = uvPixelStride! * (x / 2).floor() +
            uvyButtonStride * (y / 2).floor();

        final int index = y * width + x;
        final int yp = image.planes[0].bytes[index];
        final int up = image.planes[1].bytes[uvIndex];
        final int vp = image.planes[2].bytes[uvIndex];

        int r = (yp + vp * 1436 / 1024 - 179).round().clamp(0, 255);
        int g = (yp - up * 46549 / 131072 + 44 - vp * 93604 / 131072 + 91)
            .round()
            .clamp(0, 255);

        int b = (yp + up * 1814 / 1024 - 227).round().clamp(0, 255);
        img.data[index] = hexFF | (b << 16) | (g << 8) | r;
      }
    }

    imglib.Image img1 = imglib.copyRotate(img, -90);
    return img1;
  }

  Float32List imageToByteListFloat32(
    imglib.Image image,
  ) {
    /// Input size = 112
    Float32List convertedBytes = Float32List(1 * 112 * 112 * 3);
    Float32List buffer = Float32List.view(convertedBytes.buffer);
    int pixelIndex = 0;

    for (int i = 0; i < 112; i++) {
      for (int j = 0; j < 112; j++) {
        int pixel = image.getPixel(j, i);

        /// Mean: 128
        /// STD: 128
        buffer[pixelIndex++] = ((imglib.getRed(pixel) - 128) / 128);
        buffer[pixelIndex++] = ((imglib.getGreen(pixel) - 128) / 128);
        buffer[pixelIndex++] = ((imglib.getBlue(pixel) - 128) / 128);
      }
    }

    return convertedBytes.buffer.asFloat32List();
  }

  void setPredictedData(
    List<dynamic> value,
  ) =>
      this._predictedData = value;
}
