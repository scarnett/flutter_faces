import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_faces/app/app.dart';
import 'package:flutter_faces/app/bloc/app_bloc_observer.dart';
import 'package:flutter_faces/auth/auth.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase
  await Firebase.initializeApp();

  // Bloc
  Bloc.observer = AppBlocObserver();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );

  final AuthenticationRepository authenticationRepository =
      AuthenticationRepository();

  await authenticationRepository.user.first;

  runApp(App(authenticationRepository: authenticationRepository));
}
