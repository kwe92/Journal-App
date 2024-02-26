import 'dart:io';

import 'package:journal_app/app/general/constants.dart';

import 'http_service.dart';

//! host should be hidden in .env | DotEnv dotenv | package:flutter_dotenv/src/dotenv.dart
/// abstracts away commonly repeated API call details and provides bearer authorization prefix, headers, and host
abstract class ApiService with HttpService {
  /// required prefix of authorization header value i.e. the jwt
  final bearerPrefix = "Bearer";

  /// HTTP base header with content-type and MIME type
  @override
  Map<String, String> get headers => {
        HttpHeaders.contentTypeHeader: MediaType.json,
      };

//! In real app hide behind environment variable
  /// composed of scheme, domain name or ip address and port number.
  @override
  // String get host => "http://127.0.0.1:8080";
  String get host => "http://172.20.10.2:8080";
}

//! In real app hide behind environment variable
const String testHost = "http://127.0.0.1:8080"; // For test views.

/// backend API endpoint paths.
enum Endpoint {
  // Authentication Endpoints
  register("/auth/register"),
  login("/auth/login"),
  checkAvailableEmail("/auth/available-email"),

  // Journal Entry Endpoints
  entries("/api/entry"),
  updateEntry("/api/update-entry/"),
  deleteEntry("/api/delete-entry/"),

  // User Endpoints
  deleteAccount("/api/delete-account"),
  updateUserInfo("/api/update-user-info"),

  // Liked Quotes Endpoints
  likedQuotes("/api/liked-quotes"),
  deleteLikedQuote("/api/delete-liked-quote/");

  final String path;

  const Endpoint(this.path);
}
