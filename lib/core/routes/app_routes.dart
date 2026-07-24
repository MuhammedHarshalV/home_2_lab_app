import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icon_infoware/core/routes/app_route_names.dart';
import 'package:icon_infoware/models/patient_bill_syncing_model/patient_bill_syncing_model.dart';
import 'package:icon_infoware/view/screens/about_screen/screen/help_and_support_screen.dart';
import 'package:icon_infoware/view/screens/about_screen/screen/privacy_policy_screen.dart';
import 'package:icon_infoware/view/screens/about_screen/screen/terms_and_conditions_screen.dart';
import 'package:icon_infoware/view/screens/all_invoices_screen/screen/all_invoice_screen.dart';

import 'package:icon_infoware/view/screens/base_url.dart';
import 'package:icon_infoware/view/screens/bottom_nav_screen.dart';
import 'package:icon_infoware/view/screens/edit_spot_billing_screen.dart/edit_spot_billing_screen.dart';
import 'package:icon_infoware/view/screens/home_screen/screens/home_screen.dart';
import 'package:icon_infoware/view/screens/login_screen.dart';
import 'package:icon_infoware/view/screens/menu_screen/screen/menu_screen.dart';
import 'package:icon_infoware/view/screens/payment_completion_screen/screen/payment_completion_screen.dart';
import 'package:icon_infoware/view/screens/pin_setting_screen.dart';
import 'package:icon_infoware/view/screens/print_bill_details_screen/screen/print_bill_details_screen.dart';
import 'package:icon_infoware/view/screens/print_cash_closer_screen/screen/print_cash_closer_screen.dart';
import 'package:icon_infoware/view/screens/sign_in_screen.dart';
import 'package:icon_infoware/view/screens/splash_screen.dart';
import 'package:icon_infoware/view/screens/spot_billing_screen/screen/spot_billing_screen.dart';
import 'package:icon_infoware/view/screens/spot_billing_test_add_screen/screen/spot_billing_test_add_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: AppRouteNames.splashScreen.route,
  debugLogDiagnostics: true,
  routes: <RouteBase>[
    // Splash Screen
    GoRoute(
      path: AppRouteNames.splashScreen.route,
      name: AppRouteNames.splashScreen.name,
      builder: (BuildContext context, GoRouterState state) {
        return const SplashScreen();
      },
    ),

    //authentication routes
    GoRoute(
      path: AppRouteNames.baseUrlScreen.route,
      name: AppRouteNames.baseUrlScreen.name,
      builder: (BuildContext context, GoRouterState state) {
        return const BaseUrlScreen();
      },
    ),
    GoRoute(
      path: AppRouteNames.pinSettingScreen.route,
      name: AppRouteNames.pinSettingScreen.name,
      builder: (BuildContext context, GoRouterState state) {
        return const PinSettingScreen();
      },
    ),
    GoRoute(
      path: AppRouteNames.loginScreen.route,
      name: AppRouteNames.loginScreen.name,
      builder: (BuildContext context, GoRouterState state) {
        return const LoginScreen();
      },
    ),
    GoRoute(
      path: AppRouteNames.signInScreen.route,
      name: AppRouteNames.signInScreen.name,
      builder: (BuildContext context, GoRouterState state) {
        return const SignInScreen();
      },
    ),

    //bottom navigation screens
    GoRoute(
      path: AppRouteNames.bottomNavScreen.route,
      name: AppRouteNames.bottomNavScreen.name,
      builder: (BuildContext context, GoRouterState state) {
        return const BottomNavScreen();
      },
    ),
    GoRoute(
      path: AppRouteNames.homeScreen.route,
      name: AppRouteNames.homeScreen.name,
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
    ),
    GoRoute(
      path: AppRouteNames.spotBillingScreen.route,
      name: AppRouteNames.spotBillingScreen.name,
      builder: (BuildContext context, GoRouterState state) {
        return SpotBillingScreen();
      },
    ),
    GoRoute(
      path: AppRouteNames.menuScreen.route,
      name: AppRouteNames.menuScreen.name,
      builder: (BuildContext context, GoRouterState state) {
        return const MenuScreen();
      },
    ),
    GoRoute(
      path: AppRouteNames.printBillScreen.route,
      name: AppRouteNames.printBillScreen.name,
      builder: (BuildContext context, GoRouterState state) {
        return const PrintBillDetailsScreen();
      },
    ),
    GoRoute(
      path: AppRouteNames.helpAndSupportScreen.route,
      name: AppRouteNames.helpAndSupportScreen.name,
      builder: (BuildContext context, GoRouterState state) {
        return const HelpAndSupportScreen();
      },
    ),
    GoRoute(
      path: AppRouteNames.termsAndConditionsScreen.route,
      name: AppRouteNames.termsAndConditionsScreen.name,
      builder: (BuildContext context, GoRouterState state) {
        return const TermsAndConditionsScreen();
      },
    ),
    GoRoute(
      path: AppRouteNames.privacyPolicyScreen.route,
      name: AppRouteNames.privacyPolicyScreen.name,
      builder: (BuildContext context, GoRouterState state) {
        return const PrivacyPolicyScreen();
      },
    ),
    GoRoute(
      path: AppRouteNames.allInvoiceScreen.route,
      name: AppRouteNames.allInvoiceScreen.name,
      builder: (context, state) {
        final details = state.extra as List<PatientHiveModel>;

        return AllInvoiceScreen(details: details);
      },
    ),
    GoRoute(
      path: AppRouteNames.printCashCloserScreenroute.route,
      name: AppRouteNames.printCashCloserScreenroute.name,
      builder: (BuildContext context, GoRouterState state) {
        return const PrintCashCloserScreen();
      },
    ),
    GoRoute(
      path: AppRouteNames.spotBillingTestAddScreen.route,
      name: AppRouteNames.spotBillingTestAddScreen.name,
      builder: (BuildContext context, GoRouterState state) {
        final int? index = state.extra as int?;

        return SpotBillingTestAddScreen(hiveIndex: index);
      },
    ),
    GoRoute(
      path: '${AppRouteNames.editSpotBillingScreen.route}/:index',
      name: AppRouteNames.editSpotBillingScreen.name,
      builder: (BuildContext context, GoRouterState state) {
        final index = int.parse(state.pathParameters['index']!);

        return EditSpotBillingScreen(index: index);
      },
    ),
    GoRoute(
      path: AppRouteNames.paymentCompletionScreen.route,
      name: AppRouteNames.paymentCompletionScreen.name,
      builder: (BuildContext context, GoRouterState state) {
        final int index = state.extra as int;

        return PaymentCompletionScreen(index: index);
      },
    ),
  ],

  // Error page
  errorBuilder: (context, state) {
    return Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48),
            const SizedBox(height: 16),
            Text('Page not found: ${state.uri}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go(AppRouteNames.splashScreen.route),
              child: const Text('Go to Home'),
            ),
          ],
        ),
      ),
    );
  },
);
