import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_faces/app/widgets/widgets.dart';
import 'package:flutter_faces/login/cubit/cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:formz/formz.dart';

class LoginButton extends StatelessWidget {
  @override
  Widget build(
    BuildContext context,
  ) =>
      BlocBuilder<LoginCubit, LoginState>(
        buildWhen: (
          LoginState previous,
          LoginState current,
        ) =>
            (previous.status != current.status),
        builder: (
          BuildContext context,
          LoginState state,
        ) =>
            state.status.isSubmissionInProgress
                ? AppLoader()
                : ElevatedButton(
                    key: const Key('login_button'),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    onPressed: state.status.isValidated
                        ? () =>
                            context.read<LoginCubit>().logInWithCredentials()
                        : null,
                    child:
                        Text(AppLocalizations.of(context)!.login.toUpperCase()),
                  ),
      );
}
