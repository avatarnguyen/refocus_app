import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:refocus_app/features/calendar/presentation/bloc/calendar/datetime_stream.dart';

import 'package:refocus_app/injection.dart';

class PersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  PersistentHeaderDelegate(this.title,
      {this.backgroundColor,
      this.contentPadding,
      this.textStyle,
      this.maxSize,
      this.minSize});
  final Color? backgroundColor;
  final String title;
  final double? maxSize;
  final double? minSize;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? contentPadding;

  final DateTimeStream _dateTimeStream = getIt<DateTimeStream>();

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      padding: contentPadding ?? const EdgeInsets.only(left: 18, bottom: 8),
      color: backgroundColor ?? context.backgroundColor,
      child: Text(
        title,
        overflow: TextOverflow.clip,
        maxLines: 1,
        softWrap: true,
        textScaleFactor: context.textScaleFactor,
        style: textStyle ??
            context.bodyText2.copyWith(
              color: Platform.isIOS
                  ? CupertinoColors.systemGrey
                  : Colors.grey[600],
            ),
      ),
    ).gestures(onTap: () {
      if (maxSize != null) {
        _dateTimeStream.broadCastCurrentDate(DateTime.now());
      }
    });
  }

  @override
  double get maxExtent => maxSize ?? 40;

  @override
  double get minExtent => minSize ?? 24;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
