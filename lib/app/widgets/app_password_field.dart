import 'package:flutter_faces/app/enums/enums.dart';
import 'package:formz/formz.dart';

class AppPasswordField extends FormzInput<String, AppFieldValidationError> {
  const AppPasswordField.pure() : super.pure('');

  const AppPasswordField.dirty([
    String value = '',
  ]) : super.dirty(value);

  static final _passwordRegExp =
      RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');

  @override
  AppFieldValidationError? validator(
    String? value,
  ) =>
      _passwordRegExp.hasMatch(value ?? '')
          ? null
          : AppFieldValidationError.invalid;
}
