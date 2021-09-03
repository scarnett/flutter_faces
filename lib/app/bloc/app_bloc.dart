import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_faces/app/enums/app_status_enum.dart';
import 'package:flutter_faces/auth/auth.dart';
import 'package:flutter_faces/auth/models/user.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';

part 'app_events.dart';
part 'app_state.dart';

class AppBloc extends HydratedBloc<AppEvent, AppState> {
  AppBloc({
    required AuthenticationRepository authenticationRepository,
  }) : super(
          authenticationRepository.currentUser.isNotEmpty
              ? AppState.authenticated(authenticationRepository.currentUser)
              : const AppState.unauthenticated(),
        );

  AppState get initialState => AppState.initial();

  @override
  Stream<AppState> mapEventToState(
    AppEvent event,
  ) async* {}

  @override
  AppState? fromJson(
    Map<String, dynamic> json,
  ) =>
      AppState();

  @override
  Map<String, dynamic>? toJson(
    AppState state,
  ) =>
      {};
}
