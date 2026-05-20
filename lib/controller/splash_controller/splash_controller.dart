import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icon_infoware/controller/splash_controller/splash_state.dart';

import 'package:shared_preferences/shared_preferences.dart';

enum SplashNavigationState { loading, login, signIn, baseUrl }

class SplashNotifierController extends StateNotifier<SplashState> {
  SplashNotifierController() : super(const SplashState()) {
    _initialize();
  }
  @override
  void dispose() {
    log(
      'Splash controller disposed---------------------------------------------------------',
    );
    super.dispose();
  }

  Future<void> _initialize() async {
    await Future.wait([checkInitialRoute()]);
  }

  Future<void> checkInitialRoute() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String? pin = prefs.getString('PIN');
    final String? baseUrl = prefs.getString('BaseURL');

    await Future.delayed(const Duration(seconds: 2)).then((value) {
      if ((pin ?? '').isNotEmpty && (baseUrl ?? '').isNotEmpty) {
        log('Stored PIN : $pin');
        log('Stored BaseUrl : $baseUrl');
        return state = state.copyWith(
          navigationScreen: SplashNavigationState.login,
        );
      } else if (baseUrl != null && baseUrl.isNotEmpty) {
        log('Stored PIN : $pin');
        log('Stored BaseUrl : $baseUrl');
        return state = state.copyWith(
          navigationScreen: SplashNavigationState.signIn,
        );
      } else {
        log('Stored PIN : $pin');
        log('Stored BaseUrl : $baseUrl');
        return state = state.copyWith(
          navigationScreen: SplashNavigationState.baseUrl,
        );
      }
    });
  }
}

final splashDisposeProvider =
    StateNotifierProvider<SplashNotifierController, SplashState>((ref) {
      return SplashNotifierController();
    });
final splashProvider =
    StateNotifierProvider<SplashNotifierController, SplashState>((ref) {
      return SplashNotifierController();
    });

final splashScreenProvider = Provider<SplashNavigationState>((ref) {
  return ref.watch(splashProvider).navigationScreen;
});
