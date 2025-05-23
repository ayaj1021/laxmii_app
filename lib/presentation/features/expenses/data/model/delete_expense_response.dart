class DeleteExpenseResponse {
  final bool? status;
  final String? message;

  DeleteExpenseResponse({this.status, this.message});

  factory DeleteExpenseResponse.fromJson(Map<String, dynamic> json) {
    return DeleteExpenseResponse(
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
