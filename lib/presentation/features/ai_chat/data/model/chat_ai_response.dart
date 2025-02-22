class ChatAiResponse {
  final bool? status;
  final String? aiResponse;

  ChatAiResponse({
    this.status,
    this.aiResponse,
  });

  ChatAiResponse copyWith({
    bool? status,
    String? aiResponse,
  }) =>
      ChatAiResponse(
        status: status ?? this.status,
        aiResponse: aiResponse ?? this.aiResponse,
      );

  factory ChatAiResponse.fromJson(Map<String, dynamic> json) => ChatAiResponse(
        status: json["status"],
        aiResponse: json["ai_response"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "ai_response": aiResponse,
      };
}
