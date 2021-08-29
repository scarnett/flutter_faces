import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_faces/faces/faces.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class FaceBorderPainter extends CustomPainter {
  final Size imageSize;
  final Face face;
  final CameraLensDirection cameraLensDirection;

  FaceBorderPainter({
    required this.imageSize,
    required this.face,
    required this.cameraLensDirection,
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
        ..color = Colors.red; // TODO!
    } else {
      paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3.0
        ..color = Colors.green; // TODO!
    }

    canvas.drawRRect(
      getFaceBorderRect(
        rect: face.boundingBox,
        widgetSize: size,
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
