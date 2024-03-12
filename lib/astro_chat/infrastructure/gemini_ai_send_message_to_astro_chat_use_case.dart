import 'package:astro_app/astro_chat/domain/astro_message.dart';
import 'package:astro_app/astro_chat/domain/send_message_to_astro_chat_use_case.dart';
import 'package:astro_app/astro_chat/domain/send_message_to_astro_failure.dart';
import 'package:astro_app/shared/domain/string_constants.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiAISendMessageToAstroChatUseCase implements SendMessageToAstroChatUseCase {
  @override
  Future<(SendMessageToAstroFailure?, AstroMessage?)> call(String message) async {
    final gemini = GenerativeModel(
      model: 'gemini-pro',
      apiKey: const String.fromEnvironment(
        'GEMINI_API_KEY',
      ),
    );
    try {
      final response = await gemini.generateContent(
        [
          Content.text('${StringConstants.geminiPrompt}"$message"'),
        ],
      );
      final messageToReturn = AstroMessage(
        sentAt: DateTime.now(),
        message: response.text!,
        isOwnMessage: false,
      );
      return (
        null,
        messageToReturn,
      );
    } catch (_) {
      return (
        SendMessageToAstroFailure.unknownError,
        null,
      );
    }
  }
}
