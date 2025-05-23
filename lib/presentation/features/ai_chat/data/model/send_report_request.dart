class SendReportRequest {
  final String sessionId;
  final String messageId;
  final String flagType;
  final String customMessage;

  SendReportRequest({
    required this.sessionId,
    required this.messageId,
    required this.flagType,
    required this.customMessage,
  });

  factory SendReportRequest.fromJson(Map<String, dynamic> json) {
    return SendReportRequest(
      sessionId: json['sessionId'] as String,
      messageId: json['messageId'] as String,
      flagType: json['flagType'] as String,
      customMessage: json['customMessage'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sessionId': sessionId,
      'messageId': messageId,
      'flagType': flagType,
      'customMessage': customMessage,
    };
  }
}
