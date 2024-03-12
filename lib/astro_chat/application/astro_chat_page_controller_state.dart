import 'package:astro_app/astro_chat/domain/astro_message.dart';
import 'package:flutter/foundation.dart';

class AstroChatPageControllerState {
  final List<AstroMessage> messages;
  final bool isLoading;
  final String messageToSend;
  AstroChatPageControllerState({
    required this.messages,
    required this.isLoading,
    required this.messageToSend,
  });

  AstroChatPageControllerState copyWith({
    List<AstroMessage>? messages,
    bool? isLoading,
    String? messageToSend,
  }) {
    return AstroChatPageControllerState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      messageToSend: messageToSend ?? this.messageToSend,
    );
  }

  @override
  String toString() =>
      'AstroChatPageControllerState(messages: $messages, isLoading: $isLoading, messageToSend: $messageToSend)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AstroChatPageControllerState &&
        listEquals(other.messages, messages) &&
        other.isLoading == isLoading &&
        other.messageToSend == messageToSend;
  }

  @override
  int get hashCode => messages.hashCode ^ isLoading.hashCode ^ messageToSend.hashCode;
}

class AstroChatPageControllerInitial extends AstroChatPageControllerState {
  AstroChatPageControllerInitial()
      : super(
          messages: [],
          isLoading: false,
          messageToSend: '',
        );
}
