import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_faces/app/app.dart';
import 'package:flutter_faces/app/bloc/app_bloc_observer.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Bloc
  Bloc.observer = AppBlocObserver();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );

  runApp(App());
}
