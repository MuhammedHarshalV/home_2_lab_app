import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icon_infoware/controller/bottom_nav_screen/bottom_nav_controller.dart';
import 'package:icon_infoware/core/themes/colors.dart';
import 'package:icon_infoware/view/screens/home_screen.dart';
import 'package:icon_infoware/view/screens/menu_screen.dart';
import 'package:icon_infoware/view/screens/spot_billing_screen/screen/spot_billing_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class BottomNavScreen extends ConsumerWidget {
  const BottomNavScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(tabControllerProvider);
    final bottomNavState = ref.watch(bottomNavProvider);
    final bottomNavNotifier = ref.read(bottomNavProvider.notifier);

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (bottomNavState.currentIndex == 0) {
          // 🔥 Exit app
          SystemNavigator.pop();
        } else {
          // 🔥 Go to Home tab
          controller.jumpToTab(0);
          bottomNavNotifier.setIndex(0);
        }
      },
      child: PersistentTabView(
        margin: EdgeInsets.only(bottom: 15, right: 50, left: 50),
        context,
        controller: controller,
        screens: _buildScreens(),
        items: _navBarsItems(context),
        navBarStyle: NavBarStyle.style15,

        confineToSafeArea: true,
        backgroundColor: AppColors.appWhite,
        // handleAndroidBackButtonPress: true,
        handleAndroidBackButtonPress: false,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        onItemSelected: (index) {
          if (index == 1) {
            bottomNavNotifier.setIndex(0);

            controller.jumpToTab(0);
            PersistentNavBarNavigator.pushNewScreen(
              context,
              screen: SpotBillingScreen(),
              withNavBar: false, // 🔥 hide bottom nav
              pageTransitionAnimation: PageTransitionAnimation.cupertino,
            );
          } else {
            bottomNavNotifier.setIndex(index);
          }
        },
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.appWhite, width: .5),
          colorBehindNavBar: Theme.of(
            context,
          ).scaffoldBackgroundColor.withOpacity(0.5),
        ),
      ),
    );
  }

  List<Widget> _buildScreens() {
    return [HomeScreen(), SizedBox(), MenuScreen()];
  }

  List<PersistentBottomNavBarItem> _navBarsItems(BuildContext context) {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        inactiveIcon: Icon(Icons.home),
        title: "Home",
        textStyle: TextStyle(fontWeight: FontWeight.w500),
        activeColorPrimary: AppColors.appPrimaryColor,
        inactiveColorPrimary: AppColors.appBlack,
      ),
      PersistentBottomNavBarItem(
        title: 'Spot Billing',
        icon: Icon(Icons.add_box_outlined),
        textStyle: TextStyle(fontWeight: FontWeight.w500),
        inactiveIcon: Icon(Icons.add_box_outlined, color: AppColors.appBlack),
        activeColorPrimary: AppColors.appLightGreen,
        inactiveColorPrimary: AppColors.appBlack,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.menu_sharp),
        inactiveIcon: Icon(Icons.menu_sharp),

        title: 'Menu',
        textStyle: TextStyle(fontWeight: FontWeight.w500),
        activeColorPrimary: AppColors.appPrimaryColor,
        inactiveColorPrimary: AppColors.appBlack,
      ),
    ];
  }
}
