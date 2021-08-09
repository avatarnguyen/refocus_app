// shadow
import 'package:flutter/material.dart';
import 'package:refocus_app/gen/fonts.gen.dart';

const Color kcLightShadow = Color(0x19303133);
const BoxShadow kShadowLightBase = BoxShadow(
  color: Color(0x0c303133),
  blurRadius: 1,
  offset: Offset(0, 0),
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
  offset: Offset(0, 0),
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

// colors
const Color kcLightBackground = Color(0xffFBFAFC);
const Color kcDarkBackground = Color(0xff031332);

const Color kcPrimary100 = Color(0xffEEECFF);
const Color kcPrimary200 = Color(0xffDDD9FE);
const Color kcPrimary300 = Color(0xffBBB3FD);
const Color kcPrimary400 = Color(0xff8879FC);
const Color kcPrimary500 = Color(0xff5540FB); // Base
const Color kcPrimary600 = Color(0xff3B2DB0);
const Color kcPrimary700 = Color(0xff221A64);
const Color kcPrimary800 = Color(0xff110D32);
const Color kcPrimary900 = Color(0xff080619);

const Color kcSecondary100 = Color(0xffE7EFFF);
const Color kcSecondary200 = Color(0xffCFDFFE);
const Color kcSecondary300 = Color(0xffA0BFFD);
const Color kcSecondary400 = Color(0xff709FFD);
const Color kcSecondary500 = Color(0xff115FFB);
const Color kcSecondary600 = Color(0xff0A3997);
const Color kcSecondary700 = Color(0xff072664);
const Color kcSecondary800 = Color(0xff031332);
const Color kcSecondary900 = Color(0xff020919);

const Color kcTertiary100 = Color(0xffD2E9FF);
const Color kcTertiary200 = Color(0xffA5D3FF);
const Color kcTertiary300 = Color(0xff78BCFF);
const Color kcTertiary400 = Color(0xff4BA6FF);
const Color kcTertiary500 = Color(0xff1E90FF);
const Color kcTertiary600 = Color(0xff1873CC);
const Color kcTertiary700 = Color(0xff125699);
const Color kcTertiary800 = Color(0xff061D33);
const Color kcTertiary900 = Color(0xff030E19);

const Color kcSuccess300 = Color(0xffA3DDBC);
const Color kcSuccess400 = Color(0xff5DC389);
const Color kcSuccess500 = Color(0xff18A957);
const Color kcSuccess600 = Color(0xff11763D);

const Color kcWarning300 = Color(0xffFFE4AF);
const Color kcWarning400 = Color(0xffFFCF74);
const Color kcWarning500 = Color(0xffFFBB38);
const Color kcWarning600 = Color(0xffB38327);

const Color kcError300 = Color(0xffF2A2B3);
const Color kcError400 = Color(0xffE95C7B);
const Color kcError500 = Color(0xffDF1642);
const Color kcError600 = Color(0xff9C0F2E);

const Color kTextColor = Colors.black87;

// Font Sizing
const double kHeadline1TextSize = 48;
const double kHeadline2TextSize = 37;
const double kHeadline3TextSize = 31;
const double kHeadline4TextSize = 26;
const double kHeadline5TextSize = 21;
const double kLeadTextSize = 24;
const double kBodyTextSize = 18;
const double kSmallTextSize = 16;
const double kCaptionTextSize = 14;
const double kXSmallTextSize = 12;
const double kTinyTextSize = 10;

// Text Style, Font: Inter
const TextStyle kHeadline1StyleBold = TextStyle(
  fontSize: kHeadline1TextSize,
  fontFamily: FontFamily.inter,
  fontWeight: FontWeight.w700,
  color: kTextColor,
);
const TextStyle kHeadline1StyleRegular = TextStyle(
  fontSize: kHeadline1TextSize,
  fontFamily: FontFamily.inter,
  fontWeight: FontWeight.w400,
  color: kTextColor,
);
const TextStyle kHeadline2StyleBold = TextStyle(
  fontSize: kHeadline2TextSize,
  fontFamily: FontFamily.inter,
  fontWeight: FontWeight.w700,
  color: kTextColor,
);
const TextStyle kHeadline2StyleRegular = TextStyle(
  fontSize: kHeadline2TextSize,
  fontFamily: FontFamily.inter,
  fontWeight: FontWeight.w400,
  color: kTextColor,
);
const TextStyle kHeadline3StyleBold = TextStyle(
  fontSize: kHeadline3TextSize,
  fontFamily: FontFamily.inter,
  fontWeight: FontWeight.w700,
  color: kTextColor,
);
const TextStyle kHeadline3StyleRegular = TextStyle(
  fontSize: kHeadline3TextSize,
  fontFamily: FontFamily.inter,
  fontWeight: FontWeight.w400,
  color: kTextColor,
);
const TextStyle kHeadline4StyleBold = TextStyle(
  fontSize: kHeadline4TextSize,
  fontFamily: FontFamily.inter,
  fontWeight: FontWeight.w700,
  color: kTextColor,
);
const TextStyle kHeadline4StyleRegular = TextStyle(
  fontSize: kHeadline4TextSize,
  fontFamily: FontFamily.inter,
  fontWeight: FontWeight.w400,
  color: kTextColor,
);
const TextStyle kHeadline5StyleBold = TextStyle(
  fontSize: kHeadline5TextSize,
  fontFamily: FontFamily.inter,
  fontWeight: FontWeight.w700,
  color: kTextColor,
);
const TextStyle kHeadline5StyleRegular = TextStyle(
  fontSize: kHeadline5TextSize,
  fontFamily: FontFamily.inter,
  fontWeight: FontWeight.w400,
  color: kTextColor,
);
const TextStyle kLeadStyleBold = TextStyle(
  fontSize: kLeadTextSize,
  fontFamily: FontFamily.inter,
  fontWeight: FontWeight.w700,
  color: kTextColor,
);
const TextStyle kLeadStyleRegular = TextStyle(
  fontSize: kLeadTextSize,
  fontFamily: FontFamily.inter,
  fontWeight: FontWeight.w400,
  color: kTextColor,
);
const TextStyle kBodyStyleBold = TextStyle(
  fontSize: kBodyTextSize,
  fontFamily: FontFamily.inter,
  fontWeight: FontWeight.w700,
  color: kTextColor,
);
const TextStyle kBodyStyleRegular = TextStyle(
  fontSize: kBodyTextSize,
  fontFamily: FontFamily.inter,
  fontWeight: FontWeight.w400,
  color: kTextColor,
);
const TextStyle kSmallStyleBold = TextStyle(
  fontSize: kSmallTextSize,
  fontFamily: FontFamily.inter,
  fontWeight: FontWeight.w700,
  color: kTextColor,
);
const TextStyle kSmallStyleRegular = TextStyle(
  fontSize: kSmallTextSize,
  fontFamily: FontFamily.inter,
  fontWeight: FontWeight.w400,
  color: kTextColor,
);
const TextStyle kCaptionStyleBold = TextStyle(
  fontSize: kCaptionTextSize,
  fontFamily: FontFamily.inter,
  fontWeight: FontWeight.w700,
  color: kTextColor,
);
const TextStyle kCaptionStyleRegular = TextStyle(
  fontSize: kCaptionTextSize,
  fontFamily: FontFamily.inter,
  fontWeight: FontWeight.w400,
  color: kTextColor,
);
const TextStyle kXSmallStyleBold = TextStyle(
  fontSize: kXSmallTextSize,
  fontFamily: FontFamily.inter,
  fontWeight: FontWeight.w700,
  color: kTextColor,
);
const TextStyle kXSmallStyleRegular = TextStyle(
  fontSize: kXSmallTextSize,
  fontFamily: FontFamily.inter,
  fontWeight: FontWeight.w400,
  color: kTextColor,
);
const TextStyle kTinyStyleBold = TextStyle(
  fontSize: kTinyTextSize,
  fontFamily: FontFamily.inter,
  fontWeight: FontWeight.w700,
  color: kTextColor,
);
const TextStyle kTinyStyleRegular = TextStyle(
  fontSize: kTinyTextSize,
  fontFamily: FontFamily.inter,
  fontWeight: FontWeight.w400,
  color: kTextColor,
);
