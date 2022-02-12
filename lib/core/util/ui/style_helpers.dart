// shadow
import 'package:flutter/material.dart';
import 'package:refocus_app/gen/fonts.gen.dart';

class StyleUtils {
  static Color darken(Color color, [double amount = .1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(color);
    if (hsl.lightness - amount > 0.2) {
      final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
      return hslDark.toColor();
    } else {
      return hsl.withLightness(0.2.clamp(0.0, 1.0)).toColor();
    }
  }

  static Color lighten(Color color, [double amount = .1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(color);

    if ((hsl.lightness + amount) < 0.91) {
      final hslLight = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));
      return hslLight.toColor();
    } else {
      return hsl.withLightness(0.90.clamp(0.0, 1.0)).toColor();
    }
  }

  /// Turn Hash String Color to Color
  static Color getColorFromString(String colorString) {
    final color = colorString.replaceAll('#', '0xff');
    return Color(int.parse(color));
  }
}

const double kclighter1 = 0.16;
const double kclighter2 = 0.24;
const double kcdarker1 = 0.16;
const double kcdarker2 = 0.24;
const double kcdarker4 = 0.28;

const Color kcLightShadow = Color(0x19303133);
const BoxShadow kShadowLightBase = BoxShadow(
  color: Color(0x0c303133),
  blurRadius: 1,
);

const BoxShadow kShadowLight20 = BoxShadow(
  color: kcLightShadow,
  blurRadius: 3,
  offset: Offset(0, 1),
);
const BoxShadow kShadowLight40 = BoxShadow(
  color: kcLightShadow,
  blurRadius: 4,
  offset: Offset(0, 2),
);
const BoxShadow kShadowLight60 = BoxShadow(
  color: kcLightShadow,
  blurRadius: 8,
  offset: Offset(0, 4),
);

const BoxShadow kShadowLight80 = BoxShadow(
  color: kcLightShadow,
  blurRadius: 16,
  offset: Offset(0, 8),
);

const BoxShadow kShadowLight100 = BoxShadow(
  color: kcLightShadow,
  blurRadius: 24,
  offset: Offset(0, 16),
);

// Primary Shadow
const BoxShadow kShadowPrimaryBase = BoxShadow(
  color: Color(0x0c1e90ff),
  blurRadius: 1,
);
const BoxShadow kShadowPrimary60 = BoxShadow(
  color: Color(0x191e90ff),
  blurRadius: 8,
  offset: Offset(0, 4),
);
const BoxShadow kShadowPrimary80 = BoxShadow(
  color: Color(0x191e90ff),
  blurRadius: 16,
  offset: Offset(0, 8),
);
const BoxShadow kShadowPrimary100 = BoxShadow(
  color: Color(0x191e90ff),
  blurRadius: 24,
  offset: Offset(0, 16),
);

// Secondary Shadow
const BoxShadow kShadowSecondaryBase = BoxShadow(
  color: Color(0x0c5540fb),
  blurRadius: 1,
  offset: Offset(0, 0),
);
const BoxShadow kShadowSecondary60 = BoxShadow(
  color: Color(0x195540fb),
  blurRadius: 8,
  offset: Offset(0, 4),
);
const BoxShadow kShadowSecondary80 = BoxShadow(
  color: Color(0x195540fb),
  blurRadius: 16,
  offset: Offset(0, 8),
);
