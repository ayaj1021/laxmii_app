class SendReportResponse {
  final bool? status;
  final String? message;

  SendReportResponse({this.status, this.message});

  factory SendReportResponse.fromJson(Map<String, dynamic> json) {
    return SendReportResponse(
      status: json['status'] as bool?,
      message: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
    };
  }
}
