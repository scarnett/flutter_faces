import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_faces/login/cubit/cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginPasswordField extends StatelessWidget {
  @override
  Widget build(
    BuildContext context,
  ) =>
      BlocBuilder<LoginCubit, LoginState>(
        buildWhen: (
          LoginState previous,
          LoginState current,
        ) =>
            (previous.password != current.password),
        builder: (
          BuildContext context,
          LoginState state,
        ) =>
            TextField(
          key: const Key('login_password_field'),
          onChanged: (String password) =>
              context.read<LoginCubit>().passwordChanged(password),
          obscureText: true,
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context)!.password,
            helperText: '',
            errorText: state.password.invalid
                ? AppLocalizations.of(context)!.invalidPassword
                : null,
          ),
        ),
      );
}
