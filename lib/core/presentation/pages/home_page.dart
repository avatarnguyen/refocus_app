import 'dart:async';
import 'dart:io';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:refocus_app/amplifyconfiguration.dart';
import 'package:refocus_app/core/presentation/helper/page_stream.dart';
import 'package:refocus_app/core/presentation/helper/sliding_body_stream.dart';
import 'package:refocus_app/core/presentation/pages/today_page.dart';
import 'package:refocus_app/core/presentation/widgets/slider_header_widget.dart';
import 'package:refocus_app/core/util/helpers/logging.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:refocus_app/features/calendar/presentation/pages/calendar_list_page.dart';
import 'package:refocus_app/features/calendar/presentation/pages/calendar_page.dart';
import 'package:refocus_app/features/task/presentation/bloc/project_bloc.dart';
import 'package:refocus_app/features/task/presentation/bloc/task_bloc.dart';
import 'package:refocus_app/features/task/presentation/pages/project_page.dart';
import 'package:refocus_app/injection.dart';
import 'package:refocus_app/models/ModelProvider.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

// const rightPaddingSize = 8.0;

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProjectBloc>(
            create: (context) =>
                getIt<ProjectBloc>()..add(GetProjectEntriesEvent())),
        BlocProvider<TaskBloc>(
          create: (context) => getIt<TaskBloc>(),
        ),
      ],
      child: const HomePageWidget(),
    );
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
  late StreamSubscription _slidingBodySub;
  final GoogleSignIn _googleSignIn = getIt<GoogleSignIn>();

  int _currentPage = 1;
  int _currentSlidingBodyPage = 1;

  final log = logger(HomePage);
  bool amplifyConfigured = false;

  late SheetController _sheetController;

  @override
  void initState() {
    _configureAmplifyAndGoogleSignIn();
    _slidingBodySub = _slidingStream.pageStream.listen(_slidingPageReceived);

    // _googleSignIn.signInSilently();
    super.initState();

    _sheetController = SheetController();
  }

  void _slidingPageReceived(int newPage) {
    setState(() {
      _currentSlidingBodyPage = newPage;
    });
  }

  Future _configureAmplifyAndGoogleSignIn() async {
    try {
      await Future.wait([
        Amplify.addPlugin(AmplifyAPI()),
        Amplify.addPlugin(
            AmplifyDataStore(modelProvider: ModelProvider.instance)),
        Amplify.addPlugin(AmplifyAuthCognito()),
      ]);
      // Once Plugins are added, configure Amplify
      await Amplify.configure(amplifyconfig);

      // Sign in google calendar api
      await _googleSignIn.signInSilently();

      setState(() {
        amplifyConfigured = true;
      });
    } catch (e) {
      log.e(e);
    }
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
        color: kcDarkBackground,
        isBackdropInteractable: true,
        elevation: 16,
        cornerRadius: 16,
        shadowColor: kcPrimary100,
        backdropColor: Colors.black26,
        snapSpec: const SnapSpec(
          initialSnap: 0.09,
          snappings: [0.09, 0.5, 0.89],
        ),
        // parallaxSpec: ParallaxSpec(),
        minHeight: context.height * 0.9,
        closeOnBackdropTap: true,
        closeOnBackButtonPressed: Platform.isAndroid,
        headerBuilder: (context, state) => SheetListenerBuilder(
          buildWhen: (oldState, newState) =>
              oldState.isExpanded != newState.isExpanded,
          builder: (context, state) {
            return SlidingHeaderWidget(sheetState: state);
          },
        ),
        builder: (context, state) {
          if (amplifyConfigured) {
            if (_currentSlidingBodyPage == 0) {
              return const CalendarListPage();
            } else {
              return BlocProvider<ProjectBloc>.value(
                value: BlocProvider.of<ProjectBloc>(context),
                child: const ProjectPage(),
              );
            }
          } else {
            return const SizedBox();
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
                if (amplifyConfigured)
                  TodayPage(changePage: switchToPageView)
                else
                  progressIndicator,
              ],
            )
            // .opacity(_drawerClosed ? 1.0 : 0.32, animate: true)
            // .animate(400.milliseconds, Curves.fastOutSlowIn),
            ),
      ),
    );
  }
}
