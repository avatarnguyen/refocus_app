import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:formz/formz.dart';
import 'package:refocus_app/config/routes/router.dart';
import 'package:refocus_app/core/util/helpers/logging.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:refocus_app/enum/authetication_status.dart';
import 'package:refocus_app/features/auth/presentation/authentication/bloc/auth_bloc.dart';
import 'package:refocus_app/features/auth/presentation/login/bloc/login_bloc.dart';
import 'package:refocus_app/features/auth/presentation/widgets/auth_textfield_widget.dart';
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
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status?.isSubmissionSuccess == true) {
          context.read<AuthBloc>().add(
                const AuthEvent.authenticationChanged(
                  AuthenticationStatus.authenticated,
                ),
              );
        }
        if (state.status?.isSubmissionCanceled == true) {
          context.read<AuthBloc>().add(
                const AuthEvent.authenticationChanged(
                  AuthenticationStatus.confirmationRequired,
                ),
              );
        }
      },
      child: PlatformScaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Login',
              style: context.h1,
            ).padding(bottom: 40),
            AuthTextFieldWidget(
              controller: _usernameTextCtrl,
              placeHolderText: 'Username',
              onChanged: (text) {
                context.read<LoginBloc>().add(LoginEvent.usernameChanged(text));
              },
            ).padding(vertical: 20),
            AuthTextFieldWidget(
              controller: _passwordTextCtrl,
              placeHolderText: 'Password',
              obscureText: true,
              onChanged: (text) {
                context.read<LoginBloc>().add(LoginEvent.passwordChanged(text));
              },
            ),
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
                    context.read<LoginBloc>().add(const LoginEvent.submitted());
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
      ),
    );
  }
}
