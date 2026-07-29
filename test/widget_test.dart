import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:icon_infoware/main.dart';
import 'package:icon_infoware/presentation/screens/auth_screen/splash_screen.dart';

void main() {
  setUp(() {
    // Set up mock values for SharedPreferences before each test
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('App renders splash screen initially', (
    WidgetTester tester,
  ) async {
    // Set a realistic presentationport size to prevent Lottie layout overflow in tests
    tester.view.physicalSize = const Size(1080, 1920);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    // Build our app and trigger a frame.
    await tester.pumpWidget(const ProviderScope(child: MyApp()));

    // Verify that the SplashScreen is rendered.
    expect(find.byType(SplashScreen), findsOneWidget);

    // Allow the 2-second splash timer to fire and the router to process the navigation
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();
  });
}
