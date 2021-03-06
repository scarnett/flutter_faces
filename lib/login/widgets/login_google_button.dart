import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_faces/login/cubit/cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GoogleLoginButton extends StatelessWidget {
  @override
  Widget build(
    BuildContext context,
  ) =>
      ElevatedButton.icon(
        key: const Key('login_google_button'),
        label: Text(
          AppLocalizations.of(context)!.googleSignin.toUpperCase(),
          style: TextStyle(color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        icon: Image.asset(
          'assets/logos/google.png',
          height: 20.0,
        ),
        onPressed: () => context.read<LoginCubit>().logInWithGoogle(context),
      );
}
