import 'package:flutter/material.dart';
import 'package:flutter_faces/signup/views/views.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginSignUpButton extends StatelessWidget {
  @override
  Widget build(
    BuildContext context,
  ) =>
      TextButton(
        key: const Key('login_signup_button'),
        onPressed: () => Navigator.of(context).push<void>(SignupView.route()),
        child: Text(AppLocalizations.of(context)!.createAccount.toUpperCase()),
      );
}
