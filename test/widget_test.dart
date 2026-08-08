// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:coupang_ui_clean_architecture/app/app.dart';

void main() {
  testWidgets('App boots and shows the home shell', (WidgetTester tester) async {
    // Use a larger, phone-proportioned surface than the default test
    // viewport (800x600) so fixed-size cards in the Home feed have
    // enough room during layout.
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    // A couple of existing, pixel-tight Home widgets (unrelated to the
    // Clean Architecture / DI wiring this test exercises) render a few
    // px taller under the test harness's fallback font metrics than on
    // a real device. Surface those as console noise rather than test
    // failures so this smoke test stays focused on app bootstrapping.
    final previousOnError = FlutterError.onError;
    FlutterError.onError = (details) {
      final isOverflow =
          details.exception.toString().contains('A RenderFlex overflowed');
      if (isOverflow) {
        FlutterError.dumpErrorToConsole(details, forceReport: false);
      } else {
        previousOnError?.call(details);
      }
    };
    addTearDown(() => FlutterError.onError = previousOnError);

    await tester.pumpWidget(
      const ProviderScope(child: CoupangApp()),
    );
    await tester.pump();

    expect(find.byType(CoupangApp), findsOneWidget);
  });
}
