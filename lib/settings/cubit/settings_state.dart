part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  final bool googlyEyes;
  final bool blinkDetection;
  final Color eyeColor;
  final Color eyeLidColor;
  final Color eyeOutlineColor;
  final Color eyeIrisColor;
  final bool faceBorder;
  final Color faceBorderColor;
  final Color faceBorderErrorColor;

  const SettingsState({
    this.googlyEyes: true,
    this.blinkDetection: true,
    this.eyeColor: Colors.white,
    this.eyeLidColor: Colors.white,
    this.eyeOutlineColor: Colors.black,
    this.eyeIrisColor: Colors.black,
    this.faceBorder: false,
    this.faceBorderColor: Colors.green,
    this.faceBorderErrorColor: Colors.red,
  });

  const SettingsState._({
    this.googlyEyes: true,
    this.blinkDetection: true,
    this.eyeColor: Colors.white,
    this.eyeLidColor: Colors.white,
    this.eyeOutlineColor: Colors.black,
    this.eyeIrisColor: Colors.black,
    this.faceBorder: false,
    this.faceBorderColor: Colors.green,
    this.faceBorderErrorColor: Colors.red,
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
    Color? faceBorderColor,
    Color? faceBorderErrorColor,
  }) =>
      SettingsState(
        googlyEyes: googlyEyes ?? this.googlyEyes,
        blinkDetection: blinkDetection ?? this.blinkDetection,
        eyeColor: eyeColor ?? this.eyeColor,
        eyeLidColor: eyeLidColor ?? this.eyeLidColor,
        eyeOutlineColor: eyeOutlineColor ?? this.eyeOutlineColor,
        eyeIrisColor: eyeIrisColor ?? this.eyeIrisColor,
        faceBorder: faceBorder ?? this.faceBorder,
        faceBorderColor: faceBorderColor ?? this.faceBorderColor,
        faceBorderErrorColor: faceBorderErrorColor ?? this.faceBorderErrorColor,
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
        faceBorderColor,
        faceBorderErrorColor,
      ];
}
