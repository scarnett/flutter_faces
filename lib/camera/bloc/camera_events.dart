part of 'camera_bloc.dart';

abstract class CameraEvent extends Equatable {
  const CameraEvent();

  @override
  List<Object?> get props => [];

  @override
  String toString() => 'CameraEvent{}';
}

class ToggleCameraLensDirection extends CameraEvent {
  const ToggleCameraLensDirection();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'ToggleCameraLensDirection{}';
}
