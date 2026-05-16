import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:icon_infoware/core/errors/api_errors/api_errors.dart';

class GetApiService {
  static Future<dynamic> callApi({
    required BuildContext context,
    required String url,
  }) async {
    try {
      Uri uri = Uri.parse(url);
      log("=========== API REQUEST ===========");
      log("METHOD : GET");
      log("URL    : $uri");

      log('===================================');

      final response = await http
          .get(uri)
          .timeout(
            const Duration(seconds: 15), //stops waiting after 15 seconds
            onTimeout: () {
              throw SocketException('Connection timed out');
            },
          );
      // log("RESPONSE  : ${response.body}");

      log("=========== API RESPONSE ===========");
      log("STATUS CODE : ${response.statusCode}");
      //log("RESPONSE        : ${response.body}");
      log("===================================");

      if (response.statusCode < 300 && response.statusCode >= 200) {
        final decoded = jsonDecode(response.body);
        //log("DECODED : $decoded");
        return decoded;
      } else {
        AppMessage.show(context, "Server Error : ${response.statusCode}");

        return null;
      }
    } on SocketException {
      AppMessage.show(context, "No Internet Connection/Connection timed out");

      return null;
    } on HttpException {
      AppMessage.show(context, "Server Not Responding");

      return null;
    } on FormatException {
      AppMessage.show(context, "Invalid Data Format");

      return null;
    } catch (e) {
      //   _showSnackBar(context, e.toString());
      AppMessage.show(context, e.toString());

      return null;
    }
  }
}

//post service
class PostApiService {
  static Future<String?> callApi({
    required BuildContext context,
    required String url,
    required Map<String, dynamic> body,
    String? token,
  }) async {
    try {
      Uri uri = Uri.parse(url);

      log("=========== API REQUEST ===========");
      log("METHOD : POST");
      log("UR((L    : $uri");
      log("BODY   : $body");
      log("===================================");

      final response = await http
          .post(
            uri,
            headers: {
              "Content-Type": "application/json",
              "Accept": "application/json",
            },
            body: jsonEncode(body),
          )
          .timeout(
            const Duration(seconds: 15),
            onTimeout: () {
              throw SocketException('Connection timed out');
            },
          );

      log("=========== API RESPONSE ===========");
      log("STATUS CODE : ${response.statusCode}");
      log("===================================");

      if (response.statusCode >= 200 && response.statusCode < 300) {
        log("------------${response.body}");
        if (response.body.isEmpty) {
          AppMessage.show(context, "Empty response from server");
          return null;
        }

        return response.body;
      } else {
        AppMessage.show(context, "Server Error : ${response.statusCode}");
        return null;
      }
    } on SocketException {
      AppMessage.show(context, "No Internet Connection/Connection timed out");
      return null;
    } on HttpException {
      AppMessage.show(context, "Server Not Responding");
      return null;
    } on FormatException catch (e) {
      log("FORMAT ERROR: $e");
      AppMessage.show(context, "Invalid Data Format");
      return null;
    } catch (e) {
      log("UNKNOWN ERROR: $e");
      AppMessage.show(context, e.toString());
      return null;
    }
  }
}
