part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  final bool googlyEyes;
  final bool blinkDetection;
  final bool faceBorder;

  const SettingsState({
    this.googlyEyes: true,
    this.blinkDetection: true,
    this.faceBorder: false,
  });

  const SettingsState._({
    this.googlyEyes: true,
    this.blinkDetection: true,
    this.faceBorder: false,
  });

  const SettingsState.initial() : this._();

  SettingsState copyWith({
    bool? googlyEyes,
    bool? blinkDetection,
    bool? faceBorder,
  }) =>
      SettingsState(
        googlyEyes: googlyEyes ?? this.googlyEyes,
        blinkDetection: blinkDetection ?? this.blinkDetection,
        faceBorder: faceBorder ?? this.faceBorder,
      );

  @override
  List<Object> get props => [
        googlyEyes,
        blinkDetection,
        faceBorder,
      ];
}
