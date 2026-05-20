import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icon_infoware/controller/login_controller/login_controller.dart';

import 'package:icon_infoware/core/themes/colors.dart';

import 'package:icon_infoware/view/widgets/type_text_form_field.dart';

class SignInScreen extends ConsumerWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final TextEditingController usernameController = TextEditingController();
    // final TextEditingController passwordController = TextEditingController();
    final signInState = ref.watch(loginProvider);
    final signInController = ref.read(loginProvider.notifier);
    final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

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
            key: signInState.formKey,
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
                  // Spacer(),
                  Expanded(
                    child: Center(
                      child: SingleChildScrollView(
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: Image.file(
                                width: MediaQuery.of(context).size.width / 1.5,
                                fit: BoxFit.fill,
                                File(signInState.imageBase64),
                              ),
                            ),
                            SizedBox(height: 7),
                            Center(
                              child: Text(
                                'Sign in to continue',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            // TopText(heading: 'Username'),
                            TypeTextFormField(
                              hintText: 'Username',
                              textController: signInState.usernameController,
                              isPreffix: true,
                            ),
                            // TopText(heading: 'Password'),
                            SizedBox(height: 10),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextFormField(
                                obscureText: signInState.passwordSee == true
                                    ? false
                                    : true,
                                obscuringCharacter: '∗',
                                controller: signInState.passwordController,

                                // VALIDATION ONLY HERE
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Password is required';
                                  }
                                  return null;
                                },

                                decoration: InputDecoration(
                                  suffixIcon: signInState.passwordSee == true
                                      ? InkWell(
                                          splashColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          onTap: () {
                                            signInController.updateState(
                                              passwordSee:
                                                  !signInState.passwordSee,
                                            );
                                          },
                                          child: Icon(
                                            Icons.visibility,
                                            color: AppColors.appBlack,
                                          ),
                                        )
                                      : InkWell(
                                          splashColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          onTap: () {
                                            signInController.updateState(
                                              passwordSee:
                                                  !signInState.passwordSee,
                                            );
                                          },
                                          child: Icon(
                                            Icons.visibility_off,
                                            color: AppColors.appBlack,
                                          ),
                                        ),

                                  border: InputBorder.none,
                                  hintText: "Password",
                                  hintStyle: TextStyle(
                                    color: AppColors.appBlack,
                                  ),
                                  labelText: null,

                                  labelStyle: TextStyle(
                                    color: AppColors.appPrimaryColor,
                                  ),
                                  floatingLabelStyle: TextStyle(
                                    color: AppColors.appPrimaryColor,
                                  ),

                                  filled: true,
                                  fillColor: AppColors.appPrimaryColorLight,

                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide
                                        .none, // no visible border line
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                    ),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                    ),
                                  ),

                                  errorStyle: TextStyle(color: Colors.red),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            SizedBox(
                              height: 50,
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.appPrimaryColor,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () {
                                  signInState.formKey.currentState!.validate();
                                  log(
                                    signInState.formKey.currentState!
                                        .validate()
                                        .toString(),
                                  );
                                  signInController.updateState(
                                    isSubmitted: true,
                                  );

                                  if (signInState
                                          .usernameController
                                          .text
                                          .isNotEmpty &&
                                      signInState
                                          .passwordController
                                          .text
                                          .isNotEmpty) {
                                    log(
                                      'Username : ${signInState.usernameController.text}',
                                    );
                                    log(
                                      'Password : ${signInState.passwordController.text}',
                                    );
                                    signInController.signInCheck(
                                      context: context,
                                      userName:
                                          signInState.usernameController.text,
                                      password:
                                          signInState.passwordController.text,
                                    );
                                  }
                                  // submit logic
                                },
                                child: signInState.isCheckBaseUrl == true
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
                  //Spacer(),
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
      ),
    );
  }
}
