import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icon_infoware/controller/color_controller/color_controller.dart';
import 'package:icon_infoware/controller/help_support_controller/help_support_controller.dart';
import 'package:icon_infoware/core/constants/app_constants.dart';
import 'package:icon_infoware/core/themes/colors.dart';
import 'package:icon_infoware/view/screens/about_screen/widget/information_card.dart';

class TermsAndConditionsScreen extends ConsumerWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorState = ref.watch(colorProvider);
    final helpAndSupportState = ref.watch(helpAndSupportProvider);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: AppColors.appWhite,
        statusBarIconBrightness: Brightness.light, // icons = white
        statusBarBrightness: Brightness.dark, // for iOS
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.appWhite,
          appBar: AppBar(
            toolbarHeight: 100,
            automaticallyImplyLeading: false,
            backgroundColor: AppColors.appWhite,
            elevation: 0,

            leading: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () => Navigator.pop(context),
                child: CircleAvatar(
                  backgroundColor: colorState.primaryColor.withValues(
                    alpha: 0.2,
                  ),
                  child: Icon(Icons.arrow_back, color: colorState.primaryColor),
                ),
              ),
            ),
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Image.file(
                    width: MediaQuery.of(context).size.width / 1.5,
                    fit: BoxFit.fill,
                    File(AppConstants.base64Image),
                  ),
                ),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: helpAndSupportState.termsAndConditions == null
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
                                  "Unable to load Terms & Conditions.",
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
                          helpAndSupportState.termsAndConditions?.content ?? '',
                          textAlign: TextAlign.justify,
                        ),
                        ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) => InformationCard(
                            information: helpAndSupportState
                                .termsAndConditions!
                                .notifications![index],
                            count: index + 1,
                          ),
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 10),
                          itemCount:
                              helpAndSupportState
                                  .termsAndConditions
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
