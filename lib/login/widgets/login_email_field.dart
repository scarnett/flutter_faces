import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_faces/login/cubit/cubit.dart';

class LoginEmailField extends StatelessWidget {
  @override
  Widget build(
    BuildContext context,
  ) =>
      BlocBuilder<LoginCubit, LoginState>(
        buildWhen: (
          LoginState previous,
          LoginState current,
        ) =>
            (previous.email != current.email),
        builder: (
          BuildContext context,
          LoginState state,
        ) =>
            TextField(
          key: const Key('login_email_field'),
          onChanged: (String email) =>
              context.read<LoginCubit>().emailChanged(email),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'Email', // TODO! i10n
            helperText: '',
            errorText:
                state.email.invalid ? 'Invalid Email' : null, // TODO! i10n
          ),
        ),
      );
}
