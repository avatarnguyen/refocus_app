import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:refocus_app/core/presentation/pages/app_loader_page.dart';
import 'package:refocus_app/core/presentation/pages/home_page.dart';
import 'package:refocus_app/features/auth/presentation/authentication/bloc/auth_bloc.dart';
import 'package:refocus_app/features/auth/presentation/login/pages/login_page.dart';
import 'package:refocus_app/features/auth/presentation/signup/pages/confirmation_page.dart';
import 'package:refocus_app/features/calendar/presentation/bloc/calendar/calendar_bloc.dart';
import 'package:refocus_app/features/calendar/presentation/bloc/calendar_list/calendar_list_bloc.dart';
import 'package:refocus_app/features/create/presentation/pages/create_page.dart';
import 'package:refocus_app/features/task/presentation/bloc/cubit/subtask_cubit.dart';
import 'package:refocus_app/features/task/presentation/bloc/project_bloc.dart';
import 'package:refocus_app/features/task/presentation/bloc/task_bloc.dart';
import 'package:refocus_app/injection.dart';

const kRouteAppLoader = 'app_loader';
const kRouteHome = 'home';
const kRouteLogin = 'login';
const kRouteConfirmation = 'confirmation';
const kRouteCreate = 'create';

class AppRouter {
  AppRouter(this.appContext);

  final BuildContext appContext;

  final _projectBloc = getIt<ProjectBloc>();

  late final router = GoRouter(
    routes: [
      GoRoute(
        name: kRouteAppLoader,
        path: '/',
        builder: (context, state) => BlocProvider.value(
          value: _projectBloc,
          child: const AppLoaderPage(),
        ),
      ),
      GoRoute(
        name: kRouteCreate,
        path: '/create',
        builder: (context, state) => BlocProvider.value(
          value: _projectBloc,
          child: const CreatePage(),
        ),
      ),
      GoRoute(
        name: kRouteConfirmation,
        path: '/confirmation',
        builder: (context, state) => const ConfirmationPage(),
      ),
      GoRoute(
        name: kRouteLogin,
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
    ],
    redirect: (state) {
      final _authState = appContext.read<AuthBloc>().state;
      final _isLogginIn = state.location == '/login';
      // print("Current Location: ${state.location}");

      // final loginloc = state.namedLocation('login');
      return _authState.maybeWhen(
        // authenticated: (_) => null,
        unauthenticated: () => _isLogginIn ? null : '/login',
        confirmationRequired: () => '/confirmation',
        orElse: () => null,
      );
    },
    refreshListenable: GoRouterRefreshStream(appContext.read<AuthBloc>().stream),
    debugLogDiagnostics: true,
    errorPageBuilder: (context, state) => MaterialPage(
      key: state.pageKey,
      child: Scaffold(
        body: Center(
          child: Text(state.error.toString()),
        ),
      ),
    ),
  );
}
