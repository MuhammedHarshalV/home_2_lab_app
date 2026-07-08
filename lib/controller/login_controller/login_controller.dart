import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:icon_infoware/apis/base_url_checking.dart';
import 'package:icon_infoware/apis/sign_in_checking.dart';
import 'package:icon_infoware/controller/login_controller/address_save.dart';

import 'package:icon_infoware/controller/login_controller/login_state.dart';
import 'package:icon_infoware/core/constants/api_constants.dart';
import 'package:icon_infoware/core/constants/app_constance.dart';
import 'package:icon_infoware/core/errors/api_errors/api_errors.dart';
import 'package:icon_infoware/core/routes/app_route_names.dart';
import 'package:icon_infoware/models/base_url_response/base_url_response_model.dart';
import 'package:icon_infoware/models/sign_in/login_response_model.dart';

import 'package:path_provider/path_provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends StateNotifier<LoginState> {
  LoginController()
    : super(
        LoginState(
          formKey: GlobalKey<FormState>(),
          usernameController: TextEditingController(),
          passwordController: TextEditingController(),
          baseUrlController: TextEditingController(),
          branchIDController: TextEditingController(),
          baseUrlFormKey: GlobalKey<FormState>(),
          pinOneController: TextEditingController(),
          pinTwoController: TextEditingController(),
          loginController: TextEditingController(),
        ),
      ) {
    readData();
    // readBaseUrl(); // like initState
  }
  @override
  void dispose() {
    log(
      'Login controller disposed----------------------------------------------------',
    );
    super.dispose();
  }

  Future<void> baseUrlAndBranchcheck({
    required BuildContext context,
    required String baseUrl,
    required String branchID,
  }) async {
    state = state.copyWith(isCheckBaseUrl: true);
    try {
      final BaseUrlResponseModel? response =
          await BaseUrlChecking.baseUrlRegister(
            context: context,
            baseUrl: baseUrl,
            branchID: branchID,
          );
      //  log("Response: $status");
      if (response == null) {
        AppMessage.show(
          context,
          "Device registration failed.\nContact Icon Infoware",
        );
      } else if (response.cusLogo != null &&
          response.cusLogo.toString().isNotEmpty) {
        await storeBaseUrl(baseUrl: baseUrl);
        await storeImage(image: response.cusLogo!);
        context.goNamed(AppRouteNames.signInScreen.name);
        await AddressStorage.saveAddress(
          name: response.brName ?? '',
          address: response.brAddr ?? '',
          webUrl: response.webaddr ?? '',
          phoneNumber: response.brPhno ?? '',
          devCode: response.deviceCode ?? '',
          tagLine: response.cusTagLine ?? '',
          qrUrl: response.qRaddr ?? '',
        );
        AppConstants.name = response.brName ?? '';
        AppConstants.address = response.brAddr ?? '';
        AppConstants.webUrl = response.webaddr ?? '';
        AppConstants.phoneNumber = response.brPhno ?? '';
        AppConstants.devCode = response.deviceCode ?? '';
        AppConstants.tagLine = response.cusTagLine ?? '';
        AppConstants.qrUrl = response.qRaddr ?? '';
        state = state.copyWith(isSubmitted: false);
      } else if (response.success == false) {
        AppMessage.show(
          context,
          "Identified as New Device,Please contact Software Support Team\nwww.iconinfoware.com it will take few minutes for configuration Please wait...",
        );
      }
    } catch (e) {
      log("Error: $e");
    } finally {
      // always runs even if crash — loading always stops
      state = state.copyWith(isCheckBaseUrl: false);
    }
  }

  // //SignIn checking
  Future<void> signInCheck({
    required BuildContext context,
    required String userName,
    required String password,
  }) async {
    state = state.copyWith(isCheckBaseUrl: true);
    try {
      final LoginResponeModel? response = await SignInChecking.signInChecking(
        context: context,
        body: {"UsrName": userName, "Password": password},
      );
      log("signin response :  ${response ?? 'Fail in sign in'}");
      if (response?.success == true) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('userName', userName);
        AppConstants.userName = userName;
        context.goNamed(AppRouteNames.pinSettingScreen.name);
      } else if (response?.success == false) {
        AppMessage.show(context, 'Invalid username or password');
      }
    } catch (e) {
      log("Error: $e");
    } finally {
      // always runs even if crash — loading always stops
      state = state.copyWith(isCheckBaseUrl: false);
    }
  }

  void updateState({bool? passwordSee, bool? isSubmitted}) {
    state = state.copyWith(passwordSee: passwordSee, isSubmitted: isSubmitted);
  }

  //pin storing to phone
  Future<void> storePIN({required String pin}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('PIN', pin);
    AppConstants.pin = pin;
    log('PIN storing $pin');
  } //Image storing to phone

  Future<void> storeImage({required String image}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('Image', image);
    log('image storing $image');
    if (image.isNotEmpty) {
      String imagePath = await base64ToImagePath(image, 'company_logo');
      state = state.copyWith(imageBase64: imagePath);
      AppConstants.base64Image = image;
    }
  } //baseurl storing to phone

  Future<void> storeBaseUrl({required String baseUrl}) async {
    state = state.copyWith(isCheckBaseUrl: true);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('BaseURL', baseUrl);
    ApiConstants.baseUrl = baseUrl;
    state = state.copyWith(isCheckBaseUrl: false);
    log('PIN baseurl $baseUrl');
  }

  //read stored image in phone
  Future<void> readImage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? image = prefs.getString('Image');
    log('Readed Image :$image');
    if (image != null && image.isNotEmpty) {
      String imagePath = await base64ToImagePath(image, 'company_logo');
      AppConstants.base64Image = imagePath;

      state = state.copyWith(imageBase64: imagePath);
    }
  }

  Future<String> base64ToImagePath(String base64String, String fileName) async {
    try {
      //  Decode base64
      Uint8List imageBytes = base64Decode(base64String);

      //  Get temp directory
      final Directory tempDir = await getTemporaryDirectory();

      //  Create file path
      final String filePath = '${tempDir.path}/$fileName.png';

      //  Write bytes to file
      final File imageFile = File(filePath);
      await imageFile.writeAsBytes(imageBytes);

      //  Return file path
      return filePath;
    } catch (e) {
      throw Exception('Failed to convert base64 to image: $e');
    }
  }

  //read stored pin in phone

  Future<void> readData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? pin = prefs.getString('PIN');
    final String? deviceID = prefs.getString('DeviceID');
    final String? branchID = prefs.getString('BranchID');
    final String? userName = prefs.getString('userName');

    log('Readed pin :$pin');

    if (deviceID != null && deviceID.isNotEmpty) {
      AppConstants.deviceID = deviceID;
    }
    if (pin != null && pin.isNotEmpty) {
      state = state.copyWith(pinNumber: pin);
      AppConstants.pin = pin;
    }
    if (branchID != null && branchID.isNotEmpty) {
      AppConstants.branchID = branchID;
    }
    if (userName != null && userName.isNotEmpty) {
      AppConstants.userName = userName;
    }
    await readBaseUrl();
    await readImage();
  }

  //stored baseurl in phone
  Future<void> readBaseUrl() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? baseUrl = prefs.getString('BaseURL');
    log('Readed baseurl :$baseUrl');
    if (baseUrl != null && baseUrl.isNotEmpty) {
      ApiConstants.baseUrl = baseUrl;
      state = state.copyWith(baseUrl: baseUrl);
    }
  }
}

final loginProvider = StateNotifierProvider<LoginController, LoginState>((ref) {
  return LoginController();
});
