import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:icon_infoware/controller/splash_controller/splash_state.dart';
import 'package:icon_infoware/core/constants/app_constance.dart';

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
    final String? upiId = prefs.getString('upiId');
    if ((upiId ?? '').isNotEmpty && (upiId != null)) {
      AppConstants.upiPaymentId = upiId;

      log('upiid : $upiId');
    }

    await Future.delayed(const Duration(seconds: 2)).then((value) async {
      if ((pin ?? '').isNotEmpty && (baseUrl ?? '').isNotEmpty) {
        log('Stored PIN : $pin');
        log('Stored BaseUrl : $baseUrl');
        final box = await Hive.openBox('addressBox');
        log(box.keys.toString());
        log(box.values.toString());
        log(box.toMap().toString());
        AppConstants.name = box.get('name');
        AppConstants.address = box.get('address');
        AppConstants.webUrl = box.get('webUrl');
        AppConstants.phoneNumber = box.get('phoneNumber');
        AppConstants.devCode = box.get('devCode');
        AppConstants.tagLine = box.get('tagLine');
        AppConstants.qrUrl = box.get('qrUrl');
        log('''
Name        : ${AppConstants.name}
Address     : ${AppConstants.address}
Web URL     : ${AppConstants.webUrl}
Phone Number: ${AppConstants.phoneNumber}
Dev Code    : ${AppConstants.devCode}
Tag Line    : ${AppConstants.tagLine}
QR URL      : ${AppConstants.qrUrl}
''');
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
