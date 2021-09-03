part of 'camera_bloc.dart';

@immutable
class CameraState extends Equatable {
  final CameraLensDirection cameraLensDirection;

  CameraState({
    this.cameraLensDirection: CameraLensDirection.front,
  });

  const CameraState._({
    this.cameraLensDirection: CameraLensDirection.front,
  });

  const CameraState.initial() : this._();

  CameraState copyWith({
    CameraLensDirection? cameraLensDirection,
  }) =>
      CameraState._(
        cameraLensDirection: cameraLensDirection ?? this.cameraLensDirection,
      );

  @override
  List<Object?> get props => [
        cameraLensDirection,
      ];

  @override
  String toString() => 'CameraState{cameraLensDirection: $cameraLensDirection}';
}
