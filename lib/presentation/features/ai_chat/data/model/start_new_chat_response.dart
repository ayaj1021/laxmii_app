class StartNewChatResponse {
  final bool? status;
  final String? sessionId;

  StartNewChatResponse({
    this.status,
    this.sessionId,
  });

  StartNewChatResponse copyWith({
    bool? status,
    String? sessionId,
  }) =>
      StartNewChatResponse(
        status: status ?? this.status,
        sessionId: sessionId ?? this.sessionId,
      );

  factory StartNewChatResponse.fromJson(Map<String, dynamic> json) =>
      StartNewChatResponse(
        status: json["status"],
        sessionId: json["sessionId"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "sessionId": sessionId,
      };
}
