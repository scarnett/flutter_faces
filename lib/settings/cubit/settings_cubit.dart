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
        faceBorder: json['faceBorder'] as bool,
      );

  @override
  Map<String, dynamic>? toJson(
    SettingsState state,
  ) =>
      {
        'googlyEyes': state.googlyEyes,
        'blinkDetection': state.blinkDetection,
        'faceBorder': state.faceBorder,
      };
}
