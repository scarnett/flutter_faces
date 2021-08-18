part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object?> get props => [];

  @override
  String toString() => 'AppEvent{}';
}

class ToggleCameraLensDirection extends AppEvent {
  const ToggleCameraLensDirection();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'ToggleCameraLensDirection{}';
}
