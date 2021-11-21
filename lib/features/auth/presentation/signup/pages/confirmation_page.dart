import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:refocus_app/core/core.dart';
import 'package:refocus_app/features/auth/presentation/authentication/bloc/auth_bloc.dart';
import 'package:refocus_app/features/auth/presentation/login/bloc/login_bloc.dart';
import 'package:refocus_app/features/auth/presentation/signup/bloc/signup_bloc.dart';
import 'package:refocus_app/features/auth/presentation/widgets/auth_textfield_widget.dart';

class ConfirmationPage extends StatefulWidget {
  const ConfirmationPage({Key? key}) : super(key: key);

  @override
  State<ConfirmationPage> createState() => _ConfirmationPageState();
}

class _ConfirmationPageState extends State<ConfirmationPage> {
  final _usernameTextFieldCtrl = TextEditingController();
  final _confirmationTextFieldCtrl = TextEditingController();
  late String _password;
  @override
  void initState() {
    super.initState();

    final _signupUsername = BlocProvider.of<SignupBloc>(context).state.username;
    if (_signupUsername?.value.isNotEmpty == true) {
      _usernameTextFieldCtrl.text = _signupUsername!.value;
      _password =
          BlocProvider.of<SignupBloc>(context).state.password?.value ?? '';
    } else {
      final _loginUsername = BlocProvider.of<LoginBloc>(context).state.username;
      _usernameTextFieldCtrl.text = _loginUsername?.value ?? '';
      _password =
          BlocProvider.of<LoginBloc>(context).state.password?.value ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Confirmation',
            style: context.h1,
          ).padding(bottom: 40),
          AuthTextFieldWidget(
            controller: _usernameTextFieldCtrl,
            placeHolderText: 'username',
            autocorrect: false,
          ).padding(vertical: 20),
          AuthTextFieldWidget(
            controller: _confirmationTextFieldCtrl,
            placeHolderText: 'confirmation code',
            autocorrect: false,
            autofocus: true,
            keyboardType: TextInputType.number,
          ).padding(vertical: 20),
          Row(
            children: [
              PlatformButton(
                color: context.colorScheme.primary,
                child: Text(
                  'Confirm Account',
                  style: context.bodyText1.copyWith(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  context.read<AuthBloc>().add(
                        AuthEvent.confirmAccount(
                          username: _usernameTextFieldCtrl.text,
                          confirmCode: _confirmationTextFieldCtrl.text,
                          password: _password,
                        ),
                      );
                },
              ).expanded()
            ],
          ).padding(top: 40),
        ],
      ).padding(horizontal: 20).safeArea(),
    );
  }
}
