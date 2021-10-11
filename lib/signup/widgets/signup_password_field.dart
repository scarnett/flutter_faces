import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_faces/signup/cubit/cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUpPasswordField extends StatelessWidget {
  @override
  Widget build(
    BuildContext context,
  ) =>
      BlocBuilder<SignUpCubit, SignUpState>(
        buildWhen: (
          SignUpState previous,
          SignUpState current,
        ) =>
            (previous.password != current.password),
        builder: (
          BuildContext context,
          SignUpState state,
        ) =>
            TextField(
          key: const Key('signup_password_field'),
          onChanged: (String password) =>
              context.read<SignUpCubit>().passwordChanged(password),
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
