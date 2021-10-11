import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_faces/app/enums/app_status_enum.dart';
import 'package:flutter_faces/auth/auth.dart';
import 'package:flutter_faces/auth/models/user.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';

part 'app_events.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final AuthenticationRepository _authenticationRepository;
  late final StreamSubscription<User> _userSubscription;

  AppBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(
          authenticationRepository.currentUser.isNotEmpty
              ? AppState.authenticated(authenticationRepository.currentUser)
              : const AppState.unauthenticated(),
        ) {
    on<AppUserChanged>(_onUserChanged);
    on<AppLogoutRequested>(_onLogoutRequested);

    _userSubscription = _authenticationRepository.user.listen(
      (user) => add(AppUserChanged(user)),
    );
  }

  void _onUserChanged(
    AppUserChanged event,
    Emitter<AppState> emit,
  ) =>
      emit(event.user.isNotEmpty
          ? AppState.authenticated(event.user)
          : const AppState.unauthenticated());

  void _onLogoutRequested(
    AppLogoutRequested event,
    Emitter<AppState> emit,
  ) =>
      unawaited(_authenticationRepository.logOut());

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
