// ignore_for_file: unused_catch_stack

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:journal_app/features/shared/services/services.dart';

/// HttpService abstracts away commonly repeated API call details.
mixin HttpService {
  static final _httpSocketError =
      http.Response('{"socket_exception":"Unable to communicate with server. Check your internet connection."}', 550);

  String get host;

  Map<String, String> get headers;

  /// get Sends an HTTP GET request with the given headers to the given URL endpoint.
  Future<http.Response> get(
    String endpoint, {
    String? tempHost,
    Map<String, String>? extraHeaders,
  }) async {
    try {
      final http.Response response = await client.get(
        Uri.parse(tempHost ?? host + endpoint),
        headers: headers..addAll(extraHeaders ?? {}),
      );

      return parseStatusCode(response, host + endpoint);
    } catch (error, stackTrace) {
      debugPrint('Error:\n\n${error.toString()}');
      return _httpSocketError;
    }
  }

  /// post Sends an HTTP POST request with the given headers and body to the given URL.
  Future<http.Response> post(
    String endpoint, {
    required dynamic body,
    String? tempHost,
    Map<String, String>? baseHeaders,
    Map<String, String>? extraHeaders,
  }) async {
    try {
      final http.Response response = await client.post(
        Uri.parse(tempHost ?? host + endpoint),
        headers: headers..addAll(extraHeaders ?? {}),
        body: body,
      );
      return parseStatusCode(response, host + endpoint);
    } catch (error, stackTrace) {
      debugPrint("Error:\n\n${error.toString()}");
      return _httpSocketError;
    }
  }

  /// put sends an HTTP PUT request with the passed in headers and body to the given URI.

  Future<http.Response> put(
    String endpoint, {
    required dynamic body,
    String? tempHost,
    Map<String, String>? extraHeaders,
  }) async {
    try {
      final http.Response response = await client.put(
        Uri.parse(tempHost ?? host + endpoint),
        body: body,
        headers: headers..addAll(extraHeaders ?? {}),
      );
      return parseStatusCode(response, host + endpoint);
    } catch (error, stackTrace) {
      debugPrint("Error:\n\n${error.toString()}");
      return _httpSocketError;
    }
  }

  /// delete sends an HTTP DELETE request with the passed in headers to the specified URI.

  Future<http.Response> delete(
    String endpoint, {
    dynamic body,
    String? tempHost,
    Map<String, String>? extraHeaders,
  }) async {
    try {
      final response = await client.delete(
        Uri.parse(host + endpoint),
        headers: headers..addAll(extraHeaders ?? {}),
      );

      return parseStatusCode(response, host + endpoint);
    } catch (error, stackTrace) {
      debugPrint("Error:\n\n${error.toString()}");
      return _httpSocketError;
    }
  }
}

///  parseStatusCode: logs endpoint, response status code and the server response.
http.Response parseStatusCode(http.Response response, String endpoint) {
  debugPrint('\nEndpoint: \n$endpoint');
  debugPrint('\nStatus Code:\n${response.statusCode}');
  debugPrint('\nResponse Body:\n${utf8.decode(response.bodyBytes)}');

  return response;
}

/// getErrorMsg: decodes json string and returns first error
String getErrorMsg(String jsonString) {
  final Map<String, dynamic> parsedJson = jsonDecode(jsonString);
  return parsedJson.values.toList()[0];
}

// What is a Service?

//   - Services aslo referred to as repositories request responses from
//     server endpoints
//   - the response is then decoded and servered throughout your application
//   - Services can also be used to serve temporary data throughtout your application
//     like a ToastService that displays temporary snack bars and banners
