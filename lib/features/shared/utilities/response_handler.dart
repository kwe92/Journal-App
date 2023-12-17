import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:journal_app/features/shared/services/services.dart';
// TODO: add comments

class ResponseHandler {
  ResponseHandler._();

  static bool checkStatusCode(Response response, [String? message]) {
    if (message != null && response.statusCode == 200 || response.statusCode == 201) {
      toastService.showSnackBar(message: message);
      return true;
    } else if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    }
    toastService.showSnackBar(message: getErrorMsg(response.body), textColor: Colors.red);
    return false;
  }

  /// getErrorMsg: decodes json string and returns first error
  static String getErrorMsg(String jsonString) {
    final Map<String, dynamic> parsedJson = jsonDecode(jsonString);
    return parsedJson.values.toList()[0];
  }

  ///  parseStatusCode: logs endpoint, response status code and the server response.
  static Response parseStatusCode(Response response, String endpoint) {
    debugPrint('\nEndpoint: \n$endpoint');
    debugPrint('\nStatus Code:\n${response.statusCode}');
    debugPrint('\nResponse Body:\n${utf8.decode(response.bodyBytes)}');

    return response;
  }
}
