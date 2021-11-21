import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:refocus_app/core/util/ui/ui_helper.dart';

class AuthTextFieldWidget extends StatefulWidget {
  const AuthTextFieldWidget({
    Key? key,
    required this.controller,
    this.placeHolderText,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.obscureText = false,
    this.autocorrect = true,
  }) : super(key: key);

  final TextEditingController controller;
  final String? placeHolderText;
  final Function(String)? onChanged;
  final Function()? onEditingComplete;
  final Function(String)? onSubmitted;
  final bool obscureText;
  final bool autocorrect;

  @override
  _AuthTextFieldWidgetState createState() => _AuthTextFieldWidgetState();
}

class _AuthTextFieldWidgetState extends State<AuthTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      controller: widget.controller,
      placeholder: widget.placeHolderText,
      placeholderStyle: context.subtitle1.copyWith(
        color: Colors.grey.shade300,
      ),
      obscureText: widget.obscureText,
      autocorrect: widget.autocorrect,
      style: context.bodyText2,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        borderRadius: kBorderRadTextField,
        border: Border.all(
          color: Colors.grey.shade300,
          width: 2,
        ),
      ),
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
      onEditingComplete: widget.onEditingComplete,
    );
  }
}
