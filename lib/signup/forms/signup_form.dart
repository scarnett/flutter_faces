import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_faces/signup/cubit/cubit.dart';
import 'package:flutter_faces/signup/widgets/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:formz/formz.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) =>
      BlocListener<SignUpCubit, SignUpState>(
        listener: (
          BuildContext context,
          SignUpState state,
        ) {
          if (state.status.isSubmissionSuccess) {
            Navigator.of(context).pop();
          } else if (state.status.isSubmissionFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                    content: Text(state.errorMessage ??
                        AppLocalizations.of(context)!.signUpFailure)),
              );
          }
        },
        child: Align(
          alignment: const Alignment(0.0, (-1.0 / 3.0)),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SignUpEmailField(),
                const SizedBox(height: 8.0),
                SignUpPasswordField(),
                const SizedBox(height: 8.0),
                SignUpConfirmPasswordField(),
                const SizedBox(height: 8.0),
                SignUpButton(),
              ],
            ),
          ),
        ),
      );
}
