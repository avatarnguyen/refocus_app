import 'dart:async';

import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:refocus_app/core/core.dart';
import 'package:refocus_app/core/util/helpers/logging.dart';
import 'package:refocus_app/core/util/ui/theme.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:refocus_app/features/calendar/presentation/bloc/calendar_list/calendar_list_bloc.dart';
import 'package:refocus_app/features/calendar/presentation/pages/calendar_page.dart';
import 'package:refocus_app/features/task/presentation/bloc/project_bloc.dart';
import 'package:refocus_app/features/today/presentation/pages/today_page.dart';
import 'package:refocus_app/injection.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart' as menu;

// const rightPaddingSize = 8.0;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final log = logger(HomePage);
  final GlobalKey<menu.SideMenuState> _sideMenuKey = GlobalKey<menu.SideMenuState>();
  final PageController _pageController = PageController(
    initialPage: 1,
  );
  final GoogleSignIn _googleSignIn = getIt<GoogleSignIn>();

  bool isSignedInToCalendar = false;
  @override
  void initState() {
    super.initState();

    _attemptSignInGoogle();
    context.read<CalendarListBloc>().add(
          GetCalendarListEvent(),
        );
    context.read<ProjectBloc>().add(const ProjectEvent.get());
  }

  Future<void> _attemptSignInGoogle() async {
    // Sign in google calendar api
    final _result = await _googleSignIn.signInSilently(reAuthenticate: true);
    log.d(_result);
    setState(() {
      isSignedInToCalendar = true;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _state = _sideMenuKey.currentState;
    final _isMenuOpen = _state?.isOpened == true;
    return Theme(
      data: materialThemeData,
      child: menu.SideMenu(
        key: _sideMenuKey,
        inverse: true,
        maxMenuWidth: 250,
        menu: SingleChildScrollView(
          padding: const EdgeInsets.only(top: kPaddingMedium),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildMenuItem(
                context,
                title: 'Dashboard',
                onTap: () {},
              ),
              _buildMenuItem(
                context,
                title: 'Projects',
                onTap: () {},
              ),
              _buildMenuItem(
                context,
                title: 'Settings',
                onTap: () {},
              ),
            ],
          ),
        ),
        type: menu.SideMenuType.slideNRotate,
        child: Scaffold(
          floatingActionButton: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FloatingActionButton.small(
                child: _isMenuOpen ? const Icon(Icons.arrow_forward_ios) : const Icon(Icons.menu),
                onPressed: () {
                  if (_isMenuOpen) {
                    setState(() {
                      _state!.closeSideMenu();
                    });
                  } else {
                    setState(() {
                      _state?.openSideMenu();
                    });
                  }
                },
              ),
              verticalSpaceTiny,
              if (_isMenuOpen)
                verticalSpaceLarge
              else
                FloatingActionButton.small(
                  backgroundColor: Colors.blue,
                  child: const Icon(Icons.add),
                  onPressed: () {
                    context.goNamed(kRouteCreate);
                  },
                ),
            ],
          ),
          body: PageView(
            controller: _pageController,
            scrollDirection: Axis.vertical,
            children: [
              if (isSignedInToCalendar)
                const CalendarPage()
              else
                const Center(
                  child: progressIndicator,
                ),
              const TodayPage(),
              Container(
                height: 200,
                color: kcPrimary500,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required String title,
    Function()? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        title,
        style: kHeadline3StyleRegular,
      ).padding(vertical: kPaddingXXSmall),
    );
  }

  /* Widget _drawerBody(BuildContext context) {
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
          buildWhen: (oldState, newState) => oldState.isExpanded != newState.isExpanded,
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
              // CalendarPage(changePage: switchToPageView),
              // TodayPage(changePage: switchToPageView),
            ],
          ),
        ),
      ),
    );
  } */

}
