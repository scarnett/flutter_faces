part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  final bool googlyEyes;
  final bool blinkDetection;
  final String eyeBorderColor;
  final String eyePupilColor;
  final bool faceBorder;

  const SettingsState({
    this.googlyEyes: true,
    this.blinkDetection: true,
    this.eyeBorderColor: '#000000',
    this.eyePupilColor: '#000000',
    this.faceBorder: false,
  });

  const SettingsState._({
    this.googlyEyes: true,
    this.blinkDetection: true,
    this.eyeBorderColor: '#000000',
    this.eyePupilColor: '#000000',
    this.faceBorder: false,
  });

  const SettingsState.initial() : this._();

  SettingsState copyWith({
    bool? googlyEyes,
    bool? blinkDetection,
    String? eyeBorderColor,
    String? eyePupilColor,
    bool? faceBorder,
  }) =>
      SettingsState(
        googlyEyes: googlyEyes ?? this.googlyEyes,
        blinkDetection: blinkDetection ?? this.blinkDetection,
        eyeBorderColor: eyeBorderColor ?? this.eyeBorderColor,
        eyePupilColor: eyePupilColor ?? this.eyePupilColor,
        faceBorder: faceBorder ?? this.faceBorder,
      );

  @override
  List<Object> get props => [
        googlyEyes,
        blinkDetection,
        eyeBorderColor,
        eyePupilColor,
        faceBorder,
      ];
}
