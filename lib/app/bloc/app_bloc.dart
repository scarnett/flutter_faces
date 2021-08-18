import 'dart:async';

import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_faces/extensions/extensions.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';

part 'app_events.dart';
part 'app_state.dart';

class AppBloc extends HydratedBloc<AppEvent, AppState> {
  AppBloc() : super(AppState.initial());

  AppState get initialState => AppState.initial();

  @override
  Stream<AppState> mapEventToState(
    AppEvent event,
  ) async* {
    if (event is ToggleCameraLensDirection) {
      yield _mapToggleCameraLensDirectionToStates(event);
    }
  }

  AppState _mapToggleCameraLensDirectionToStates(
    ToggleCameraLensDirection event,
  ) =>
      state.copyWith(
        cameraLensDirection:
            (state.cameraLensDirection == CameraLensDirection.front)
                ? CameraLensDirection.back
                : CameraLensDirection.front,
      );

  @override
  AppState? fromJson(
    Map<String, dynamic> json,
  ) =>
      AppState(
        cameraLensDirection:
            getCameraLensDirection(str: json['cameraLensDirection']),
      );

  @override
  Map<String, dynamic>? toJson(
    AppState state,
  ) =>
      {
        'cameraLensDirection': state.cameraLensDirection.getString(),
      };
}
