part of 'app_bloc.dart';

@immutable
class AppState extends Equatable {
  final CameraLensDirection cameraLensDirection;

  AppState({
    this.cameraLensDirection: CameraLensDirection.front,
  });

  const AppState._({
    this.cameraLensDirection: CameraLensDirection.front,
  });

  const AppState.initial() : this._();

  AppState copyWith({
    CameraLensDirection? cameraLensDirection,
  }) =>
      AppState._(
        cameraLensDirection: cameraLensDirection ?? this.cameraLensDirection,
      );

  @override
  List<Object?> get props => [
        cameraLensDirection,
      ];

  @override
  String toString() => 'AppState{cameraLensDirection: $cameraLensDirection}';
}
