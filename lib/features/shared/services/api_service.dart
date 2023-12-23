import 'dart:io';

import 'package:journal_app/app/general/constants.dart';

import 'http_service.dart';

// Todo: host should be hidden in .env | DotEnv dotenv | package:flutter_dotenv/src/dotenv.dart

// TODO: Can't we just add ChangeNotifer here since all classes that extend from ApiService require ChangeNotifier?
abstract class ApiService with HttpService {
  final bearerPrefix = "Bearer";

  @override
  Map<String, String> get headers => {
        HttpHeaders.contentTypeHeader: MediaType.json,
      };

//! In real app hide behind environment variable
  @override
  String get host => "http://127.0.0.1:8080";
}

/// Endpoint: enum of endpoint paths.
enum Endpoint {
  // Authentication Endpoints
  register("/auth/register"),
  login("/auth/login"),
  checkAvailableEmail("/auth/available-email"),
  deleteAccount("/api/delete-account"),

  // Journal Entry Endpoints
  entries("/api/entry"),
  updateEntry("/api/update-entry/"),
  deleteEntry("/api/delete-entry/");

  final String path;

  const Endpoint(this.path);
}
