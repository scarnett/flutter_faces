part of 'camera_bloc.dart';

@immutable
class CameraState extends Equatable {
  final CameraMode cameraMode;
  final CameraLensDirection cameraLensDirection;

  CameraState({
    this.cameraMode: CameraMode.photo,
    this.cameraLensDirection: CameraLensDirection.front,
  });

  const CameraState._({
    this.cameraMode: CameraMode.photo,
    this.cameraLensDirection: CameraLensDirection.front,
  });

  const CameraState.initial() : this._();

  CameraState copyWith({
    CameraMode? cameraMode,
    CameraLensDirection? cameraLensDirection,
  }) =>
      CameraState._(
        cameraMode: cameraMode ?? this.cameraMode,
        cameraLensDirection: cameraLensDirection ?? this.cameraLensDirection,
      );

  @override
  List<Object?> get props => [
        cameraMode,
        cameraLensDirection,
      ];

  @override
  String toString() =>
      'CameraState{cameraMode: $cameraMode, cameraLensDirection: $cameraLensDirection}';
}
