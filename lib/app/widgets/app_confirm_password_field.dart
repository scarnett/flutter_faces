import 'package:flutter_faces/app/enums/enums.dart';
import 'package:formz/formz.dart';

class AppConfirmPasswordField
    extends FormzInput<String, AppFieldValidationError> {
  final String password;

  const AppConfirmPasswordField.pure({
    this.password: '',
  }) : super.pure('');

  const AppConfirmPasswordField.dirty({
    required this.password,
    String value: '',
  }) : super.dirty(value);

  @override
  AppFieldValidationError? validator(
    String? value,
  ) =>
      (password == value) ? null : AppFieldValidationError.invalid;
}
