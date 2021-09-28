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

  void eyePupilColorChanged(
    String color,
  ) =>
      emit(state.copyWith(
        eyePupilColor: color,
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
        googlyEyes: json['googlyEyes'] as bool,
        blinkDetection: json['blinkDetection'] as bool,
        eyeBorderColor: json['eyeBorderColor'] as String,
        eyePupilColor: json['eyePupilColor'] as String,
        faceBorder: json['faceBorder'] as bool,
      );

  @override
  Map<String, dynamic>? toJson(
    SettingsState state,
  ) =>
      {
        'googlyEyes': state.googlyEyes,
        'blinkDetection': state.blinkDetection,
        'eyeBorderColor': state.eyeBorderColor,
        'eyePupilColor': state.eyePupilColor,
        'faceBorder': state.faceBorder,
      };
}
