import 'package:astro_app/astro_chat/application/astro_chat_page_controller_state.dart';
import 'package:astro_app/astro_chat/domain/astro_message.dart';
import 'package:astro_app/astro_chat/domain/send_message_to_astro_chat_use_case.dart';
import 'package:flutter/material.dart';

class AstroChatPageController extends ValueNotifier<AstroChatPageControllerState> {
  AstroChatPageController(
    this.sendMessageToAstroChatUseCase,
  ) : super(
          AstroChatPageControllerInitial(),
        );
  late final TextEditingController textController;
  late final ScrollController scrollController;
  final SendMessageToAstroChatUseCase sendMessageToAstroChatUseCase;
  void initedControllers(
    TextEditingController controller,
    ScrollController scrollController,
  ) {
    textController = controller;
    this.scrollController = scrollController;
  }

  void changedMessageToSend(String newMessage) {
    value = value.copyWith(
      messageToSend: newMessage,
    );
  }

  void submitted() async {
    value = value.copyWith(
      messages: [
        AstroMessage(
          sentAt: DateTime.now(),
          message: value.messageToSend,
          isOwnMessage: true,
        ),
        ...value.messages,
      ],
      isLoading: true,
    );
    scrollController.jumpTo(
      0,
    );
    textController.clear();
    final result = await sendMessageToAstroChatUseCase.call(
      value.messageToSend,
    );
    if (result.$1 != null) {
      value = value.copyWith(
        isLoading: false,
        messageToSend: '',
      );
      return;
    }
    value = value.copyWith(
      messages: [
        result.$2!,
        ...value.messages,
      ],
      messageToSend: '',
      isLoading: false,
    );
    scrollController.jumpTo(
      0,
    );
  }
}
