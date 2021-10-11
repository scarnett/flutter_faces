import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_faces/app/widgets/widgets.dart';
import 'package:flutter_faces/signup/cubit/cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:formz/formz.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) =>
      BlocBuilder<SignUpCubit, SignUpState>(
        buildWhen: (
          SignUpState previous,
          SignUpState current,
        ) =>
            previous.status != current.status,
        builder: (
          BuildContext context,
          SignUpState state,
        ) =>
            state.status.isSubmissionInProgress
                ? AppLoader()
                : ElevatedButton(
                    key: const Key('signup_button'),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      primary: Colors.orangeAccent,
                    ),
                    onPressed: state.status.isValidated
                        ? () => context
                            .read<SignUpCubit>()
                            .signUpFormSubmitted(context)
                        : null,
                    child: Text(
                        AppLocalizations.of(context)!.signUp.toUpperCase()),
                  ),
      );
}
