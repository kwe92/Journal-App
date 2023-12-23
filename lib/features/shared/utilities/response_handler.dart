import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:journal_app/features/shared/services/services.dart';

/// Handles response by parsing the endpoint, status code, and response body from the Response object.
/// Retrieves error messages from response if the status code is not 200 or 201.
class ResponseHandler {
  ResponseHandler._();

  /// Checks status code of response, returns message as snackbar popup if response is 200 or 201.
  /// If response code is other than 200 or 201 the error message is parsed and dispalyed as a snackbar popup.
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

  /// Decodes json string and return first error
  static String getErrorMsg(String jsonString) {
    final Map<String, dynamic> parsedJson = jsonDecode(jsonString);
    return parsedJson.values.toList()[0];
  }

  /// Logs endpoint, response status code and the server response.
  static Response parseStatusCode(Response response, String endpoint) {
    debugPrint('\nEndpoint: \n$endpoint');
    debugPrint('\nStatus Code:\n${response.statusCode}');
    debugPrint('\nResponse Body:\n${utf8.decode(response.bodyBytes)}');

    return response;
  }
}
