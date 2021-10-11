import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_faces/signup/cubit/cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUpEmailField extends StatelessWidget {
  const SignUpEmailField({
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
            previous.email != current.email,
        builder: (
          BuildContext context,
          SignUpState state,
        ) =>
            TextField(
          key: const Key('signup_email_field'),
          onChanged: (email) => context.read<SignUpCubit>().emailChanged(email),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context)!.email,
            helperText: '',
            errorText: state.email.invalid
                ? AppLocalizations.of(context)!.invalidEmail
                : null,
          ),
        ),
      );
}
