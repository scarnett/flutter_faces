import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_faces/auth/auth.dart';
import 'package:flutter_faces/login/cubit/cubit.dart';
import 'package:flutter_faces/login/forms/forms.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginPage extends StatelessWidget {
  static Page page() => const MaterialPage<void>(child: LoginPage());

  const LoginPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) =>
      Scaffold(
        appBar: AppBar(title: Text(AppLocalizations.of(context)!.login)),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocProvider(
            create: (BuildContext context) =>
                LoginCubit(context.read<AuthenticationRepository>()),
            child: const LoginForm(),
          ),
        ),
      );
}
