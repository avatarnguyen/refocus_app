import 'package:flutter/material.dart';
import 'package:refocus_app/core/util/ui/style_helpers.dart';

extension TextStyleExtension on String {
  Text toButtonText({Color? color}) {
    return Text(
      this,
      style: kBodyStyleRegular.copyWith(
        color: color ?? kcPrimary100,
      ),
    );
  }

  Text toBodyText1({Color? color}) {
    return Text(
      this,
      style: kBodyStyleBold.copyWith(
        color: color ?? kcPrimary100,
      ),
    );
  }

  Text toSubtitle1({Color? color}) {
    return Text(
      this,
      style: kSmallStyleRegular.copyWith(
        color: color ?? kcPrimary100,
      ),
    );
  }

  Text toH5({Color? color}) {
    return Text(
      this,
      style: kHeadline5StyleBold.copyWith(
        color: color ?? kcPrimary100,
      ),
    );
  }

  Text toH6({Color? color}) {
    return Text(
      this,
      style: kHeadline5StyleRegular.copyWith(
        color: color ?? kcPrimary100,
      ),
    );
  }
}
