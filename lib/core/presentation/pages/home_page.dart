import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:refocus_app/constants/routes_name.dart';
import 'package:refocus_app/core/presentation/pages/today_page.dart';
import 'package:refocus_app/core/util/helpers/logging.dart';
import 'package:refocus_app/core/util/ui/style_helpers.dart';
import 'package:refocus_app/core/util/ui/ui_helpers.dart';
import 'package:refocus_app/features/calendar/presentation/pages/calendar_page.dart';
import 'package:refocus_app/features/task/presentation/pages/project_page.dart';
import 'package:refocus_app/models/ModelProvider.dart';
import 'package:tale_drawer/tale_drawer.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
import 'package:styled_widget/styled_widget.dart';

import 'package:get/get.dart';

import '../../../amplifyconfiguration.dart';
import '../../../injection.dart';

const rightPaddingSize = 8.0;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  // final bool amplifyConfigured;

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
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () => Get.toNamed(rAddNewPage),
          backgroundColor: kcPrimary500,
          child: const Icon(Icons.add),
        ),
        body: SlidingSheet(
          color: kcLightBackground,
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
            padding: const EdgeInsets.only(top: 8.0),
            height: 32.0,
            // color: Colors.transparent,
            child: [
              Container(
                height: 8.0,
                width: 72.0,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  color: Colors.grey[300],
                ),
              )
            ].toRow(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
          ),
          builder: (context, state) =>
              amplifyConfigured ? const ProjectPage() : Container(),
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
