import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_faces/login/cubit/cubit.dart';
import 'package:flutter_faces/login/widgets/widgets.dart';
import 'package:formz/formz.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) =>
      BlocListener<LoginCubit, LoginState>(
        listener: (
          BuildContext context,
          LoginState state,
        ) {
          if (state.status.isSubmissionFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  content: Text('Authentication Failure'), // TODO! i10n
                ),
              );
          }
        },
        child: Align(
          alignment: const Alignment(0.0, (-1.0 / 3.0)),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                LoginEmailField(),
                const SizedBox(height: 8.0),
                LoginPasswordField(),
                const SizedBox(height: 8.0),
                LoginButton(),
                const SizedBox(height: 8.0),
                GoogleLoginButton(),
                const SizedBox(height: 4.0),
                LoginSignUpButton(),
              ],
            ),
          ),
        ),
      );
}
