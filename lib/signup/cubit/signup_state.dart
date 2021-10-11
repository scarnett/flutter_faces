part of 'signup_cubit.dart';

class SignUpState extends Equatable {
  final AppEmailField email;
  final AppPasswordField password;
  final AppConfirmPasswordField confirmedPassword;
  final FormzStatus status;
  final String? errorMessage;

  const SignUpState({
    this.email = const AppEmailField.pure(),
    this.password = const AppPasswordField.pure(),
    this.confirmedPassword = const AppConfirmPasswordField.pure(),
    this.status = FormzStatus.pure,
    this.errorMessage,
  });

  SignUpState copyWith({
    AppEmailField? email,
    AppPasswordField? password,
    AppConfirmPasswordField? confirmedPassword,
    FormzStatus? status,
    String? errorMessage,
  }) =>
      SignUpState(
        email: email ?? this.email,
        password: password ?? this.password,
        confirmedPassword: confirmedPassword ?? this.confirmedPassword,
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
      );

  @override
  List<Object> get props => [
        email,
        password,
        confirmedPassword,
        status,
      ];
}
