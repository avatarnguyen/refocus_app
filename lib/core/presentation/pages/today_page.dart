import 'dart:async';
import 'dart:io';

import 'package:dartx/dartx.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:refocus_app/core/presentation/bloc/today_bloc.dart';
import 'package:refocus_app/core/presentation/widgets/persistent_header_delegate.dart';
import 'package:refocus_app/core/presentation/widgets/today_list_widget.dart';
import 'package:refocus_app/core/util/helpers/logging.dart' as custom_log;
import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:refocus_app/features/calendar/presentation/bloc/calendar/datetime_stream.dart';
import 'package:refocus_app/injection.dart';

class TodayPage extends StatefulWidget {
  const TodayPage({Key? key, required this.changePage}) : super(key: key);

  final VoidCallback changePage;

  @override
  _TodayPageState createState() => _TodayPageState();
}

class _TodayPageState extends State<TodayPage> {
  late ScrollController _sController;
  final log = custom_log.logger(TodayPage);

  bool showMonthView = false;
  bool isAtTop = false;

  String returnDate(DateTime date) {
    return DateFormat.yMMMMEEEEd().format(date);
  }

  @override
  void initState() {
    super.initState();
    _sController = ScrollController();
    _sController.addListener(() {
      // log.i(_sController.offset);
      if (_sController.offset > 38) {
        if (!isAtTop) {
          setState(() {
            isAtTop = true;
          });
        }
      } else {
        if (isAtTop) {
          setState(() {
            isAtTop = false;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _sController.removeListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();

    return BlocProvider<TodayBloc>(
      create: (context) => getIt<TodayBloc>(),
      // ..add(GetTodayEntries(DateTime.now()))
      // ..add(GetTomorrowEntries(1.days.fromNow))
      // ..add(GetUpcomingTask(2.days.fromNow, 5.days.fromNow)),
      child: Platform.isIOS
          ? CupertinoPageScaffold(
              child: NestedScrollView(
                controller: _sController,
                headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  CupertinoSliverNavigationBar(
                    border: null,
                    backgroundColor: kcLightBackground,
                    padding: const EdgeInsetsDirectional.all(8),
                    largeTitle: !isAtTop
                        ? Text(_getGreeting())
                        : const Icon(CupertinoIcons.sun_max_fill),
                    leading: [
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        child: const Icon(CupertinoIcons.calendar),
                        onPressed: () {
                          widget.changePage();
                        },
                      ),
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        child: const Icon(CupertinoIcons.search),
                        onPressed: () {
                          widget.changePage();
                        },
                      )
                    ].toRow(mainAxisSize: MainAxisSize.min),
                    trailing: SizedBox(
                      child: [
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          child: const Icon(CupertinoIcons.archivebox_fill),
                          onPressed: () {},
                        ),
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          child: const Icon(CupertinoIcons.person_fill),
                          onPressed: () {},
                        ),
                      ].toRow(mainAxisSize: MainAxisSize.min),
                    ),
                  ),
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: PersistentHeaderDelegate(
                      returnDate(today),
                      minSize: 30,
                      maxSize: 30,
                    ),
                  ),
                ],
                body: const TodayListWidget().parent(
                  ({required child}) => todayPage(context, child: child),
                ),
              ),
            )
          : Scaffold(
              body: NestedScrollView(
                controller: _sController,
                headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  SliverAppBar(
                    // backgroundColor: context.theme.backgroundColor,
                    // foregroundColor: context.theme.primaryColor,
                    pinned: true,
                    elevation: 0,
                    expandedHeight: 114,
                    leading: IconButton(
                      padding: EdgeInsets.zero,
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () {
                        widget.changePage();
                      },
                    ),
                    actions: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          widget.changePage();
                        },
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        icon: const Icon(Icons.inbox),
                        onPressed: () {},
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        icon: const Icon(Icons.person),
                        onPressed: () {},
                      ),
                    ],
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: isAtTop,
                      titlePadding: !isAtTop
                          ? const EdgeInsets.only(left: 16, bottom: 4)
                          : const EdgeInsets.only(bottom: 16),
                      title: !isAtTop
                          ? Text(_getGreeting())
                          : const Icon(CupertinoIcons.sun_max_fill),
                    ),
                  ),
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: PersistentHeaderDelegate(
                      returnDate(today),
                      backgroundColor: kcPrimary500,
                      minSize: 30,
                      maxSize: 30,
                    ),
                  ),
                ],
                body: const TodayListWidget().parent(
                  ({required child}) => todayPage(context, child: child),
                ),
              ),
            ),
    );
  }

  String _getGreeting() {
    final _currentHour = DateTime.now().hour;
    if (_currentHour > 11 && _currentHour < 18) {
      return 'Good Afternoon!';
    } else if (_currentHour > 5 && _currentHour < 12) {
      return 'Good Morning!';
    } else if (_currentHour > 17 && _currentHour < 22) {
      return 'Good Evening!';
    } else {
      return 'Good Night!';
    }
  }
}
