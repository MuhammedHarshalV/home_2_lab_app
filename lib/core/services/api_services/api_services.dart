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
    BuildContext? context,
    required String url,
    Map<String, dynamic>? body,
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
          if (context != null) {
            AppMessage.show(context, "Empty response from server");
          }
          return null;
        }

        return response.body;
      } else {
        if (context != null) {
          AppMessage.show(context, "Server Error : ${response.statusCode}");
        }
        return null;
      }
    } on SocketException {
      if (context != null) {
        AppMessage.show(context, "No Internet Connection/Connection timed out");
      }
      return null;
    } on HttpException {
      if (context != null) AppMessage.show(context, "Server Not Responding");
      return null;
    } on FormatException catch (e) {
      log("FORMAT ERROR: $e");
      if (context != null) AppMessage.show(context, "Invalid Data Format");
      return null;
    } catch (e) {
      log("UNKNOWN ERROR: $e");
      if (context != null) AppMessage.show(context, e.toString());
      return null;
    }
  }
}

//Dio Post Api

// class PostApiServices {
//   static final Dio dio = Dio(
//     BaseOptions(
//       connectTimeout: const Duration(seconds: 15),
//       receiveTimeout: const Duration(seconds: 15),
//       headers: {
//         "Content-Type": "application/json",
//         "Accept": "application/json",
//       },
//     ),
//   );

//   static Future<String?> callApi({
//     required BuildContext context,
//     required String url,
//     Map<String, dynamic>? body,
//     Map<String, dynamic>? queryParams,
//     String? token,
//   }) async {
//     try {
//       log("=========== API REQUEST ===========");
//       log("METHOD : POST");
//       log("URL    : $url");
//       log("BODY   : ${body ?? {}}");
//       log("QUERY  : ${queryParams ?? {}}");
//       log("===================================");

//       final response = await dio.post(
//         url,
//         data: body,
//         queryParameters: queryParams,
//         options: Options(
//           headers: {"Authorization": token != null ? "Bearer $token" : null},
//         ),
//       );

//       log("=========== API RESPONSE ===========");
//       log("STATUS CODE : ${response.statusCode}");
//       log("DATA : ${response.data}");
//       log("===================================");

//       if (response.statusCode! >= 200 && response.statusCode! < 300) {
//         return response.data;
//       } else {
//         AppMessage.show(context, "Server Error : ${response.statusCode}");
//         return null;
//       }
//     } on DioException catch (e) {
//       log("DIO ERROR : ${e.message}");

//       if (e.type == DioExceptionType.connectionTimeout ||
//           e.type == DioExceptionType.receiveTimeout) {
//         AppMessage.show(context, "Connection timed out");
//       } else if (e.type == DioExceptionType.connectionError) {
//         AppMessage.show(context, "No Internet Connection");
//       } else if (e.response != null) {
//         AppMessage.show(context, "Server Error : ${e.response?.statusCode}");
//       } else {
//         AppMessage.show(context, e.message ?? "Unknown Error");
//       }

//       return null;
//     } catch (e) {
//       log("UNKNOWN ERROR : $e");
//       AppMessage.show(context, e.toString());
//       return null;
//     }
//   }
// }
