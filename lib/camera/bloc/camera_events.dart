part of 'camera_bloc.dart';

abstract class CameraEvent extends Equatable {
  const CameraEvent();

  @override
  List<Object?> get props => [];

  @override
  String toString() => 'CameraEvent{}';
}

class SetCameraMode extends CameraEvent {
  final CameraMode cameraMode;

  const SetCameraMode(
    this.cameraMode,
  );

  @override
  List<Object> get props => [
        this.cameraMode,
      ];

  @override
  String toString() => 'SetCameraMode{cameraMode: $cameraMode}';
}

class ToggleCameraLensDirection extends CameraEvent {
  const ToggleCameraLensDirection();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'ToggleCameraLensDirection{}';
}
