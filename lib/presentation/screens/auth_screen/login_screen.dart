import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:icon_infoware/controller/color_controller/color_controller.dart';
import 'package:icon_infoware/controller/login_controller/login_controller.dart';
import 'package:icon_infoware/controller/splash_controller/splash_controller.dart';
import 'package:icon_infoware/core/constants/app_constants.dart';
import 'package:icon_infoware/core/routes/app_route_names.dart';
import 'package:icon_infoware/core/themes/colors.dart';

import 'package:icon_infoware/presentation/widgets/otp_field.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    final pinState = ref.watch(loginProvider);
    final colorState = ref.watch(colorProvider);
    final loginController = ref.read(loginProvider.notifier);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, //  your red
        statusBarIconBrightness: Brightness.light, // icons = white
        statusBarBrightness: Brightness.dark, // for iOS
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.appWhite,
          body: Column(
            // spacing: 10,
            children: [
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    child: Column(
                      children: [
                        Center(
                          child: pinState.imageBase64.isEmpty
                              ? null
                              : Image.file(
                                  width:
                                      MediaQuery.of(context).size.width / 1.5,
                                  fit: BoxFit.fill,
                                  File(pinState.imageBase64),
                                ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Use 4-digit Password to Login',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                        SizedBox(height: 10),
                        OtpPinField(pinController: pinState.loginController),
                        SizedBox(height: 10),
                        InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          onTap: () async {
                            FocusScope.of(context).unfocus();

                            await Future.delayed(
                              const Duration(milliseconds: 100),
                            );

                            if (!context.mounted) return;

                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                backgroundColor: AppColors.appWhite,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      Icons.warning_outlined,
                                      color: AppColors.appBlack,
                                      size: 30,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      "Contact Icon support",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                                content: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,

                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "+91 9544596668",
                                          textAlign: TextAlign.center,
                                        ),
                                        Spacer(),
                                        InkWell(
                                          splashColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          onTap: () async {
                                            final Uri url = Uri(
                                              scheme: 'tel',
                                              path: '+919544596668',
                                            );

                                            if (await canLaunchUrl(url)) {
                                              await launchUrl(
                                                url,
                                              ); // opens dialer safely
                                            } else {
                                              log('Could not launch dialer');
                                            }
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.blueAccent,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                8.0,
                                              ),
                                              child: Icon(
                                                Icons.call_outlined,
                                                size: 15,
                                                color: AppColors.appWhite,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Text(
                                          "+91 9544596661",
                                          textAlign: TextAlign.center,
                                        ),

                                        Spacer(),
                                        InkWell(
                                          splashColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          onTap: () async {
                                            final Uri url = Uri(
                                              scheme: 'tel',
                                              path: '+919544596661',
                                            );

                                            if (await canLaunchUrl(url)) {
                                              await launchUrl(
                                                url,
                                              ); // opens dialer safely
                                            } else {
                                              log('Could not launch dialer');
                                            }
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.blueAccent,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                8.0,
                                              ),
                                              child: Icon(
                                                Icons.call_outlined,
                                                size: 15,
                                                color: AppColors.appWhite,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                actionsPadding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 15,
                                ),
                              ),
                            );
                          },
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 10,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: colorState.primaryColor,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 20,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () async {
                                // submit logic
                                if (pinState.loginController.text.isNotEmpty) {
                                  if (pinState.loginController.text ==
                                      AppConstants.pin) {
                                    final bool response = await loginController
                                        .yearIdFetching(context: context);
                                    if (response == true) {
                                      context.goNamed(
                                        AppRouteNames.bottomNavScreen.name,
                                      );
                                      ref.invalidate(loginProvider);
                                      ref.invalidate(splashDisposeProvider);
                                    }

                                    log(
                                      '${pinState.loginController.text} : ${pinState.pinNumber}',
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
                                            "This PIN does not match your current PIN. Please try again.",
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
                                          "Please fill the PIN",
                                        ),
                                      );
                                    },
                                  );
                                }
                              },
                              child: pinState.isYearLoading == true
                                  ? SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: AppColors.appWhite,
                                        ),
                                      ),
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
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 10),
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
    );
  }
}
