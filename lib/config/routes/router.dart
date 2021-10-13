import 'package:auto_route/auto_route.dart';
import 'package:refocus_app/core/presentation/pages/home_page.dart';
import 'package:refocus_app/core/presentation/pages/quickadd_page.dart';

export 'router.gr.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute<dynamic>(page: HomePage, initial: true, children: [
      AutoRoute<dynamic>(page: QuickAddPage),
    ]),
  ],
)
class $AppRouter {}
