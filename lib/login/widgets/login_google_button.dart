import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_faces/login/cubit/cubit.dart';

class GoogleLoginButton extends StatelessWidget {
  @override
  Widget build(
    BuildContext context,
  ) =>
      ElevatedButton.icon(
        key: const Key('login_google_button'),
        label: const Text(
          'SIGN IN WITH GOOGLE', // TODO! i10n
          style: TextStyle(color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        icon: const Icon(
          Icons.help_outline, // TODO! google icon
          color: Colors.white,
        ),
        onPressed: () => context.read<LoginCubit>().logInWithGoogle(),
      );
}
