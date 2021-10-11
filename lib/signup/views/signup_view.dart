import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_faces/auth/auth.dart';
import 'package:flutter_faces/signup/cubit/cubit.dart';
import 'package:flutter_faces/signup/forms/forms.dart';
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
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocProvider(
            create: (BuildContext context) =>
                SignUpCubit(context.read<AuthenticationRepository>()),
            child: const SignUpForm(),
          ),
        ),
      );
}
