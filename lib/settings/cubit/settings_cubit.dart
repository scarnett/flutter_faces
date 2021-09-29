import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_faces/extensions/extensions.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'settings_state.dart';

class SettingsCubit extends HydratedCubit<SettingsState> {
  SettingsCubit() : super(SettingsState.initial());

  SettingsState get initialState => SettingsState.initial();

  void googlyEyesChanged(
    bool status,
  ) =>
      emit(state.copyWith(
        googlyEyes: status,
        blinkDetection: status,
      ));

  void blinkDetectionChanged(
    bool status,
  ) =>
      emit(state.copyWith(
        blinkDetection: status,
      ));

  void eyeColorChanged(
    Color color,
  ) =>
      emit(state.copyWith(
        eyeColor: color,
      ));

  void eyeLidColorChanged(
    Color color,
  ) =>
      emit(state.copyWith(
        eyeLidColor: color,
      ));

  void eyeOutlineColorChanged(
    Color color,
  ) =>
      emit(state.copyWith(
        eyeOutlineColor: color,
      ));

  void eyeIrisColorChanged(
    Color color,
  ) =>
      emit(state.copyWith(
        eyeIrisColor: color,
      ));

  void faceBorderChanged(
    bool status,
  ) =>
      emit(state.copyWith(
        faceBorder: status,
      ));

  @override
  SettingsState? fromJson(
    Map<String, dynamic> json,
  ) =>
      SettingsState(
        googlyEyes:
            json.containsKey('googlyEyes') ? json['googlyEyes'] as bool : true,
        blinkDetection: json.containsKey('blinkDetection')
            ? json['blinkDetection'] as bool
            : true,
        eyeColor: json.containsKey('eyeColor')
            ? (json['eyeColor'] as String).toColor()
            : Colors.white,
        eyeLidColor: json.containsKey('eyeLidColor')
            ? (json['eyeLidColor'] as String).toColor()
            : Colors.white,
        eyeOutlineColor: json.containsKey('eyeOutlineColor')
            ? (json['eyeOutlineColor'] as String).toColor()
            : Colors.black,
        eyeIrisColor: json.containsKey('eyeIrisColor')
            ? (json['eyeIrisColor'] as String).toColor()
            : Colors.black,
        faceBorder:
            json.containsKey('faceBorder') ? json['faceBorder'] as bool : false,
      );

  @override
  Map<String, dynamic>? toJson(
    SettingsState state,
  ) =>
      {
        'googlyEyes': state.googlyEyes,
        'blinkDetection': state.blinkDetection,
        'eyeColor': state.eyeColor.toHex(),
        'eyeLidColor': state.eyeLidColor.toHex(),
        'eyeOutlineColor': state.eyeOutlineColor.toHex(),
        'eyeIrisColor': state.eyeIrisColor.toHex(),
        'faceBorder': state.faceBorder,
      };
}
