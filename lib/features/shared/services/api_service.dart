import 'dart:io';

import 'package:journal_app/app/general/constants.dart';

import 'http_service.dart';

// Todo: host should be hidden in .env | DotEnv dotenv | package:flutter_dotenv/src/dotenv.dart

abstract class ApiService with HttpService {
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

  // Journal Entry Endpoints
  entries("/api/entry"),
  updateEntry("/api/update-entry/"),
  deleteEntry("/api/delete-entry/");

  final String path;

  const Endpoint(this.path);
}
