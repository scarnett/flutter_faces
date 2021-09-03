part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object?> get props => [];

  @override
  String toString() => 'AppEvent{}';
}

class AppLogoutRequested extends AppEvent {}

class AppUserChanged extends AppEvent {
  final User user;

  @visibleForTesting
  const AppUserChanged(
    this.user,
  );

  @override
  List<Object> get props => [
        user,
      ];
}
