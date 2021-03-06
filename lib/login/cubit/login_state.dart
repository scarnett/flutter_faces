part of 'login_cubit.dart';

class LoginState extends Equatable {
  final AppEmailField email;
  final AppPasswordField password;
  final FormzStatus status;
  final String? errorMessage;

  const LoginState({
    this.email: const AppEmailField.pure(),
    this.password: const AppPasswordField.pure(),
    this.status: FormzStatus.pure,
    this.errorMessage,
  });

  LoginState copyWith({
    AppEmailField? email,
    AppPasswordField? password,
    FormzStatus? status,
    String? errorMessage,
  }) =>
      LoginState(
        email: email ?? this.email,
        password: password ?? this.password,
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
      );

  @override
  List<Object> get props => [
        email,
        password,
        status,
      ];
}
