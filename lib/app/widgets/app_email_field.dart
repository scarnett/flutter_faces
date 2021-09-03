import 'package:flutter_faces/app/enums/enums.dart';
import 'package:formz/formz.dart';

class AppEmailField extends FormzInput<String, AppFieldValidationError> {
  const AppEmailField.pure() : super.pure('');

  const AppEmailField.dirty([
    String value = '',
  ]) : super.dirty(value);

  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  @override
  AppFieldValidationError? validator(
    String? value,
  ) =>
      _emailRegExp.hasMatch(value ?? '')
          ? null
          : AppFieldValidationError.invalid;
}
