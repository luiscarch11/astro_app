final class AstroMessage {
  final DateTime sentAt;
  final String message;
  final bool isOwnMessage;
  AstroMessage({
    required this.sentAt,
    required this.message,
    required this.isOwnMessage,
  });

  AstroMessage copyWith({
    DateTime? sentAt,
    String? message,
    bool? isOwnMessage,
  }) {
    return AstroMessage(
      sentAt: sentAt ?? this.sentAt,
      message: message ?? this.message,
      isOwnMessage: isOwnMessage ?? this.isOwnMessage,
    );
  }

  @override
  String toString() => 'AstroMessage(sentAt: $sentAt, message: $message, isOwnMessage: $isOwnMessage)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AstroMessage &&
        other.sentAt == sentAt &&
        other.message == message &&
        other.isOwnMessage == isOwnMessage;
  }

  @override
  int get hashCode => sentAt.hashCode ^ message.hashCode ^ isOwnMessage.hashCode;
}
