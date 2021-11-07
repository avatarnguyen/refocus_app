import 'package:auto_route/auto_route.dart';
import 'package:refocus_app/config/routes/custom_router.dart';
import 'package:refocus_app/core/presentation/pages/home_page.dart';
import 'package:refocus_app/core/presentation/pages/quickadd_page.dart';
import 'package:refocus_app/features/setting/presentation/pages/setting_page.dart';
import 'package:refocus_app/features/task/presentation/pages/create_project_page.dart';
import 'package:refocus_app/features/task/presentation/pages/task_page.dart';

export 'router.gr.dart';

// TODO: maybe change to @CustomAutoRouter to ios style modalsheet to work
@AdaptiveAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute<dynamic>(page: HomePage, initial: true, children: [
      AutoRoute<dynamic>(page: HomePageWidget, initial: true),
      CustomRoute<dynamic>(
        page: QuickAddPage,
        customRouteBuilder: modalSheetCustomRouteBuilder,
      ),
      CustomRoute<dynamic>(
        page: CreateProjectPage,
        customRouteBuilder: modalSheetCustomRouteBuilder,
      ),
      CustomRoute<dynamic>(
        page: TaskPage,
        customRouteBuilder: modalSheetCustomRouteBuilder,
      ),
      CustomRoute<dynamic>(
        page: SettingPage,
        customRouteBuilder: modalSheetCustomRouteBuilder,
      ),
    ]),
  ],
)
class $AppRouter {}
