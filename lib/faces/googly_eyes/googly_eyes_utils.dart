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
        (size.width + (position.dx * scaleX)),
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
