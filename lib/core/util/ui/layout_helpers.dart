// Horizontal Spacing
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

const Widget horizontalSpaceTiny = SizedBox(width: 4.0);
const Widget horizontalSpaceSmall = SizedBox(width: 8.0);
const Widget horizontalSpaceRegular = SizedBox(width: 16.0);
const Widget horizontalSpaceMedium = SizedBox(width: 24.0);
const Widget horizontalSpaceLarge = SizedBox(width: 48.0);

// Vertical Spacing
const Widget verticalSpaceTiny = SizedBox(height: 4.0);
const Widget verticalSpaceSmall = SizedBox(height: 8.0);
const Widget verticalSpaceRegular = SizedBox(height: 16.0);
const Widget verticalSpaceMedium = SizedBox(height: 24);
const Widget verticalSpaceLarge = SizedBox(height: 48.0);
const Widget verticalSpaceMassive = SizedBox(height: 120.0);

const Widget progressIndicator = SizedBox(
  height: 40,
  width: 40,
  child: CircularProgressIndicator.adaptive(),
);

// Screen Size Helpers
double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;

/// Returns the pixel amount for the percentage of the screen height. [percentage] should
/// be between 0 and 1 where 0 is 0% and 100 is 100% of the screens height
double screenHeightPercentage(BuildContext context, {double percentage = 1}) =>
    screenHeight(context) * percentage;

/// Returns the pixel amount for the percentage of the screen width. [percentage] should
/// be between 0 and 1 where 0 is 0% and 100 is 100% of the screens width
double screenWidthPercentage(BuildContext context, {double percentage = 1}) =>
    screenWidth(context) * percentage;
