import 'package:flutter/material.dart';

class SignupView extends StatelessWidget {
  static Route route() => MaterialPageRoute<void>(
        builder: (BuildContext context) => const SignupView(),
      );

  const SignupView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) =>
      Scaffold(
        appBar: AppBar(title: const Text('Sign Up')), // TODO! i10n
        body: Container(), // TODO!
      );
}
