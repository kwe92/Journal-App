import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> loadEnvVariables() async => await dotenv.load(fileName: ".env");
