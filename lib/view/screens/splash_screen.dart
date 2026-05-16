import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icon_infoware/core/themes/colors.dart';
import 'package:icon_infoware/view/screens/base_URL.dart';
import 'package:icon_infoware/view/screens/login_screen.dart';
import 'package:icon_infoware/view/screens/sign_in_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkInitialRoute();
  }

  //navigation setting
  Future<void> checkInitialRoute() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String? pin = prefs.getString('PIN');
    final String? baseUrl = prefs.getString('BaseURL');

    // update state
    //state = state.copyWith(pinNumber: pin ?? '', baseUrl: baseUrl ?? '');
    await Future.delayed(const Duration(seconds: 2)).then((value) {
      if ((pin ?? '').isNotEmpty && (baseUrl ?? '').isNotEmpty) {
        log('Stored PIN : $pin');
        log('Stored BaseUrl : $baseUrl');
        return Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
          (route) => false,
        );
      } else if (baseUrl != null && baseUrl.isNotEmpty) {
        log('Stored PIN : $pin');
        log('Stored BaseUrl : $baseUrl');
        return Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => SignInScreen()),
          (route) => false,
        );
      } else {
        log('Stored PIN : $pin');
        log('Stored BaseUrl : $baseUrl');
        return Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => BaseUrlScreen()),
          (route) => false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
