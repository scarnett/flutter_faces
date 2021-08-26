import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
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
        ..color = Colors.red;
    } else {
      paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3.0
        ..color = Colors.green;
    }

    canvas.drawRRect(
      _scaleRect(
        rect: face.boundingBox,
        widgetSize: size,
        scaleX: (size.width / imageSize.width),
        scaleY: (size.height / imageSize.height),
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

RRect _scaleRect({
  required Rect rect,
  required Size widgetSize,
  double scaleX: 0.0,
  double scaleY: 0.0,
}) =>
    RRect.fromLTRBR(
      (widgetSize.width - (rect.left.toDouble() * scaleX)),
      (rect.top.toDouble() * scaleY),
      (widgetSize.width - (rect.right.toDouble() * scaleX)),
      (rect.bottom.toDouble() * scaleY),
      Radius.circular(10.0),
    );
