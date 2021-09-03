part of 'app_bloc.dart';

@immutable
class AppState extends Equatable {
  final AppStatus status;
  final User? user;

  AppState({
    this.status: AppStatus.unauthenticated,
    this.user: User.empty,
  });

  const AppState._({
    this.status: AppStatus.unauthenticated,
    this.user: User.empty,
  });

  const AppState.initial() : this._();

  const AppState.authenticated(
    User user,
  ) : this._(status: AppStatus.authenticated, user: user);

  const AppState.unauthenticated() : this._(status: AppStatus.unauthenticated);

  AppState copyWith(
    AppStatus? status,
    User? user,
  ) =>
      AppState._(
        status: status ?? this.status,
        user: user ?? this.user,
      );

  @override
  List<Object?> get props => [
        status,
        user,
      ];

  @override
  String toString() => 'AppState{status: $status, user: $user}';
}
