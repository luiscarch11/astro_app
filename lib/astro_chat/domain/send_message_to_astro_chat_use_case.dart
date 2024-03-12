import 'package:astro_app/astro_chat/domain/astro_message.dart';
import 'package:astro_app/astro_chat/domain/send_message_to_astro_failure.dart';

abstract interface class SendMessageToAstroChatUseCase {
  Future<(SendMessageToAstroFailure?, AstroMessage?)> call(String message);
}
