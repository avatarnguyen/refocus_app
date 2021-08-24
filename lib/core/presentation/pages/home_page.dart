import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:refocus_app/core/presentation/pages/today_page.dart';
import 'package:refocus_app/core/presentation/widgets/page_stream.dart';
import 'package:refocus_app/core/presentation/widgets/slider_header_widget.dart';
import 'package:refocus_app/core/util/helpers/logging.dart';
import 'package:refocus_app/features/calendar/presentation/pages/calendar_page.dart';
import 'package:refocus_app/features/task/presentation/bloc/task_bloc.dart';
import 'package:refocus_app/features/task/presentation/pages/project_page.dart';
import 'package:refocus_app/models/ModelProvider.dart';
import 'package:tale_drawer/tale_drawer.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';

import 'package:get/get.dart';

import '../../../amplifyconfiguration.dart';
import '../../../injection.dart';

const rightPaddingSize = 8.0;

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TaskBloc>(
        create: (context) =>
            getIt<TaskBloc>(), //..add(GetProjectEntriesEvent()),
        child: const HomePageWidget());
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
  final GoogleSignIn _googleSignIn = getIt<GoogleSignIn>();
  final drawerController = TaleController();
  double rightPadding = rightPaddingSize;

  int _currentPage = 1;

  final log = logger(HomePage);
  bool amplifyConfigured = false;

  @override
  void initState() {
    super.initState();
    _configureAmplify();

    _googleSignIn.signInSilently();
  }

  void _configureAmplify() async {
    // await Amplify.addPlugin(AmplifyAPI()); // UNCOMMENT this line after backend is deployed
    await Amplify.addPlugin(
        AmplifyDataStore(modelProvider: ModelProvider.instance));

    try {
      // Once Plugins are added, configure Amplify
      await Amplify.configure(amplifyconfig);
    } catch (e) {
      log.e(e);
    }
    setState(() {
      amplifyConfigured = true;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void onDrawerPressed() {
    drawerController.isDrawerOpen
        ? drawerController.close()
        : drawerController.open();
  }

  void switchToPageView() {
    _pageController.animateToPage(_currentPage == 0 ? 1 : 0,
        duration: 400.milliseconds, curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return TaleDrawer(
      controller: drawerController,
      type: TaleType.Flip,
      drawerState: DrawerState.CLOSED,
      sideState: SideState.RIGHT,
      listener: TaleListener(
        onOpen: () {
          print('OnOpen');
        },
        onClose: () {
          print('OnClose');
        },
      ),
      settings: FlipSettings(
        type: DrawerAnimation.FLIP,
        drawerWidth: context.width - 24.0,
        flipPercent: 80,
      ),
      drawer: Container(
        color: kcPrimary600,
      ),
      body: Scaffold(
        body: SlidingSheet(
          color: kcDarkBackground,
          isBackdropInteractable: true,
          elevation: 16,
          cornerRadius: 16,
          shadowColor: Colors.black26,
          addTopViewPaddingOnFullscreen: true,
          snapSpec: const SnapSpec(
            snap: true,
            initialSnap: 0.09,
            snappings: [0.09, 0.5, 1.0],
            positioning: SnapPositioning.relativeToAvailableSpace,
          ),
          headerBuilder: (context, state) => SlidingHeaderWidget(
            changePage: switchToPageView,
          ),
          builder: (context, state) => amplifyConfigured
              ? BlocProvider<TaskBloc>.value(
                  value: BlocProvider.of<TaskBloc>(context),
                  child: const ProjectPage(),
                )
              : Container(),
          body: Container(
            color: kcLightBackground,
            height: context.height,
            width: context.width,
            padding: EdgeInsets.only(right: rightPadding),
            child: PageView(
              allowImplicitScrolling: true,
              physics: const ClampingScrollPhysics(),
              controller: _pageController,
              onPageChanged: (int index) {
                _pageStream.broadCastCurrentPage(index);
                _currentPage = index;
                if (index == 0) {
                  //* Maybe change to Valuelistener Builder to make this faster
                  setState(() {
                    rightPadding = 0.0;
                  });
                } else {
                  setState(() {
                    rightPadding = rightPaddingSize;
                  });
                }
              },
              children: [
                const CalendarPage(),
                amplifyConfigured
                    ? TodayPage(
                        onDrawerSelected: onDrawerPressed,
                      )
                    : progressIndicator,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
