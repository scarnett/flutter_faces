import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_faces/faces/faces.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class FaceBorderPainter extends CustomPainter {
  final Size imageSize;
  final Face face;
  final CameraLensDirection cameraLensDirection;
  final Color faceBorderColor;
  final Color faceBorderErrorColor;

  FaceBorderPainter({
    required this.imageSize,
    required this.face,
    required this.cameraLensDirection,
    required this.faceBorderColor,
    required this.faceBorderErrorColor,
  });

  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {
    Paint paint;

    if ((this.face.headEulerAngleY! > 50.0) ||
        (this.face.headEulerAngleY! < -50.0)) {
      paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3.0
        ..color = this.faceBorderErrorColor;
    } else {
      paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3.0
        ..color = this.faceBorderColor;
    }

    canvas.drawRRect(
      getFaceBorderRect(
        rect: face.boundingBox,
        size: size,
        scaleX: (size.width / imageSize.width),
        scaleY: (size.height / imageSize.height),
        cameraLensDirection: cameraLensDirection,
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(
    FaceBorderPainter oldDelegate,
  ) =>
      (oldDelegate.imageSize != imageSize) || (oldDelegate.face != face);
}
