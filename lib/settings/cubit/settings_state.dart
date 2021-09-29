part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  final bool googlyEyes;
  final bool blinkDetection;
  final Color eyeColor;
  final Color eyeLidColor;
  final Color eyeOutlineColor;
  final Color eyeIrisColor;
  final bool faceBorder;

  const SettingsState({
    this.googlyEyes: true,
    this.blinkDetection: true,
    this.eyeColor: Colors.white,
    this.eyeLidColor: Colors.white,
    this.eyeOutlineColor: Colors.black,
    this.eyeIrisColor: Colors.black,
    this.faceBorder: false,
  });

  const SettingsState._({
    this.googlyEyes: true,
    this.blinkDetection: true,
    this.eyeColor: Colors.white,
    this.eyeLidColor: Colors.white,
    this.eyeOutlineColor: Colors.black,
    this.eyeIrisColor: Colors.black,
    this.faceBorder: false,
  });

  const SettingsState.initial() : this._();

  SettingsState copyWith({
    bool? googlyEyes,
    bool? blinkDetection,
    Color? eyeColor,
    Color? eyeLidColor,
    Color? eyeOutlineColor,
    Color? eyeIrisColor,
    bool? faceBorder,
  }) =>
      SettingsState(
        googlyEyes: googlyEyes ?? this.googlyEyes,
        blinkDetection: blinkDetection ?? this.blinkDetection,
        eyeColor: eyeColor ?? this.eyeColor,
        eyeLidColor: eyeLidColor ?? this.eyeLidColor,
        eyeOutlineColor: eyeOutlineColor ?? this.eyeOutlineColor,
        eyeIrisColor: eyeIrisColor ?? this.eyeIrisColor,
        faceBorder: faceBorder ?? this.faceBorder,
      );

  @override
  List<Object> get props => [
        googlyEyes,
        blinkDetection,
        eyeColor,
        eyeLidColor,
        eyeOutlineColor,
        eyeIrisColor,
        faceBorder,
      ];
}
