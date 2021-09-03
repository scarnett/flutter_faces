part of 'login_cubit.dart';

class LoginState extends Equatable {
  final AppEmailField email;
  final AppPasswordField password;
  final FormzStatus status;

  const LoginState({
    this.email: const AppEmailField.pure(),
    this.password: const AppPasswordField.pure(),
    this.status: FormzStatus.pure,
  });

  LoginState copyWith({
    AppEmailField? email,
    AppPasswordField? password,
    FormzStatus? status,
  }) =>
      LoginState(
        email: email ?? this.email,
        password: password ?? this.password,
        status: status ?? this.status,
      );

  @override
  List<Object> get props => [
        email,
        password,
        status,
      ];
}
