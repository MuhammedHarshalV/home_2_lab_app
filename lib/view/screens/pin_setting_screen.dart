import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:icon_infoware/controller/login_controller/login_controller.dart';
import 'package:icon_infoware/core/routes/app_route_names.dart';
import 'package:icon_infoware/core/themes/colors.dart';

import 'package:icon_infoware/view/widgets/otp_field.dart';

class PinSettingScreen extends ConsumerWidget {
  const PinSettingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    final pinState = ref.watch(loginProvider);
    final pinController = ref.read(loginProvider.notifier);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.appWhite,
        statusBarIconBrightness: Brightness.dark, // Android icons
        statusBarBrightness: Brightness.light,
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.appWhite,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Image.file(
                              width: MediaQuery.of(context).size.width / 1.5,
                              fit: BoxFit.fill,
                              File(pinState.imageBase64),
                            ),
                          ),
                          SizedBox(height: 10),
                          Center(
                            child: Text(
                              'Set a 4-Digit Password',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            '     Enter PIN',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 11,
                            ),
                          ),
                          OtpPinField(
                            pinController: pinState.pinOneController,
                            see: true,
                          ),
                          SizedBox(height: 10),
                          Text(
                            '     Confirm PIN',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 11,
                            ),
                          ),
                          OtpPinField(pinController: pinState.pinTwoController),
                          SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.appPrimaryColor,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 20,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                log(
                                  'pin one : ${pinState.pinOneController.text}',
                                );
                                log(
                                  'pin two : ${pinState.pinTwoController.text}',
                                );

                                if (pinState.pinOneController.text.isNotEmpty &&
                                    pinState.pinTwoController.text.isNotEmpty) {
                                  if (pinState.pinOneController.text ==
                                      pinState.pinTwoController.text) {
                                    pinController.storePIN(
                                      pin: pinState.pinOneController.text,
                                    );
                                    context.goNamed(
                                      AppRouteNames.loginScreen.name,
                                    );
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          backgroundColor: AppColors.appWhite,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          title: const Text(
                                            "PIN Mismatch",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          content: const Text(
                                            "Your two PINs are not the same.Please try again.",
                                          ),
                                        );
                                      },
                                    );
                                  }
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        backgroundColor: AppColors.appWhite,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        title: const Text(
                                          "Alert",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        content: const Text(
                                          "Fill Two PIN's Properly",
                                        ),
                                      );
                                    },
                                  );
                                }

                                // submit logic
                              },
                              child: pinState.isCheckBaseUrl == true
                                  ? CircularProgressIndicator(
                                      color: AppColors.appWhite,
                                    )
                                  : Text(
                                      "Login",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                if (!isKeyboardOpen) ...[
                  Center(
                    child: Text(
                      'powered by',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 10,
                      ),
                    ),
                  ),
                  Center(
                    child: Image.asset(
                      'asset/images/iconinfoware logo.png',
                      width: MediaQuery.of(context).size.width / 2,
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
