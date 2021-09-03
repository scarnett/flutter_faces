import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_faces/app/app.dart';
import 'package:flutter_faces/app/bloc/bloc.dart';
import 'package:flutter_faces/auth/auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class App extends StatelessWidget {
  final AuthenticationRepository _authenticationRepository;

  const App({
    Key? key,
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) =>
      RepositoryProvider.value(
        value: _authenticationRepository,
        child: BlocProvider(
          create: (BuildContext context) => AppBloc(
            authenticationRepository: _authenticationRepository,
          ),
          child: AppView(),
        ),
      );
}

class AppView extends StatelessWidget {
  AppView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) =>
      MaterialApp(
        theme: appThemeData,
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('en', ''),
        ],
        home: FlowBuilder<AppStatus>(
          state: context.select((AppBloc bloc) => bloc.state.status),
          onGeneratePages: onGenerateAppViewPages,
        ),
      );
}
