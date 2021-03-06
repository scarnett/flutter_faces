import 'dart:math' as math;

import 'package:camera/camera.dart';
import 'package:flutter/widgets.dart';

bool isEyeOpen(
  double? eyeOpenProbability, {
  double eyeClosedThreshold: 0.4,
}) {
  bool eyeOpen;

  if (eyeOpenProbability == null) {
    eyeOpen = true;
  } else {
    eyeOpen = (eyeOpenProbability > eyeClosedThreshold);
  }

  return eyeOpen;
}

RRect getFaceBorderRect({
  required Rect rect,
  required Size size,
  required double scaleX,
  required double scaleY,
  required CameraLensDirection cameraLensDirection,
}) {
  RRect rrect;

  switch (cameraLensDirection) {
    case CameraLensDirection.back:
      rrect = RRect.fromLTRBR(
        (rect.left.toDouble() * scaleX),
        (rect.top.toDouble() * scaleY),
        (rect.right.toDouble() * scaleX),
        (rect.bottom.toDouble() * scaleY),
        Radius.circular(10.0),
      );

      break;

    case CameraLensDirection.front:
    default:
      rrect = RRect.fromLTRBR(
        (size.width - (rect.left.toDouble() * scaleX)),
        (rect.top.toDouble() * scaleY),
        (size.width - (rect.right.toDouble() * scaleX)),
        (rect.bottom.toDouble() * scaleY),
        Radius.circular(10.0),
      );

      break;
  }

  return rrect;
}

Offset getEyePosition({
  required Size size,
  required Offset position,
  required double scaleX,
  required double scaleY,
  required CameraLensDirection cameraLensDirection,
}) {
  Offset eyePosition;

  switch (cameraLensDirection) {
    case CameraLensDirection.back:
      eyePosition = Offset(
        (position.dx * scaleX),
        (position.dy * scaleY),
      );

      break;

    case CameraLensDirection.front:
    default:
      eyePosition = Offset(
        (size.width - (position.dx * scaleX)),
        (position.dy * scaleY),
      );

      break;
  }

  return eyePosition;
}

void rotateEyeLid({
  required Canvas canvas,
  required double x,
  required double y,
  required double headEulerAngleZ,
  required CameraLensDirection cameraLensDirection,
}) {
  double radians;

  switch (cameraLensDirection) {
    case CameraLensDirection.back:
      radians = (headEulerAngleZ / 180.0);
      break;

    case CameraLensDirection.front:
    default:
      radians = ((headEulerAngleZ * math.pi) / 180.0);
      break;
  }

  _rotateCanvas(
    canvas: canvas,
    cx: x,
    cy: y,
    angle: radians,
  );
}

void _rotateCanvas({
  required Canvas canvas,
  required double cx,
  required double cy,
  required double angle,
}) {
  canvas.translate(cx, cy);
  canvas.rotate(angle);
  canvas.translate(-cx, -cy);
}
