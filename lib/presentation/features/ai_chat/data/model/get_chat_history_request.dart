class GetChatHistoryRequest {
  final String sessionId;

  GetChatHistoryRequest({
    required this.sessionId,
  });

  GetChatHistoryRequest copyWith({
    String? sessionId,
  }) =>
      GetChatHistoryRequest(
        sessionId: sessionId ?? this.sessionId,
      );

  factory GetChatHistoryRequest.fromJson(Map<String, dynamic> json) =>
      GetChatHistoryRequest(
        sessionId: json["sessionId"],
      );

  Map<String, dynamic> toJson() => {
        "sessionId": sessionId,
      };
}
