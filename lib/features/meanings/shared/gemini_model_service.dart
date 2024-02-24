import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:stacked/stacked.dart';

class GeminiModelService extends BaseViewModel {
  late GenerativeModel _generativeModel;

  String? promptTextResponse;

  GeminiModelService() {
    initialize();
  }

  void initialize() {
    _generativeModel = getGenerativeModel();
  }

  Future<String?> generateContent(Iterable<Content> content) async {
    try {
      final GenerateContentResponse response = await runBusyFuture(_generativeModel.generateContent(content));

      debugPrint(response.text);

      promptTextResponse = response.text;

      notifyListeners();
      return null;
    } catch (e) {
      debugPrint(e.toString());

      return e.toString();
    }
  }

  GenerativeModel getGenerativeModel([String? model]) => GenerativeModel(
        model: model ?? "gemini-pro",
        apiKey: getGeminiApiKey(),
      );

  String getGeminiApiKey() {
    final geminiApiKey = handleGeminiApiKeyException();

    return geminiApiKey ?? '';
  }

  String? handleGeminiApiKeyException() {
    const errorMsg = "GEMINI_API_KEY not found, please ensure environment variables are loaded properly before the application starts.";

    try {
      final geminiApiKey = dotenv.env["GEMINI_API_KEY"];

      if (geminiApiKey == null) {
        debugPrint(errorMsg);
        return null;
      }

      return geminiApiKey;
    } catch (e) {
      debugPrint("exception in getGeminiApiKey: $errorMsg");
      return null;
    }
  }
}
