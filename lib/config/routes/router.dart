import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:refocus_app/core/presentation/pages/app_loader_page.dart';
import 'package:refocus_app/core/presentation/pages/home_page.dart';
import 'package:refocus_app/features/auth/presentation/authentication/bloc/auth_bloc.dart';
import 'package:refocus_app/features/auth/presentation/login/pages/login_page.dart';
import 'package:refocus_app/injection.dart';

const kRouteAppLoader = 'app_loader';
const kRouteHome = 'home';
const kRouteLogin = 'login';

final goRouter = GoRouter(
  // navigatorBuilder: (context, state, child) {
  // },
  // initialLocation: '/home',
  routes: [
    GoRoute(
      name: kRouteAppLoader,
      path: '/',
      builder: (context, state) => const AppLoaderPage(),
    ),
    GoRoute(
      name: kRouteHome,
      path: '/home',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      name: kRouteLogin,
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
  ],
  redirect: (state) {
    final _authState = getIt<AuthBloc>().state;

    // final loginloc = state.namedLocation('login');
    return _authState.maybeWhen(
      authenticated: (_) => state.location,
      unauthenticated: () => '/login',
      orElse: () => null,
    );
  },
  refreshListenable: GoRouterRefreshStream(getIt<AuthBloc>().stream),
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

/* class AuthStateNotifier extends ChangeNotifier {
  AuthStateNotifier(AuthBloc bloc) {
   _authBlocStream  = bloc.stream.listen((event) {
      notifyListeners();
    });
  }

  late final StreamSubscription<AuthState> _authBlocStream;

  @override
  void dispose() {
    super.dispose();
    _authBlocStream.cancel();
  }
} */
