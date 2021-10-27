// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter_test/flutter_test.dart';
import 'package:refocus_app/app/app.dart';
import 'package:refocus_app/features/calendar/presentation/pages/calendar_page.dart';
import 'package:refocus_app/injection.dart';

//! Test not pass through, following message was thrown
// TODO: Set up getit test environment:
// https://resocoder.com/2020/02/04/injectable-flutter-dart-equivalent-to-dagger-angular-dependency-injection/#t-1628158171317
/* 
The following assertion was thrown building
RawGestureDetector-[LabeledGlobalKey<RawGestureDetectorState>#2958e](state:
RawGestureDetectorState#1ced1(gestures: <none>, behavior: opaque)):
Object/factory with  type GcalBloc is not registered inside GetIt.
(Did you accidentally do GetIt sl=GetIt.instance(); instead of GetIt sl=GetIt.instance;
Did you forget to register it?)
'package:get_it/get_it_impl.dart':
Failed assertion: line 372 pos 7: 'instanceFactory != null'

The relevant error-causing widget was:
  SingleChildScrollView
  file:///Users/anhnguyen/flutter/.pub-cache/hosted/pub.dartlang.org/styled_widget-0.3.1+2/lib/src/extensions/widget_extension.dart:952:7

When the exception was thrown, this was the stack:
#2      _GetItImplementation._findFactoryByNameAndType (package:get_it/get_it_impl.dart:372:7)
#3      _GetItImplementation.get (package:get_it/get_it_impl.dart:393:29)
#4      _GetItImplementation.call (package:get_it/get_it_impl.dart:430:12)
*/

void main() {
  group('App', () {
    testWidgets('renders CalendarPage', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(CalendarPage), findsOneWidget);
    });
  });
}
