import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_faces/signup/cubit/cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUpConfirmPasswordField extends StatelessWidget {
  const SignUpConfirmPasswordField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) =>
      BlocBuilder<SignUpCubit, SignUpState>(
        buildWhen: (
          SignUpState previous,
          SignUpState current,
        ) =>
            (previous.password != current.password) ||
            (previous.confirmedPassword != current.confirmedPassword),
        builder: (
          BuildContext context,
          SignUpState state,
        ) =>
            TextField(
          key: const Key('signup_confirm_password_field'),
          onChanged: (String confirmPassword) => context
              .read<SignUpCubit>()
              .confirmedPasswordChanged(confirmPassword),
          obscureText: true,
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context)!.confirmPassword,
            helperText: '',
            errorText: state.confirmedPassword.invalid
                ? AppLocalizations.of(context)!.matchPassword
                : null,
          ),
        ),
      );
}
