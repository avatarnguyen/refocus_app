import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:refocus_app/amplifyconfiguration.dart';
import 'package:refocus_app/core/presentation/helper/page_stream.dart';
import 'package:refocus_app/core/presentation/pages/today_page.dart';
import 'package:refocus_app/core/presentation/widgets/slider_header_widget.dart';
import 'package:refocus_app/core/util/helpers/logging.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';
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
          create: (context) => getIt<ProjectBloc>(),
        ),
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
  final GoogleSignIn _googleSignIn = getIt<GoogleSignIn>();

  int _currentPage = 1;

  final log = logger(HomePage);
  bool amplifyConfigured = false;
  // bool _drawerClosed = true;

  @override
  void initState() {
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
          initialSnap: 0.09,
          snappings: [0.09, 0.5, 1.0],
        ),
        minHeight: context.height / 2,
        headerBuilder: (context, state) => const SlidingHeaderWidget(),
        builder: (context, state) => amplifyConfigured
            ? BlocProvider<ProjectBloc>.value(
                value: BlocProvider.of<ProjectBloc>(context),
                child: const ProjectPage(),
              )
            : const SizedBox(),
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
                const CalendarPage(),
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
