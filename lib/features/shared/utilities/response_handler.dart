import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

/// Handles response by parsing the endpoint, status code, and response body from the Response object.
/// Retrieves error messages from response if the status code is not 200 or 201.
class ResponseHandler {
  ResponseHandler._();

  /// Checks status code of response, If status code is 200 or 201 returns true else false.

  static bool checkStatusCode(Response response) {
    return (response.statusCode == 200 || response.statusCode == 201) ? true : false;
  }

  /// Decodes json string and return first error
  static String getErrorMsg(String jsonString) {
    final Map<String, dynamic> parsedJson = jsonDecode(jsonString);
    return parsedJson.values.toList()[0];
  }

  /// Logs endpoint, response status code and server response body.
  static Response parseStatusCode(Response response, String endpoint) {
    debugPrint('\nEndpoint: \n$endpoint');
    debugPrint('\nStatus Code:\n${response.statusCode}');
    debugPrint('\nResponse Body:\n${utf8.decode(response.bodyBytes)}');

    return response;
  }
}
