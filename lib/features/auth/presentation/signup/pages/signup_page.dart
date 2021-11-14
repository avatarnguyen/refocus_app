import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:refocus_app/core/util/helpers/logging.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:refocus_app/features/auth/presentation/authentication/bloc/auth_bloc.dart';

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
          _buildTextField(_usernameTextCtrl, 'Username'),
          _buildTextField(_emailTextCtrl, 'Email Adress').padding(vertical: 20),
          _buildTextField(_passwordTextCtrl, 'Password'),
          _buildTextField(_repeatPasswordTextCtrl, 'Username')
              .padding(vertical: 20),
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
                    context.read<AuthBloc>().add(
                          AuthEvent.signUp(
                            username: _usernameTextCtrl.text,
                            email: _emailTextCtrl.text,
                            password: _passwordTextCtrl.text,
                          ),
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

  Widget _buildTextField(
      TextEditingController? textEditingController, String placeholderText) {
    return CupertinoTextField(
      controller: textEditingController,
      placeholder: placeholderText,
      placeholderStyle: context.subtitle1.copyWith(
        color: Colors.grey.shade300,
      ),
      style: context.bodyText2,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        borderRadius: kBorderRadTextField,
        border: Border.all(
          color: Colors.grey.shade300,
          width: 2,
        ),
      ),
    );
  }
}
