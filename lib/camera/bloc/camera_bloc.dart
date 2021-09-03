import 'dart:async';

import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_faces/extensions/extensions.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';

part 'camera_events.dart';
part 'camera_state.dart';

class CameraBloc extends HydratedBloc<CameraEvent, CameraState> {
  CameraBloc() : super(CameraState.initial());

  CameraState get initialState => CameraState.initial();

  @override
  Stream<CameraState> mapEventToState(
    CameraEvent event,
  ) async* {
    if (event is ToggleCameraLensDirection) {
      yield _mapToggleCameraLensDirectionToStates(event);
    }
  }

  CameraState _mapToggleCameraLensDirectionToStates(
    ToggleCameraLensDirection event,
  ) =>
      state.copyWith(
        cameraLensDirection:
            (state.cameraLensDirection == CameraLensDirection.front)
                ? CameraLensDirection.back
                : CameraLensDirection.front,
      );

  @override
  CameraState? fromJson(
    Map<String, dynamic> json,
  ) =>
      CameraState(
        cameraLensDirection:
            getCameraLensDirection(str: json['cameraLensDirection']),
      );

  @override
  Map<String, dynamic>? toJson(
    CameraState state,
  ) =>
      {
        'cameraLensDirection': state.cameraLensDirection.getString(),
      };
}
