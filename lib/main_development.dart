// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';

import 'package:refocus_app/app/app.dart';
import 'package:refocus_app/app/app_bloc_observer.dart';

import 'injection_container.dart' as di;

void main() async {
  Bloc.observer = AppBlocObserver();
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runZonedGuarded(
    () => runApp(const App()),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
