import 'package:icon_infoware/controller/splash_controller/splash_controller.dart';

class SplashState {
  final SplashNavigationState navigationScreen;

  const SplashState({this.navigationScreen = SplashNavigationState.loading});

  SplashState copyWith({SplashNavigationState? navigationScreen}) {
    return SplashState(
      navigationScreen: navigationScreen ?? this.navigationScreen,
    );
  }
}
