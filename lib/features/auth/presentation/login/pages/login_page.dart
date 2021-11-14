import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:refocus_app/config/routes/router.dart';
import 'package:refocus_app/core/util/helpers/logging.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:refocus_app/features/auth/presentation/authentication/bloc/auth_bloc.dart';
import 'package:styled_widget/styled_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final log = logger(LoginPage);

  final _usernameTextCtrl = TextEditingController();
  final _passwordTextCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Login',
            style: context.h1,
          ).padding(bottom: 40),
          _buildTextField(_usernameTextCtrl, 'Username').padding(bottom: 20),
          _buildTextField(_passwordTextCtrl, 'Password'),
          Row(
            children: [
              PlatformButton(
                color: context.colorScheme.primary,
                child: Text(
                  'Login',
                  style: context.bodyText1.copyWith(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  context.read<AuthBloc>().add(
                        AuthEvent.login(
                          username: _usernameTextCtrl.text,
                          password: _passwordTextCtrl.text,
                        ),
                      );
                },
              ).expanded()
            ],
          ).padding(top: 40),
          Row(
            children: [
              PlatformTextButton(
                child: Text(
                  'Create an account',
                  style: context.bodyText1.copyWith(
                    color: context.colorScheme.primary,
                  ),
                ),
                onPressed: () {
                  context.pushRoute(const SignupRoute());
                },
              ).expanded()
            ],
          ).padding(top: 10),
        ],
      ).padding(horizontal: 20).safeArea(),
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
