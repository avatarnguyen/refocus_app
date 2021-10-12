import 'package:flutter/material.dart';
import 'package:refocus_app/core/util/ui/style_helpers.dart';

extension TextStyleExtension on String {
  Text toButtonText() {
    return Text(
      this,
      style: kBodyStyleRegular.copyWith(
        color: kcPrimary100,
      ),
    );
  }
}
