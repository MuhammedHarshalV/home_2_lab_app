import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:icon_infoware/core/constants/api_constants.dart';

import 'package:icon_infoware/core/services/api_services/api_services.dart';
import 'package:icon_infoware/models/sign_in/login_response_model.dart';

class SignInChecking {
  static Future<dynamic> signInChecking({
    required BuildContext context,
    required Map<String, dynamic> body,
  }) async {
    try {
      final response = await PostApiServices.callApi(
        context: context,
        body: body,

        url: ApiConstants.loginApi,
      );

      if (response.toString().isEmpty || response == null) {
        return 'Invalid username or password';
      } else {
        return LoginResponeModel.fromJson(response);
      }
    } catch (e) {
      log('-------------');
      log(e.toString());

      return null;
    }
  }
}
