enum AppRouteNames {
  splashScreen(route: '/', name: 'splash'),
  baseUrlScreen(route: '/login', name: 'login'),
  pinSettingScreen(route: '/pinSettingScreen', name: 'pinSettingScreen'),
  loginScreen(route: '/loginScreen', name: 'loginScreen'),
  signInScreen(route: '/signInScreen', name: 'signInScreen'),
  bottomNavScreen(route: '/bottomNavScreen', name: 'bottomNavScreen'),
  spotBillingScreen(route: '/spotBillingScreen', name: 'spotBillingScreen'),
  menuScreen(route: '/menuScreen', name: 'menuScreen'),
  printBillScreen(route: '/printBillScreen', name: 'printBillScreen'),
  printCashCloserScreenroute(
    route: '/printCashCloserScreenroute',
    name: 'printCashCloserScreenroute',
  ),
  paymentCompletionScreen(
    route: '/paymentCompletionScreen',
    name: 'paymentCompletionScreen',
  ),

  editSpotBillingScreen(
    route: '/editSpotBillingScreen',
    name: 'editSpotBillingScreen',
  ),
  allInvoiceScreen(route: '/allInvoiceScreen', name: 'allInvoiceScreen'),
  spotBillingTestAddScreen(
    route: '/spotBillingTestAddScreen',
    name: 'spotBillingTestAddScreen',
  ),
  homeScreen(route: '/homeScreen', name: 'homeScreen');

  final String route;
  final String name;

  const AppRouteNames({required this.route, required this.name});
}
