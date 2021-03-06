import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_faces/faces/faces.dart';
import 'package:flutter_faces/faces/physics/physics.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class GooglyEyesPainter extends CustomPainter {
  final double maxRadius;
  final double minRadius;
  final Size imageSize;
  final Face face;
  final GooglyEyesPhysics leftEyePhysics;
  final bool leftEyeOpen;
  final GooglyEyesPhysics rightEyePhysics;
  final bool rightEyeOpen;
  final CameraLensDirection cameraLensDirection;
  final Color eyeColor;
  final Color eyeLidColor;
  final Color eyeOutlineColor;
  final Color eyeIrisColor;
  final double outlineWidth;

  GooglyEyesPainter({
    this.maxRadius: 60.0,
    this.minRadius: 10.0,
    required this.imageSize,
    required this.face,
    required this.leftEyePhysics,
    required this.leftEyeOpen,
    required this.rightEyePhysics,
    required this.rightEyeOpen,
    required this.cameraLensDirection,
    required this.eyeColor,
    required this.eyeLidColor,
    required this.eyeOutlineColor,
    required this.eyeIrisColor,
    this.outlineWidth: 3.0,
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
        physics: leftEyePhysics,
        open: leftEyeOpen,
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
        physics: rightEyePhysics,
        open: rightEyeOpen,
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
    required bool open,
  }) {
    Paint eyePainter = Paint()
      ..color = eyeColor
      ..style = PaintingStyle.fill;

    Paint eyeLidPainter = Paint()
      ..color = eyeLidColor
      ..style = PaintingStyle.fill;

    Paint irisPainter = Paint()
      ..color = eyeIrisColor
      ..style = PaintingStyle.fill;

    Paint outlinePainter = Paint()
      ..color = eyeOutlineColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = outlineWidth;

    Offset eyePosition = getEyePosition(
      size: size,
      position: position,
      scaleX: scaleX,
      scaleY: scaleY,
      cameraLensDirection: cameraLensDirection,
    );

    double eyeRadius = (maxRadius - ((size.width / rect.width) * 26.0));
    if (eyeRadius < minRadius) {
      eyeRadius = minRadius;
    } else if (eyeRadius > maxRadius) {
      eyeRadius = maxRadius;
    }

    if (open) {
      canvas.drawCircle(eyePosition, eyeRadius, eyePainter);

      double irisRadius = (eyeRadius / 3.0);
      Offset irisPosition =
          physics.nextIrisPosition(eyePosition, eyeRadius, irisRadius);

      canvas.drawCircle(irisPosition, irisRadius, irisPainter);
    } else {
      canvas.drawCircle(eyePosition, eyeRadius, eyeLidPainter);
      canvas.save();

      final double x = eyePosition.dx;
      final double y = eyePosition.dy;

      rotateEyeLid(
        canvas: canvas,
        x: x,
        y: y,
        headEulerAngleZ: face.headEulerAngleZ!,
        cameraLensDirection: cameraLensDirection,
      );

      final double start = (x - eyeRadius);
      final double end = (x + eyeRadius);
      canvas.drawLine(Offset(start, y), Offset(end, y), outlinePainter);
      canvas.restore();
    }

    canvas.drawCircle(eyePosition, eyeRadius, outlinePainter);
  }
}
