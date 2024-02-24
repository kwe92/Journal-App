import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> loadEnvVariables() async => await dotenv.load(fileName: "/Users/kwe/flutter-projects/JournalApp/journal_app/.env");
