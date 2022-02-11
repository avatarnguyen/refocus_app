import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:refocus_app/amplifyconfiguration.dart';
import 'package:refocus_app/core/presentation/pages/home_page.dart';
import 'package:refocus_app/core/util/helpers/logging.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:refocus_app/features/auth/presentation/authentication/bloc/auth_bloc.dart';
import 'package:refocus_app/features/calendar/presentation/bloc/calendar/calendar_bloc.dart';
import 'package:refocus_app/features/calendar/presentation/bloc/calendar_list/calendar_list_bloc.dart';
import 'package:refocus_app/features/task/presentation/bloc/cubit/subtask_cubit.dart';
import 'package:refocus_app/features/task/presentation/bloc/project_bloc.dart';
import 'package:refocus_app/features/task/presentation/bloc/task_bloc.dart';
import 'package:refocus_app/injection.dart';
import 'package:refocus_app/models/ModelProvider.dart';

class AppLoaderPage extends StatefulWidget {
  const AppLoaderPage({Key? key}) : super(key: key);

  @override
  State<AppLoaderPage> createState() => _AppLoaderPageState();
}

class _AppLoaderPageState extends State<AppLoaderPage> {
  final log = logger(AppLoaderPage);
  bool _amplifyConfigured = false;

  Future _configureAmplify() async {
    try {
      if (!Amplify.isConfigured) {
        await Amplify.addPlugins(
          [
            AmplifyAPI(),
            AmplifyDataStore(modelProvider: ModelProvider.instance),
            AmplifyAuthCognito(),
          ],
        );

        // Once Plugins are added, configure Amplify
        await Amplify.configure(amplifyconfig);
        // ignore: use_build_context_synchronously
        context.read<AuthBloc>().add(const AuthEvent.autoSignInAttempt());
      }
      setState(() {
        _amplifyConfigured = true;
      });
    } catch (e) {
      log.e(e);
    }
  }

  @override
  void initState() {
    _configureAmplify();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => _amplifyConfigured
      ? MultiBlocProvider(
          providers: [
            BlocProvider<ProjectBloc>(
              create: (_) => getIt<ProjectBloc>()..add(GetProjectEntriesEvent()),
            ), //..add(GetProjectEntriesEvent())),
            BlocProvider<TaskBloc>(
              create: (_) => getIt<TaskBloc>(),
            ),
            BlocProvider(
              create: (_) => getIt<SubtaskCubit>(),
            ),
            BlocProvider<CalendarListBloc>(
              create: (_) => getIt<CalendarListBloc>()..add(GetCalendarListEvent()),
            ),
            BlocProvider<CalendarBloc>(
              create: (_) => getIt<CalendarBloc>(),
            ),
          ],
          child: const HomePage(),
        )
      : const Scaffold(body: Center(child: progressIndicator));
}
