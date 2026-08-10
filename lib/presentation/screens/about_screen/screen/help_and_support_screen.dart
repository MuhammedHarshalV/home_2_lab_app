import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icon_infoware/controller/color_controller/color_controller.dart';
import 'package:icon_infoware/controller/help_support_controller/help_support_controller.dart';

import 'package:icon_infoware/core/themes/colors.dart';
import 'package:icon_infoware/presentation/screens/about_screen/widget/information_card.dart';
import 'package:icon_infoware/presentation/widgets/common_appbar.dart';

class HelpAndSupportScreen extends ConsumerWidget {
  const HelpAndSupportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorState = ref.watch(colorProvider);
    final helpAndSupportState = ref.watch(helpAndSupportProvider);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light, // icons = white
        statusBarBrightness: Brightness.dark, // for iOS
      ),
      child: SafeArea(
        top: false,

        child: Scaffold(
          backgroundColor: AppColors.appWhite,
          appBar: CommonAppbar(),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: helpAndSupportState.helpAndSupport == null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      helpAndSupportState.isLoading == true
                          ? Center(
                              child: CircularProgressIndicator(
                                color: colorState.primaryColor,
                              ),
                            )
                          : Column(
                              children: [
                                const Icon(
                                  Icons.support_agent_outlined,
                                  size: 70,
                                  color: Colors.grey,
                                ),
                                const SizedBox(height: 16),
                                const Text(
                                  "Unable to load Help & Support.",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 24),
                                  child: Text(
                                    "Please check your internet connection and try again.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 24),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    ref
                                        .read(helpAndSupportProvider.notifier)
                                        .helpSupportApi(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: colorState.primaryColor,
                                    foregroundColor:
                                        AppColors.appWhite, // Icon & text color
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 12,
                                    ),
                                  ),
                                  icon: const Icon(
                                    Icons.refresh,
                                    color: AppColors.appWhite,
                                  ),
                                  label: const Text(
                                    "Retry",
                                    style: TextStyle(
                                      color: AppColors.appWhite,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ],
                  )
                : SingleChildScrollView(
                    child: Column(
                      spacing: 10,
                      children: [
                        Text(
                          helpAndSupportState.helpAndSupport?.content ?? '',
                          textAlign: TextAlign.justify,
                        ),
                        ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) => InformationCard(
                            information: helpAndSupportState
                                .helpAndSupport!
                                .notifications![index],
                            count: index + 1,
                          ),
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 10),
                          itemCount:
                              helpAndSupportState
                                  .helpAndSupport
                                  ?.notifications
                                  ?.length ??
                              0,
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
