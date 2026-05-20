import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:icon_infoware/controller/splash_controller/splash_controller.dart';

import 'package:icon_infoware/core/routes/app_route_names.dart';
import 'package:icon_infoware/core/themes/colors.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Listen to navigation state changes
    ref.listen<SplashNavigationState>(splashScreenProvider, (previous, next) {
      if (SplashNavigationState.baseUrl == next) {
        context.goNamed(
          AppRouteNames.baseUrlScreen.name,
        ); // Navigate to main app
      } else if (next == SplashNavigationState.login) {
        context.goNamed(AppRouteNames.loginScreen.name); // Navigate to login
      } else if (next == SplashNavigationState.signIn) {
        context.goNamed(AppRouteNames.signInScreen.name); // Navigate to login
      }
    });
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: AppColors.appWhite,
        statusBarIconBrightness: Brightness.light, // icons = white
        statusBarBrightness: Brightness.dark, // for iOS
      ),
      child: Scaffold(
        backgroundColor: AppColors.appWhite,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Lottie.asset(
                'asset/lottie/Medical_app.json',
                width: double.infinity,
                // height: 00,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
