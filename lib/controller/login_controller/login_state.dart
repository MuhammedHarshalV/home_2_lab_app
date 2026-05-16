import 'package:flutter/material.dart';

class LoginState {
  final bool passwordSee;
  final bool isSubmitted;
  final String pinNumber;
  final String baseUrl;
  final String imageBase64;

  final bool isCheckBaseUrl;

  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final TextEditingController baseUrlController;
  final TextEditingController branchIDController;
  final TextEditingController pinOneController;
  final TextEditingController pinTwoController;
  final TextEditingController loginController;

  final GlobalKey<FormState> formKey;
  final GlobalKey<FormState> baseUrlFormKey;

  LoginState({
    this.passwordSee = false,
    this.isSubmitted = false,
    this.isCheckBaseUrl = false,
    required this.usernameController,
    required this.passwordController,
    required this.formKey,
    required this.baseUrlController,
    required this.branchIDController,
    required this.baseUrlFormKey,
    this.pinNumber = '',
    this.baseUrl = '',
    this.imageBase64 = '',
    required this.pinOneController,
    required this.pinTwoController,
    required this.loginController,
  });

  LoginState copyWith({
    String? pinNumber,
    bool? passwordSee,
    bool? isSubmitted,
    String? baseUrl,
    String? imageBase64,

    bool? isCheckBaseUrl,

    TextEditingController? usernameController,
    TextEditingController? passwordController,
    TextEditingController? baseUrlController,
    TextEditingController? branchIDController,
    TextEditingController? pinOneController,
    TextEditingController? pinTwoController,
    TextEditingController? loginController,
    GlobalKey<FormState>? formKey,
    GlobalKey<FormState>? baseUrlFormKey,
  }) {
    return LoginState(
      pinNumber: pinNumber ?? this.pinNumber,
      passwordSee: passwordSee ?? this.passwordSee,
      isSubmitted: isSubmitted ?? this.isSubmitted,
      branchIDController: branchIDController ?? this.branchIDController,

      baseUrl: baseUrl ?? this.baseUrl,
      imageBase64: imageBase64 ?? this.imageBase64,

      usernameController: usernameController ?? this.usernameController,
      passwordController: passwordController ?? this.passwordController,
      baseUrlController: baseUrlController ?? this.baseUrlController,
      isCheckBaseUrl: isCheckBaseUrl ?? this.isCheckBaseUrl,
      pinOneController: pinOneController ?? this.pinOneController,
      pinTwoController: pinTwoController ?? this.pinTwoController,
      loginController: loginController ?? this.loginController,

      formKey: formKey ?? this.formKey,
      baseUrlFormKey: baseUrlFormKey ?? this.baseUrlFormKey,
    );
  }
}
