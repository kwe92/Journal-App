import 'dart:io';

import 'http_service.dart';

// Todo: host should be hidden in .env | DotEnv dotenv | package:flutter_dotenv/src/dotenv.dart

// TODO: continue adding endpoints

abstract class ApiService with HttpService {
  @override
  Map<String, String> get headers => {
        HttpHeaders.contentTypeHeader: "application/json",
      };

//! In real app hide behind environment variable
  @override
  String get host => "http://127.0.0.1:8080";
}

// TODO: add all endpoints with enhanced enum
enum Endpoint {
  register("/auth/register"),
  login("/auth/login");

  final String path;

  const Endpoint(this.path);
}
