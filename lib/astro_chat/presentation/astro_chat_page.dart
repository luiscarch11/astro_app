import 'package:astro_app/astro_chat/application/astro_chat_page_controller.dart';
import 'package:astro_app/astro_chat/application/astro_chat_page_controller_state.dart';
import 'package:astro_app/astro_chat/domain/astro_message.dart';
import 'package:astro_app/astro_chat/infrastructure/gemini_ai_send_message_to_astro_chat_use_case.dart';
import 'package:astro_app/shared/presentation/color_constants.dart';
import 'package:astro_app/shared/presentation/widgets/loader.dart';
import 'package:astro_app/shared/presentation/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';

class AstroChatPage extends StatelessWidget {
  AstroChatPage({super.key});
  final textFieldController = TextEditingController();
  final scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final controller = AstroChatPageController(
      GeminiAISendMessageToAstroChatUseCase(),
    )..initedControllers(
        textFieldController,
        scrollController,
      );
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'AstroChat',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        backgroundColor: ColorConstants.darkBlueColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 10,
                child: ValueListenableBuilder<AstroChatPageControllerState>(
                  valueListenable: controller,
                  builder: (_, snapshot, __) => ListView.separated(
                    itemCount: snapshot.messages.length,
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 8,
                    ),
                    reverse: true,
                    controller: scrollController,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          _ChatBubble(
                            message: snapshot.messages[index],
                          ),
                          if (snapshot.isLoading)
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Loader(),
                            ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: TextFieldWidget(
                        controller: textFieldController,
                        label: 'Escribe un mensaje',
                        hideBorders: true,
                        center: false,
                        onChanged: controller.changedMessageToSend,
                      ),
                    ),
                    ValueListenableBuilder<AstroChatPageControllerState>(
                      valueListenable: controller,
                      builder: (_, snapshot, __) => IconButton(
                        onPressed: snapshot.isLoading ? null : controller.submitted,
                        icon: const Icon(
                          Icons.send,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChatBubble extends StatelessWidget {
  const _ChatBubble({
    required this.message,
  });
  final AstroMessage message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isOwnMessage ? Alignment.topRight : Alignment.topLeft,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            width: constraints.maxWidth * 0.7,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: message.isOwnMessage ? Colors.orange[200] : Colors.cyan[200],
            ),
            child: Text(
              message.message,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Colors.black,
                  ),
            ),
          );
        },
      ),
    );
  }
}
