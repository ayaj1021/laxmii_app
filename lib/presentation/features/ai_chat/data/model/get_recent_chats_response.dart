class GetRecentChatsResponse {
  final bool? status;
  final List<RecentChat>? recentChats;

  GetRecentChatsResponse({
    this.status,
    this.recentChats,
  });

  GetRecentChatsResponse copyWith({
    bool? status,
    List<RecentChat>? recentChats,
  }) =>
      GetRecentChatsResponse(
        status: status ?? this.status,
        recentChats: recentChats ?? this.recentChats,
      );

  factory GetRecentChatsResponse.fromJson(Map<String, dynamic> json) =>
      GetRecentChatsResponse(
        status: json["status"],
        recentChats: json["recentChats"] == null
            ? []
            : List<RecentChat>.from(
                json["recentChats"]!.map((x) => RecentChat.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "recentChats": recentChats == null
            ? []
            : List<dynamic>.from(recentChats!.map((x) => x.toJson())),
      };
}

class RecentChat {
  final String? id;
  final String? sessionId;
  final DateTime? createdAt;
  final LastMessage? lastMessage;

  RecentChat({
    this.id,
    this.sessionId,
    this.createdAt,
    this.lastMessage,
  });

  RecentChat copyWith({
    String? id,
    String? sessionId,
    DateTime? createdAt,
    LastMessage? lastMessage,
  }) =>
      RecentChat(
        id: id ?? this.id,
        sessionId: sessionId ?? this.sessionId,
        createdAt: createdAt ?? this.createdAt,
        lastMessage: lastMessage ?? this.lastMessage,
      );

  factory RecentChat.fromJson(Map<String, dynamic> json) => RecentChat(
        id: json["_id"],
        sessionId: json["sessionId"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        lastMessage: json["lastMessage"] == null
            ? null
            : LastMessage.fromJson(json["lastMessage"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "sessionId": sessionId,
        "createdAt": createdAt?.toIso8601String(),
        "lastMessage": lastMessage?.toJson(),
      };
}

class LastMessage {
  final String? sender;
  final String? message;
  final String? id;
  final DateTime? timestamp;

  LastMessage({
    this.sender,
    this.message,
    this.id,
    this.timestamp,
  });

  LastMessage copyWith({
    String? sender,
    String? message,
    String? id,
    DateTime? timestamp,
  }) =>
      LastMessage(
        sender: sender ?? this.sender,
        message: message ?? this.message,
        id: id ?? this.id,
        timestamp: timestamp ?? this.timestamp,
      );

  factory LastMessage.fromJson(Map<String, dynamic> json) => LastMessage(
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
