import 'package:camera/camera.dart';
import 'package:flutter_faces/camera/enums/enums.dart';

extension CameraModeExtension on CameraMode {
  String getString() {
    switch (this) {
      case CameraMode.video:
        return 'video';

      case CameraMode.photo:
      default:
        return 'photo';
    }
  }
}

CameraMode getCameraMode({
  required String str,
}) {
  for (CameraMode cameraMode in CameraMode.values) {
    if (cameraMode.getString() == str) {
      return cameraMode;
    }
  }

  return CameraMode.photo;
}

extension CameraLensDirectionExtension on CameraLensDirection {
  String getString() {
    switch (this) {
      case CameraLensDirection.back:
        return 'back';

      case CameraLensDirection.front:
      default:
        return 'front';
    }
  }
}

CameraLensDirection getCameraLensDirection({
  required String str,
}) {
  for (CameraLensDirection direction in CameraLensDirection.values) {
    if (direction.getString() == str) {
      return direction;
    }
  }

  return CameraLensDirection.front;
}
