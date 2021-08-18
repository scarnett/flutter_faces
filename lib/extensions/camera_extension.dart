import 'package:camera/camera.dart';

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
