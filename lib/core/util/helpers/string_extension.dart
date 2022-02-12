import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:refocus_app/core/core.dart';

extension TextStyleExtension on String {
  Widget toButtonText({Color? color}) {
    return PlatformText(
      this,
      style: kBodyStyleRegular.copyWith(
        color: color ?? kcPrimary100,
      ),
    );
  }

  PlatformText toBodyText1({Color? color}) {
    return PlatformText(
      this,
      style: kBodyStyleBold.copyWith(
        color: color ?? kcPrimary100,
      ),
    );
  }

  PlatformText toSubtitle1({Color? color}) {
    return PlatformText(
      this,
      style: kSmallStyleRegular.copyWith(
        color: color ?? kcPrimary100,
      ),
    );
  }

  PlatformText toH5({Color? color}) {
    return PlatformText(
      this,
      style: kHeadline5StyleBold.copyWith(
        color: color ?? kcPrimary100,
      ),
    );
  }

  PlatformText toH6({Color? color}) {
    return PlatformText(
      this,
      style: kHeadline5StyleRegular.copyWith(
        color: color ?? kcPrimary100,
      ),
    );
  }
}
