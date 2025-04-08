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

// class StartNewChatResponse {
//   final bool? status;
//   final SessionId? sessionId;

//   StartNewChatResponse({
//     this.status,
//     this.sessionId,
//   });

//   StartNewChatResponse copyWith({
//     bool? status,
//     SessionId? sessionId,
//   }) =>
//       StartNewChatResponse(
//         status: status ?? this.status,
//         sessionId: sessionId ?? this.sessionId,
//       );

//   factory StartNewChatResponse.fromJson(Map<String, dynamic> json) =>
//       StartNewChatResponse(
//         status: json["status"],
//         sessionId: json["sessionId"] == null
//             ? null
//             : SessionId.fromJson(json["sessionId"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "sessionId": sessionId?.toJson(),
//       };
// }

// class SessionId {
//   final String? sessionId;
//   final String? chatId;

//   SessionId({
//     this.sessionId,
//     this.chatId,
//   });

//   SessionId copyWith({
//     String? sessionId,
//     String? chatId,
//   }) =>
//       SessionId(
//         sessionId: sessionId ?? this.sessionId,
//         chatId: chatId ?? this.chatId,
//       );

//   factory SessionId.fromJson(Map<String, dynamic> json) => SessionId(
//         sessionId: json["sessionId"],
//         chatId: json["chatId"],
//       );

//   Map<String, dynamic> toJson() => {
//         "sessionId": sessionId,
//         "chatId": chatId,
//       };
// }
