class ChatAiRequest {
  final String userInput;
  final String sessionId;

  ChatAiRequest({
    required this.userInput,
    required this.sessionId,
  });

  ChatAiRequest copyWith({
    String? userInput,
    String? sessionId,
  }) =>
      ChatAiRequest(
        userInput: userInput ?? this.userInput,
        sessionId: sessionId ?? this.sessionId,
      );

  factory ChatAiRequest.fromJson(Map<String, dynamic> json) => ChatAiRequest(
        userInput: json["userInput"],
        sessionId: json["sessionId"],
      );

  Map<String, dynamic> toJson() => {
        "userInput": userInput,
        "sessionId": sessionId,
      };
}
