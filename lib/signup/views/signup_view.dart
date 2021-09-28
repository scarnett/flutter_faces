import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        appBar: AppBar(title: Text(AppLocalizations.of(context)!.signUp)),
        body: Container(), // TODO!
      );
}
