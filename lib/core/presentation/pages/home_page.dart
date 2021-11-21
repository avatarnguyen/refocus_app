import 'dart:async';
import 'dart:io';

import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:refocus_app/core/presentation/helper/page_stream.dart';
import 'package:refocus_app/core/presentation/helper/sliding_body_stream.dart';
import 'package:refocus_app/core/presentation/widgets/slider_header_widget.dart';
import 'package:refocus_app/core/util/helpers/logging.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:refocus_app/features/calendar/presentation/bloc/calendar/calendar_bloc.dart';
import 'package:refocus_app/features/calendar/presentation/bloc/calendar_list/calendar_list_bloc.dart';
import 'package:refocus_app/features/calendar/presentation/pages/calendar_list_page.dart';
import 'package:refocus_app/features/calendar/presentation/pages/calendar_page.dart';
import 'package:refocus_app/features/task/presentation/bloc/cubit/subtask_cubit.dart';
import 'package:refocus_app/features/task/presentation/bloc/project_bloc.dart';
import 'package:refocus_app/features/task/presentation/bloc/task_bloc.dart';
import 'package:refocus_app/features/task/presentation/pages/project_page.dart';
import 'package:refocus_app/features/today/presentation/pages/today_page.dart';
import 'package:refocus_app/injection.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

// const rightPaddingSize = 8.0;

class HomePage extends StatelessWidget implements AutoRouteWrapper {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProjectBloc>(
          create: (_) => getIt<ProjectBloc>()..add(GetProjectEntriesEvent()),
        ), //..add(GetProjectEntriesEvent())),
        BlocProvider<TaskBloc>(
          create: (_) => getIt<TaskBloc>(),
        ),
        BlocProvider(
          create: (_) => getIt<SubtaskCubit>(),
        ),
        BlocProvider<CalendarListBloc>(
          create: (_) => getIt<CalendarListBloc>()..add(GetCalendarListEvent()),
        ),
        BlocProvider<CalendarBloc>(
          create: (_) => getIt<CalendarBloc>(),
        ),
      ],
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }
}

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  final PageController _pageController = PageController(
    initialPage: 1,
  );
  final PageStream _pageStream = getIt<PageStream>();
  final SlidingBodyStream _slidingStream = getIt<SlidingBodyStream>();
  final GoogleSignIn _googleSignIn = getIt<GoogleSignIn>();

  late StreamSubscription _slidingBodySub;

  int _currentPage = 1;
  int _currentSlidingBodyPage = 1;

  final log = logger(HomePage);

  late SheetController _sheetController;

  @override
  void initState() {
    _attemptSignInGoogle();
    _slidingBodySub = _slidingStream.pageStream.listen(_slidingPageReceived);
    _sheetController = SheetController();

    super.initState();
  }

  void _slidingPageReceived(int newPage) {
    setState(() {
      _currentSlidingBodyPage = newPage;
    });
  }

  Future _attemptSignInGoogle() async {
    // Sign in google calendar api
    await _googleSignIn.signInSilently();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _slidingBodySub.cancel();
    super.dispose();
  }

  void switchToPageView() {
    _pageController.animateToPage(_currentPage == 0 ? 1 : 0,
        duration: 400.milliseconds, curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return _drawerBody(context);
  }

  PlatformScaffold _drawerBody(BuildContext context) {
    return PlatformScaffold(
      body: SlidingSheet(
        controller: _sheetController,
        color: kcDarkBackground,
        isBackdropInteractable: true,
        elevation: 16,
        cornerRadius: 16,
        shadowColor: Colors.black26,
        backdropColor: Colors.black12,
        snapSpec: const SnapSpec(
          initialSnap: 0.09,
          snappings: [0.09, 0.5, 0.89],
        ),
        minHeight: context.height * 0.9,
        closeOnBackdropTap: true,
        closeOnBackButtonPressed: Platform.isAndroid,
        headerBuilder: (context, state) => SheetListenerBuilder(
          buildWhen: (oldState, newState) =>
              oldState.isExpanded != newState.isExpanded,
          builder: (context, state) {
            return SlidingHeaderWidget(
              sheetState: state,
              closeSheet: _collapseBottomSheet,
              expandSheet: _expandBottomSheet,
            );
          },
        ),
        builder: (context, state) {
          if (_currentSlidingBodyPage == 0) {
            return const CalendarListPage();
          } else {
            return const ProjectPage();
          }
        },
        body: SizedBox(
          height: context.height,
          width: context.width,
          child: PageView(
            allowImplicitScrolling: true,
            physics: const ClampingScrollPhysics(),
            controller: _pageController,
            onPageChanged: (int index) {
              _pageStream.broadCastCurrentPage(index);
              _currentPage = index;
            },
            children: [
              CalendarPage(changePage: switchToPageView),
              TodayPage(changePage: switchToPageView),
            ],
          ),
        ),
      ),
    );
  }

  void _collapseBottomSheet() {
    log.i('Collapse Sheet');
    _sheetController.collapse();
  }

  void _expandBottomSheet() {
    _sheetController.expand();
  }
}
