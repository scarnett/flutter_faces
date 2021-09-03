import 'package:flutter/material.dart';
import 'package:flutter_faces/signup/views/views.dart';

class LoginSignUpButton extends StatelessWidget {
  @override
  Widget build(
    BuildContext context,
  ) =>
      TextButton(
        key: const Key('login_signup_button'),
        onPressed: () => Navigator.of(context).push<void>(SignupView.route()),
        child: Text('CREATE ACCOUNT'), // TODO! i10n
      );
}
