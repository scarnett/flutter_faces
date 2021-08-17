import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_faces/faces/googly_eyes/physics/physics.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class GooglyEyesPainter extends CustomPainter {
  final double maxRadius;
  final double minRadius;
  final Size imageSize;
  final Face face;

  late GooglyEyesPhysics? leftEyePhysics;
  late GooglyEyesPhysics? rightEyePhysics;

  GooglyEyesPainter({
    this.maxRadius: 60.0,
    this.minRadius: 20.0,
    required this.imageSize,
    required this.face,
    this.leftEyePhysics,
    this.rightEyePhysics,
  });

  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {
    double scaleX = (size.width / imageSize.width);
    double scaleY = (size.height / imageSize.height);

    FaceLandmark? leftEye = face.getLandmark(FaceLandmarkType.leftEye);
    if (leftEye != null) {
      _drawEye(
        canvas: canvas,
        rect: face.boundingBox,
        size: size,
        position: leftEye.position,
        scaleX: scaleX,
        scaleY: scaleY,
        physics: leftEyePhysics!,
      );
    }

    FaceLandmark? rightEye = face.getLandmark(FaceLandmarkType.rightEye);
    if (rightEye != null) {
      _drawEye(
        canvas: canvas,
        rect: face.boundingBox,
        size: size,
        position: rightEye.position,
        scaleX: scaleX,
        scaleY: scaleY,
        physics: rightEyePhysics!,
      );
    }
  }

  @override
  bool shouldRepaint(
    CustomPainter oldDelegate,
  ) =>
      true;

  void _drawEye({
    required Canvas canvas,
    required Rect rect,
    required Size size,
    required Offset position,
    required double scaleX,
    required double scaleY,
    required GooglyEyesPhysics physics,
  }) {
    Paint eyePainter = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    Paint irisPainter = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    Offset eyePosition = Offset(
      (size.width - (position.dx * scaleX)),
      (position.dy * scaleY),
    );

    double eyeRadius = (maxRadius - (rect.left.toDouble() * (scaleX / 4.0)));
    if (eyeRadius < minRadius) {
      eyeRadius = minRadius;
    } else if (eyeRadius > maxRadius) {
      eyeRadius = maxRadius;
    }

    canvas.drawCircle(eyePosition, eyeRadius, eyePainter);

    double irisRadius = (eyeRadius / 3.0);
    Offset irisPosition =
        physics.nextIrisPosition(eyePosition, eyeRadius, irisRadius);

    canvas.drawCircle(irisPosition, irisRadius, irisPainter);
  }
}
