class GetChatHistoryResponse {
  final bool? status;
  final List<AiChatMessages>? messages;

  GetChatHistoryResponse({
    this.status,
    this.messages,
  });

  GetChatHistoryResponse copyWith({
    bool? status,
    List<AiChatMessages>? messages,
  }) =>
      GetChatHistoryResponse(
        status: status ?? this.status,
        messages: messages ?? this.messages,
      );

  factory GetChatHistoryResponse.fromJson(Map<String, dynamic> json) =>
      GetChatHistoryResponse(
        status: json["status"],
        messages: json["messages"] == null
            ? []
            : List<AiChatMessages>.from(
                json["messages"]!.map((x) => AiChatMessages.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "messages": messages == null
            ? []
            : List<dynamic>.from(messages!.map((x) => x.toJson())),
      };
}

class AiChatMessages {
  final String? sender;
  final String? message;
  final String? id;
  final DateTime? timestamp;

  AiChatMessages({
    this.sender,
    this.message,
    this.id,
    this.timestamp,
  });

  AiChatMessages copyWith({
    String? sender,
    String? message,
    String? id,
    DateTime? timestamp,
  }) =>
      AiChatMessages(
        sender: sender ?? this.sender,
        message: message ?? this.message,
        id: id ?? this.id,
        timestamp: timestamp ?? this.timestamp,
      );

  factory AiChatMessages.fromJson(Map<String, dynamic> json) => AiChatMessages(
        sender: json["sender"],
        message: json["message"],
        id: json["_id"],
        timestamp: json["timestamp"] == null
            ? null
            : DateTime.parse(json["timestamp"]),
      );

  Map<String, dynamic> toJson() => {
        "sender": sender,
        "message": message,
        "_id": id,
        "timestamp": timestamp?.toIso8601String(),
      };
}
