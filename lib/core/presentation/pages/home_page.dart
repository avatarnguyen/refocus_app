import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:refocus_app/core/presentation/pages/today_page.dart';
import 'package:refocus_app/core/util/ui/style_helpers.dart';
import 'package:refocus_app/core/util/ui/ui_helpers.dart';
import 'package:refocus_app/features/calendar/presentation/pages/calendar_page.dart';
import 'package:refocus_app/features/task/presentation/pages/project_page.dart';
import 'package:tale_drawer/tale_drawer.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

import 'package:get/get.dart';

import '../../../injection.dart';

const rightPaddingSize = 8.0;

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.amplifyConfigured}) : super(key: key);

  final bool amplifyConfigured;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController(
    initialPage: 1,
  );
  final GoogleSignIn _googleSignIn = getIt<GoogleSignIn>();
  final drawerController = TaleController();
  double rightPadding = rightPaddingSize;

  @override
  void initState() {
    super.initState();
    _googleSignIn.signInSilently();
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
          isBackdropInteractable: true,
          elevation: 16,
          cornerRadius: 24,
          shadowColor: Colors.black26,
          snapSpec: const SnapSpec(
            snap: true,
            // Set custom snapping points.
            initialSnap: 0.06,
            snappings: [0.06, 0.5, 1.0],
            positioning: SnapPositioning.relativeToAvailableSpace,
          ),
          headerBuilder: (context, state) => Container(
            height: 48.0,
            color: kcWarning300,
          ),
          builder: (context, state) => const ProjectPage(),
          body: Container(
            color: context.theme.backgroundColor,
            height: context.height,
            width: context.width,
            padding: EdgeInsets.only(right: rightPadding),
            child: PageView(
              allowImplicitScrolling: true,
              physics: const ClampingScrollPhysics(),
              controller: _pageController,
              onPageChanged: (int index) {
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
                widget.amplifyConfigured
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
