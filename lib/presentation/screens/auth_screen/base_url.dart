import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icon_infoware/controller/color_controller/color_controller.dart';
import 'package:icon_infoware/controller/login_controller/login_controller.dart';

import 'package:icon_infoware/core/themes/colors.dart';

import 'package:icon_infoware/presentation/widgets/type_text_form_field.dart';

class BaseUrlScreen extends ConsumerWidget {
  const BaseUrlScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signInState = ref.watch(loginProvider);
    final signInController = ref.read(loginProvider.notifier);
    final colorState = ref.watch(colorProvider);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.appWhite,
        statusBarIconBrightness: Brightness.dark, // Android icons
        statusBarBrightness: Brightness.light,
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.appWhite,
          body: Form(
            key: signInState.baseUrlFormKey,
            autovalidateMode: signInState.isSubmitted
                ? AutovalidateMode.onUserInteraction
                : AutovalidateMode.disabled,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Image.asset(
                      'asset/images/iconinfoware logo.png',
                      width: MediaQuery.of(context).size.width / 1.2,

                      fit: BoxFit.fill,
                    ),
                  ),
                  // SizedBox(height: 7),
                  TypeTextFormField(
                    hintText: 'BaseURL',
                    textController: signInState.baseUrlController,
                    isPreffix: false,
                  ),
                  //  TopText(heading: 'Branch ID'),
                  // SizedBox(height: 7),
                  TypeTextFormField(
                    hintText: 'Branch ID',
                    textController: signInState.branchIDController,
                    isPreffix: false,
                  ),
                  SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorState.primaryColor,
                        padding: const EdgeInsets.symmetric(
                          //vertical: 10,
                          horizontal: 20,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () async {
                        signInState.baseUrlFormKey.currentState!.validate();
                        log(
                          signInState.baseUrlFormKey.currentState!
                              .validate()
                              .toString(),
                        );
                        signInController.updateState(isSubmitted: true);

                        if (signInState.baseUrlController.text.isNotEmpty &&
                            signInState.branchIDController.text.isNotEmpty) {
                          log(
                            'BaseURL : ${signInState.baseUrlController.text}',
                          );
                          log(
                            'Branch ID : ${signInState.branchIDController.text}',
                          );
                          if (signInState.baseUrlController.text.isNotEmpty) {
                            await signInController.baseUrlAndBranchcheck(
                              context: context,
                              baseUrl: signInState.baseUrlController.text,
                              branchID: signInState.branchIDController.text,
                            );
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  backgroundColor: AppColors.appWhite,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  title: Center(
                                    child: Text(
                                      "Alert",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  content: const Text(
                                    "Identified as New Device,Please contact Software Support Team\nwww.iconinfoware.com it will take few minutes for configuration Please wait...",
                                  ),
                                );
                              },
                            );
                          }
                        }
                        // submit logic
                      },
                      child: signInState.isCheckBaseUrl == true
                          ? CircularProgressIndicator(color: AppColors.appWhite)
                          : Text(
                              "Apply",
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
      ),
    );
  }
}
