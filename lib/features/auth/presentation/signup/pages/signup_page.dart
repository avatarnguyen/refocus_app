import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:refocus_app/core/util/helpers/logging.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:refocus_app/features/auth/presentation/signup/bloc/signup_bloc.dart';
import 'package:refocus_app/features/auth/presentation/widgets/auth_textfield_widget.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final log = logger(SignupPage);

  final _usernameTextCtrl = TextEditingController();
  final _emailTextCtrl = TextEditingController();
  final _passwordTextCtrl = TextEditingController();
  final _repeatPasswordTextCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          Text(
            'Sign Up',
            style: context.h1,
          ).padding(vertical: 40).alignment(Alignment.center),
          AuthTextFieldWidget(
            controller: _usernameTextCtrl,
            placeHolderText: 'Username',
            onChanged: (text) {
              context.read<SignupBloc>().add(SignupEvent.usernameChanged(text));
            },
          ),
          AuthTextFieldWidget(
            controller: _emailTextCtrl,
            placeHolderText: 'Email Adress',
            keyboardType: TextInputType.emailAddress,
            onChanged: (text) {
              context.read<SignupBloc>().add(SignupEvent.emailChanged(text));
            },
          ).padding(vertical: 20),
          AuthTextFieldWidget(
            controller: _passwordTextCtrl,
            placeHolderText: 'Password',
            onChanged: (text) {
              context.read<SignupBloc>().add(SignupEvent.passwordChanged(text));
            },
          ),
          AuthTextFieldWidget(
            controller: _repeatPasswordTextCtrl,
            placeHolderText: 'Repeat Password',
          ).padding(vertical: 20),
          Row(
            children: [
              PlatformButton(
                color: context.colorScheme.primary,
                child: Text(
                  'Sign Up',
                  style: context.bodyText1.copyWith(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  if (_passwordTextCtrl.text.trim() ==
                      _repeatPasswordTextCtrl.text.trim()) {
                    context.read<SignupBloc>().add(
                          const SignupEvent.submitted(),
                        );
                    context.popRoute();
                  }
                },
              ).expanded()
            ],
          ).padding(top: 40),
          Row(
            children: [
              PlatformTextButton(
                child: Text(
                  'Go back to Login',
                  style: context.bodyText1.copyWith(
                    color: context.colorScheme.primary,
                  ),
                ),
                onPressed: () {
                  context.popRoute();
                },
              ).expanded()
            ],
          ).padding(top: 10),
        ],
      ).safeArea(),
    );
  }
}
