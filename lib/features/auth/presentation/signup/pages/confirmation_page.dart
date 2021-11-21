import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:refocus_app/core/core.dart';
import 'package:refocus_app/features/auth/presentation/authentication/bloc/auth_bloc.dart';
import 'package:refocus_app/features/auth/presentation/widgets/auth_textfield_widget.dart';

class ConfirmationPage extends StatefulWidget {
  const ConfirmationPage({Key? key}) : super(key: key);

  @override
  State<ConfirmationPage> createState() => _ConfirmationPageState();
}

class _ConfirmationPageState extends State<ConfirmationPage> {
  final _usernameTextFieldCtrl = TextEditingController();
  final _confirmationTextFieldCtrl = TextEditingController();

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
            placeHolderText: 'confirm code',
            autocorrect: false,
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
