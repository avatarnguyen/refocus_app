import 'package:auto_route/auto_route.dart';
import 'package:refocus_app/core/presentation/pages/home_page.dart';
import 'package:refocus_app/core/presentation/pages/quickadd_page.dart';
import 'package:refocus_app/core/presentation/widgets/edit_page_widgets/edit_task_view.dart';
import 'package:refocus_app/features/calendar/presentation/pages/calendar_list_page.dart';

export 'router.gr.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute<dynamic>(page: HomePage, initial: true),
    AutoRoute<dynamic>(page: CalendarListPage),
    CustomRoute<dynamic>(
      page: QuickAddPage,
      fullscreenDialog: true,
      transitionsBuilder: TransitionsBuilders.fadeIn,
      durationInMilliseconds: 400,
    ),
  ],
)
class $AppRouter {}
