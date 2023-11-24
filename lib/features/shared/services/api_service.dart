import 'http_service.dart';

// Todo: host should be hidden in .env | DotEnv dotenv | package:flutter_dotenv/src/dotenv.dart

abstract class ApiService with HttpService {
  @override
  String get host;

  @override
  Map<String, String> get headers;
}
