import 'package:equatable/equatable.dart';
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

  void eyeBorderColorChanged(
    String color,
  ) =>
      emit(state.copyWith(
        eyeBorderColor: color,
      ));

  void eyeIrisColorChanged(
    String color,
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
        eyeBorderColor: json.containsKey('eyeBorderColor')
            ? json['eyeBorderColor'] as String
            : '#000000',
        eyeIrisColor: json.containsKey('eyeIrisColor')
            ? json['eyeIrisColor'] as String
            : '#000000',
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
        'eyeBorderColor': state.eyeBorderColor,
        'eyeIrisColor': state.eyeIrisColor,
        'faceBorder': state.faceBorder,
      };
}
