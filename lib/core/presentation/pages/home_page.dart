import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
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
  final _advancedDrawerController = AdvancedDrawerController();

  double rightPadding = rightPaddingSize;

  int _currentPage = 1;

  final log = logger(HomePage);
  bool amplifyConfigured = false;
  bool _drawerClosed = true;

  @override
  void initState() {
    _advancedDrawerController.addListener(() {
      if (_advancedDrawerController.value == AdvancedDrawerValue.visible()) {
        setState(() {
          _drawerClosed = false;
        });
      } else {
        setState(() {
          _drawerClosed = true;
        });
      }
    });
    super.initState();
    _configureAmplify();

    _googleSignIn.signInSilently();
  }

  void _configureAmplify() async {
    try {
      await Future.wait([
        Amplify.addPlugin(AmplifyAPI()),
        Amplify.addPlugin(
            AmplifyDataStore(modelProvider: ModelProvider.instance)),
        Amplify.addPlugin(AmplifyAuthCognito()),
      ]);
      // Once Plugins are added, configure Amplify
      await Amplify.configure(amplifyconfig);
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
    _advancedDrawerController.removeListener(() {});
    super.dispose();
  }

  void onDrawerPressed() {
    print('Drawer');
    (_advancedDrawerController.value == AdvancedDrawerValue.visible())
        ? _advancedDrawerController.showDrawer()
        : _advancedDrawerController.showDrawer();

    // drawerController.isDrawerOpen
    //     ? drawerController.close()
    //     : drawerController.open();
  }

  void switchToPageView() {
    _pageController.animateToPage(_currentPage == 0 ? 1 : 0,
        duration: 400.milliseconds, curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdropColor: kcPrimary700,
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: true,
      childDecoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      drawer: SafeArea(
        child: SizedBox.expand(
          child: ListTileTheme(
            textColor: Colors.white,
            iconColor: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const Spacer(flex: 1),
                ListTile(
                  onTap: () {},
                  leading: Icon(Icons.home),
                  title: Text('Home'),
                ),
                ListTile(
                  onTap: () {},
                  leading: Icon(Icons.account_circle_rounded),
                  title: Text('Profile'),
                ),
                ListTile(
                  onTap: () {},
                  leading: Icon(Icons.favorite),
                  title: Text('Favourites'),
                ),
                ListTile(
                  onTap: () {},
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                ),
                const Spacer(),
                DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white54,
                  ),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 16.0,
                    ),
                    child: const Text('Terms of Service | Privacy Policy'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      child: _drawerBody(context),
    );

    // TaleDrawer(
    //   controller: drawerController,
    //   type: TaleType.Zoom,
    //   drawerState: DrawerState.CLOSED,
    //   sideState: SideState.LEFT,
    //   listener: TaleListener(
    //     onOpen: () {
    //       print('OnOpen');
    //       setState(() {
    //         _drawerClosed = false;
    //       });
    //     },
    //     onClose: () {
    //       print('OnClose');
    //       setState(() {
    //         _drawerClosed = true;
    //       });
    //     },
    //   ),
    //   settings: ZoomSettings(
    //     maxSlide: context.width - 64,
    //     addHeightScale: 0.1,
    //   ),
    //   drawer: Container(
    //     color: kcPrimary700,
    //   ),
    //   body: _drawerBody(context),
    // );
  }

  Scaffold _drawerBody(BuildContext context) {
    return Scaffold(
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
            physics: _drawerClosed
                ? const ClampingScrollPhysics()
                : const NeverScrollableScrollPhysics(),
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
          )
              .opacity(_drawerClosed ? 1.0 : 0.32, animate: true)
              .animate(400.milliseconds, Curves.fastOutSlowIn),
        ),
      ),
    );
  }
}
