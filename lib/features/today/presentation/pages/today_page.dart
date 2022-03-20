import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:intl/intl.dart';
import 'package:refocus_app/core/util/helpers/logging.dart' as custom_log;
import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:refocus_app/features/today/presentation/bloc/today/today_bloc.dart';
import 'package:refocus_app/injection.dart';

class TodayPage extends HookWidget {
  const TodayPage({Key? key}) : super(key: key);

  String returnDate(DateTime date) {
    return DateFormat.yMMMMEEEEd().format(date);
  }

  void _onScroll(ValueNotifier<bool> isAtTop, ScrollController controller) {
    if (controller.offset > 37) {
      if (!isAtTop.value) {
        isAtTop.value = true;
      }
    } else {
      if (isAtTop.value) {
        isAtTop.value = false;
      }
    }
  }

  ValueNotifier<T> useLoggedState<T>(T initialData) {
    // First, call the useState hook. It will create a ValueNotifier for you that
    // rebuilds the Widget whenever the value changes.
    final result = useState<T>(initialData);

    // Next, call the useValueChanged hook to print the state whenever it changes
    useValueChanged<T, void>(result.value, (_, __) {
      print(result.value);
    });

    return result;
  }

  @override
  Widget build(BuildContext context) {
    final log = custom_log.logger(TodayPage);
    final _sController = useScrollController();

    // final showMonthView = useState(false);
    final isAtTop = useState(false);
    final _dragPosition = useState(0.0);

    useEffect(() {
      _sController.addListener(() {
        _onScroll(isAtTop, _sController);
      });
      return () => _sController.removeListener(() {
            _onScroll(isAtTop, _sController);
          });
    }, []);
    final today = DateTime.now();

    return MultiBlocProvider(
      providers: [
        BlocProvider<TodayBloc>(
          create: (context) => getIt<TodayBloc>()..add(GetCurrentDayEntries(today)),
        ),
        // BlocProvider(create: (context) => getIt<TomorrowBloc>()),
        // BlocProvider(create: (context) => getIt<UpcomingCubit>()),
      ],
      child: SafeArea(
        child: Container(
          color: kcTertiary300,
          height: 800,
          width: screenWidth(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _getGreeting(),
                overflow: TextOverflow.clip,
                maxLines: 2,
                softWrap: true,
                textScaleFactor: context.textScaleFactor,
                style: context.h3,
              ).padding(right: 40),
              PlatformText('Task test example'),
              PlatformText('Task test example'),
              PlatformText('Task test example'),
              verticalSpaceLarge,
            ],
          ),
        ),
      ),
      /* CupertinoPageScaffold(
        child: NestedScrollView(
          controller: _sController,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            CupertinoSliverNavigationBar(
              border: null,
              backgroundColor: kcLightBackground,
              padding: const EdgeInsetsDirectional.all(8),
              stretch: true,
              largeTitle: Text(
                _getGreeting(),
              ),
              leading: CupertinoButton(
                padding: EdgeInsets.zero,
                child: const Icon(CupertinoIcons.calendar),
                onPressed: () {},
              ),
              trailing: CupertinoButton(
                padding: EdgeInsets.zero,
                child: const Icon(Icons.settings_outlined),
                onPressed: () {
                  // context.navigateTo(const SettingRoute());
                },
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: PersistentHeaderDelegate(
                returnDate(today),
                minSize: 30,
                maxSize: 30,
              ),
            ),
          ],
          body: const TodayListWidget(),
        ).parent(todayPageParent),
      ), */
    );
  }

  String _getGreeting() {
    final _currentHour = DateTime.now().hour;
    if (_currentHour > 11 && _currentHour < 18) {
      return 'Good Afternoon!';
    } else if (_currentHour > 5 && _currentHour < 12) {
      return 'Good Morning!';
    } else if (_currentHour > 17 && _currentHour < 22) {
      return 'Good Evening!';
    } else {
      return 'Good Night!';
    }
  }
}
