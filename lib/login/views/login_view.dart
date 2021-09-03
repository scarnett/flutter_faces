import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_faces/auth/auth.dart';
import 'package:flutter_faces/login/cubit/cubit.dart';
import 'package:flutter_faces/login/forms/forms.dart';

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
        appBar: AppBar(title: const Text('Login')), // TODO! i10n
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocProvider(
            create: (_) => LoginCubit(context.read<AuthenticationRepository>()),
            child: const LoginForm(),
          ),
        ),
      );
}
